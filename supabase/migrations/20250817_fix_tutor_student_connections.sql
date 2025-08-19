-- Fix tutor-student connections and access policies

-- 1. Add missing RLS policies for students to access tutor materials
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'learning_materials'
      and policyname = 'Students can access their tutors materials'
  ) then
    create policy "Students can access their tutors materials"
      on learning_materials for select
      using (
        auth.uid() in (
          select student_id from student_tutor_connections 
          where tutor_id = learning_materials.tutor_id 
          and status = 'active'
        )
      );
  end if;
end
$$ language plpgsql;

-- 2. Add missing RLS policies for students to access sessions
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'class_sessions'
      and policyname = 'Students can access their tutors sessions'
  ) then
    create policy "Students can access their tutors sessions"
      on class_sessions for select
      using (
        auth.uid() in (
          select student_id from student_tutor_connections 
          where tutor_id = class_sessions.tutor_id 
          and status = 'active'
        )
      );
  end if;
end
$$ language plpgsql;

-- 3. Add missing RLS policies for students to access assignments
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'assignments'
      and policyname = 'Students can access their tutors assignments'
  ) then
    create policy "Students can access their tutors assignments"
      on assignments for select
      using (
        auth.uid() in (
          select student_id from student_tutor_connections 
          where tutor_id = assignments.tutor_id 
          and status = 'active'
        )
      );
  end if;
end
$$ language plpgsql;

-- 4. Create a table to link uploaded resources to students
create table if not exists resource_student_access (
    id uuid primary key default gen_random_uuid(),
    resource_id uuid references learning_materials(id) on delete cascade,
    student_id uuid references user_profiles(id) on delete cascade,
    tutor_id uuid references user_profiles(id) on delete cascade,
    access_granted_at timestamp with time zone default now(),
    unique(resource_id, student_id)
);

-- Enable RLS for resource_student_access
alter table resource_student_access enable row level security;

-- Policies for resource_student_access
create policy "Students can see their accessible resources"
  on resource_student_access for select
  using (auth.uid() = student_id);

create policy "Tutors can manage resource access"
  on resource_student_access for all
  using (auth.uid() = tutor_id);

-- 5. Create a table to link sessions to students (many-to-many)
create table if not exists session_student_enrollments (
    id uuid primary key default gen_random_uuid(),
    session_id uuid references class_sessions(id) on delete cascade,
    student_id uuid references user_profiles(id) on delete cascade,
    tutor_id uuid references user_profiles(id) on delete cascade,
    enrolled_at timestamp with time zone default now(),
    status text check (status in ('enrolled', 'attended', 'cancelled')) default 'enrolled',
    unique(session_id, student_id)
);

-- Enable RLS for session_student_enrollments
alter table session_student_enrollments enable row level security;

-- Policies for session_student_enrollments
create policy "Students can see their session enrollments"
  on session_student_enrollments for select
  using (auth.uid() = student_id);

create policy "Tutors can manage session enrollments"
  on session_student_enrollments for all
  using (auth.uid() = tutor_id);

-- 6. Add function to automatically enroll students in sessions
create or replace function enroll_student_in_session(
    p_session_id uuid,
    p_student_id uuid,
    p_tutor_id uuid
)
returns uuid
language plpgsql
security definer
as $$
declare
    enrollment_id uuid;
begin
    -- Check if student is connected to tutor
    if not exists (
        select 1 from student_tutor_connections
        where tutor_id = p_tutor_id 
        and student_id = p_student_id 
        and status = 'active'
    ) then
        raise exception 'Student is not connected to this tutor';
    end if;

    -- Create enrollment
    insert into session_student_enrollments (session_id, student_id, tutor_id)
    values (p_session_id, p_student_id, p_tutor_id)
    on conflict (session_id, student_id) do nothing
    returning id into enrollment_id;

    return enrollment_id;
end;
$$;

-- 7. Add function to grant resource access to students
create or replace function grant_resource_access(
    p_resource_id uuid,
    p_student_id uuid,
    p_tutor_id uuid
)
returns uuid
language plpgsql
security definer
as $$
declare
    access_id uuid;
