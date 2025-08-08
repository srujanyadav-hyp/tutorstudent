-- ============================
-- Table: tutor_availability
-- ============================
create table if not exists tutor_availability (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    day_of_week integer check (day_of_week between 0 and 6),
    start_time time,
    end_time time,
    is_recurring boolean default true,
    specific_date date,
    created_at timestamp with time zone default now()
);

alter table tutor_availability enable row level security;
create policy "Tutors can manage their availability"
  on tutor_availability for all
  using (auth.uid() = tutor_id);

-- ============================
-- Table: session_bookings
-- ============================
create table if not exists session_bookings (
    id uuid primary key default gen_random_uuid(),
    session_id uuid references class_sessions(id),
    student_id uuid references user_profiles(id),
    status text check (status in ('pending', 'confirmed', 'cancelled', 'completed')) default 'pending',
    payment_status text check (payment_status in ('pending', 'paid', 'refunded')) default 'pending',
    amount numeric,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

alter table session_bookings enable row level security;
create policy "Students can see their bookings"
  on session_bookings for all using (
    auth.uid() = student_id
    or auth.uid() in (
      select id from user_profiles where id in (
        select tutor_id from class_sessions where id = session_bookings.session_id
      )
    )
  );

-- ============================
-- Table: tutor_subjects
-- ============================
create table if not exists tutor_subjects (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    subject_name text not null,
    grade_level text,
    hourly_rate numeric,
    created_at timestamp with time zone default now()
);

alter table tutor_subjects enable row level security;
create policy "Tutors can manage their subjects"
  on tutor_subjects for all
  using (auth.uid() = tutor_id);

-- ============================
-- Table: tutor_reviews
-- ============================
create table if not exists tutor_reviews (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    reviewer_id uuid references user_profiles(id),
    session_id uuid references class_sessions(id),
    rating integer check (rating between 1 and 5),
    review_text text,
    created_at timestamp with time zone default now()
);

alter table tutor_reviews enable row level security;
create policy "Users can see reviews, tutors can see their reviews"
  on tutor_reviews for select
  using (true);
create policy "Users can create reviews for attended sessions"
  on tutor_reviews for insert
  with check (
    auth.uid() = reviewer_id
    and exists (
      select 1 from student_class_attendance
      where session_id = tutor_reviews.session_id
      and student_id = reviewer_id
    )
  );

-- ============================
-- Table: notifications
-- ============================
create table if not exists notifications (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references user_profiles(id),
    title text not null,
    message text not null,
    type text check (type in ('booking', 'message', 'assignment', 'payment', 'system')),
    read boolean default false,
    action_data jsonb,
    created_at timestamp with time zone default now()
);

alter table notifications enable row level security;
create policy "Users can see their notifications"
  on notifications for all
  using (auth.uid() = user_id);

-- ============================
-- Table: learning_materials
-- ============================
create table if not exists learning_materials (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    title text not null,
    description text,
    file_url text,
    material_type text check (material_type in ('document', 'video', 'link', 'other')),
    subject text,
    grade_level text,
    created_at timestamp with time zone default now()
);

alter table learning_materials enable row level security;
create policy "Tutors can manage their materials"
  on learning_materials for all
  using (auth.uid() = tutor_id);

-- ============================
-- Table: parent_student_links
-- ============================
create table if not exists parent_student_links (
    id uuid primary key default gen_random_uuid(),
    parent_id uuid references user_profiles(id),
    student_id uuid references user_profiles(id),
    created_at timestamp with time zone default now(),
    unique(parent_id, student_id)
);

alter table parent_student_links enable row level security;
create policy "Parents can see their linked students"
  on parent_student_links for all
  using (auth.uid() = parent_id);

-- Add trigger for updated_at on session_bookings
create or replace function update_session_bookings_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

create trigger update_session_bookings_updated_at_trigger
    before update on session_bookings
    for each row
    execute function update_session_bookings_updated_at();
