-- Functions for managing parent-student relationships

-- Function to get students linked to a parent
create or replace function get_parent_students(parent_uuid uuid)
returns table (
  id uuid,
  student_id uuid,
  student_name text,
  grade text,
  profile_image text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public
as $$
begin
  return query
    select 
      ps.id,
      p.id as student_id,
      p.full_name as student_name,
      p.grade,
      p.profile_image,
      ps.created_at
    from parent_students ps
    join profiles p on p.id = ps.student_id
    where ps.parent_id = parent_uuid
    order by ps.created_at desc;
end;
$$;

-- Function to link a student to a parent
create or replace function link_student(
  parent_uuid uuid,
  student_email text
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  student_uuid uuid;
  link_id uuid;
begin
  -- Get student UUID from email
  select id into student_uuid
  from profiles
  where email = student_email and role = 'student';

  if student_uuid is null then
    raise exception 'Student not found';
  end if;

  -- Check if already linked
  if exists (
    select 1 from parent_students
    where parent_id = parent_uuid and student_id = student_uuid
  ) then
    raise exception 'Student already linked to this parent';
  end if;

  -- Create link
  insert into parent_students (parent_id, student_id)
  values (parent_uuid, student_uuid)
  returning id into link_id;

  return link_id;
end;
$$;

-- Function to unlink a student from a parent
create or replace function unlink_student(
  parent_uuid uuid,
  student_uuid uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from parent_students
  where parent_id = parent_uuid and student_id = student_uuid;

  if not found then
    raise exception 'Student not found or not linked to this parent';
  end if;
end;
$$;