begin
    -- Check if student is connected to tutor
    if not exists (
        select 1 from student_tutor_connections
        where tutor_id = p_tutor_id 
        and student_id = p_student_id 
        and status = 'active'
    ) then
        raise exception 'Student is not connected to this tutor';
    end if;

    -- Check if resource belongs to tutor
    if not exists (
        select 1 from learning_materials
        where id = p_resource_id and tutor_id = p_tutor_id
    ) then
        raise exception 'Resource does not belong to this tutor';
    end if;

    -- Grant access
    insert into resource_student_access (resource_id, student_id, tutor_id)
    values (p_resource_id, p_student_id, p_tutor_id)
    on conflict (resource_id, student_id) do nothing
    returning id into access_id;

    return access_id;
end;
$$;

-- 8. Add function to get student's accessible resources
create or replace function get_student_resources(p_student_id uuid)
returns table (
    resource_id uuid,
    title text,
    description text,
    file_url text,
    material_type text,
    subject text,
    grade_level text,
    tutor_name text,
    access_granted_at timestamptz
)
language sql
security definer
as $$
    select 
        lm.id as resource_id,
        lm.title,
        lm.description,
        lm.file_url,
        lm.material_type,
        lm.subject,
        lm.grade_level,
        up.full_name as tutor_name,
        rsa.access_granted_at
    from learning_materials lm
    inner join resource_student_access rsa on rsa.resource_id = lm.id
    inner join user_profiles up on up.id = lm.tutor_id
    where rsa.student_id = p_student_id
    order by rsa.access_granted_at desc;
$$;

-- 9. Add function to get student's enrolled sessions
create or replace function get_student_sessions(p_student_id uuid)
returns table (
    session_id uuid,
    title text,
    description text,
    scheduled_at timestamptz,
    video_link text,
    tutor_name text,
    enrollment_status text,
    enrolled_at timestamptz
)
language sql
security definer
as $$
    select 
        cs.id as session_id,
        cs.title,
        cs.description,
        cs.scheduled_at,
        cs.video_link,
        up.full_name as tutor_name,
        sse.status as enrollment_status,
        sse.enrolled_at
    from class_sessions cs
    inner join session_student_enrollments sse on sse.session_id = cs.id
    inner join user_profiles up on up.id = cs.tutor_id
    where sse.student_id = p_student_id
    order by cs.scheduled_at desc;
$$;

-- 10. Add function to grant resource access to all connected students
create or replace function grant_resource_access_to_all_students(
    p_resource_id uuid,
    p_tutor_id uuid
)
returns void
language plpgsql
security definer
as $$
begin
    -- Grant access to all active students
    insert into resource_student_access (resource_id, student_id, tutor_id)
    select p_resource_id, student_id, p_tutor_id
    from student_tutor_connections
    where tutor_id = p_tutor_id and status = 'active'
    on conflict (resource_id, student_id) do nothing;
end;
$$;

-- 11. Add function to enroll all students in a session
create or replace function enroll_all_students_in_session(
    p_session_id uuid,
    p_tutor_id uuid
)
returns void
language plpgsql
security definer
as $$
begin
    -- Enroll all active students
    insert into session_student_enrollments (session_id, student_id, tutor_id)
    select p_session_id, student_id, p_tutor_id
    from student_tutor_connections
    where tutor_id = p_tutor_id and status = 'active'
    on conflict (session_id, student_id) do nothing;
end;
$$;

-- 12. Create indexes for better performance
create index if not exists idx_resource_student_access_student_id on resource_student_access(student_id);
create index if not exists idx_resource_student_access_tutor_id on resource_student_access(tutor_id);
create index if not exists idx_session_student_enrollments_student_id on session_student_enrollments(student_id);
create index if not exists idx_session_student_enrollments_tutor_id on session_student_enrollments(tutor_id);
create index if not exists idx_session_student_enrollments_session_id on session_student_enrollments(session_id);
