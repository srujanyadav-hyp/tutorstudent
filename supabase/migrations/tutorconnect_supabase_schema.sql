
-- ============================
-- Table: user_profiles
-- ============================
create table if not exists user_profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    full_name text not null,
    role text check (role in ('tutor', 'student', 'parent')) not null,
    email text not null,
    phone text,
    bio text,
    profile_image text,
    role_specific_data jsonb,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

-- Enable RLS
alter table user_profiles enable row level security;

-- Policies for user_profiles
create policy "Allow user to access their profile"
  on user_profiles for all
  using (auth.uid() = id);

-- ============================
-- Table: students
-- ============================
create table if not exists students (
    id uuid primary key references user_profiles(id) on delete cascade,
    grade text,
    subjects text[],
    parent_id uuid references user_profiles(id),
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

alter table students enable row level security;

create policy "Students can see/edit themselves"
  on students for all
  using (auth.uid() = id);

-- ============================
-- Table: student_tutor_connections
-- ============================
create table if not exists student_tutor_connections (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    student_id uuid references user_profiles(id),
    grade text,
    subjects text,
    status text check (status in ('active', 'inactive')) default 'active',
    connected_at timestamp with time zone default now(),
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);

alter table student_tutor_connections enable row level security;

create policy "Tutors can manage their connections"
  on student_tutor_connections for all
  using (auth.uid() = tutor_id or auth.uid() = student_id);

create policy "Students can see/edit themselves"
  on students for all
  using (auth.uid() = id);

-- ============================
-- Table: assignments
-- ============================
create table if not exists assignments (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    title text not null,
    description text,
    due_date timestamp with time zone,
    created_at timestamp with time zone default now()
);

alter table assignments enable row level security;

create policy "Tutors can manage their assignments"
  on assignments for all
  using (auth.uid() = tutor_id);

-- ============================
-- Table: assignment_submissions
-- ============================
create table if not exists assignment_submissions (
    id uuid primary key default gen_random_uuid(),
    assignment_id uuid references assignments(id) on delete cascade,
    student_id uuid references user_profiles(id),
    submitted_file text,
    submitted_at timestamp with time zone default now(),
    grade text,
    feedback text
);

alter table assignment_submissions enable row level security;

create policy "Students can submit their own assignments"
  on assignment_submissions for all
  using (auth.uid() = student_id);

-- ============================
-- Table: class_sessions
-- ============================
create table if not exists class_sessions (
    id uuid primary key default gen_random_uuid(),
    tutor_id uuid references user_profiles(id),
    title text,
    description text,
    scheduled_at timestamp with time zone,
    video_link text,
    created_at timestamp with time zone default now()
);

alter table class_sessions enable row level security;

create policy "Tutors can manage their sessions"
  on class_sessions for all
  using (auth.uid() = tutor_id);

-- ============================
-- Table: student_class_attendance
-- ============================
create table if not exists student_class_attendance (
    id uuid primary key default gen_random_uuid(),
    session_id uuid references class_sessions(id) on delete cascade,
    student_id uuid references user_profiles(id),
    joined_at timestamp with time zone default now()
);

alter table student_class_attendance enable row level security;

create policy "Students can access their attendance"
  on student_class_attendance for all
  using (auth.uid() = student_id);

-- ============================
-- Table: messages
-- ============================
create table if not exists messages (
    id uuid primary key default gen_random_uuid(),
    sender_id uuid references user_profiles(id),
    receiver_id uuid references user_profiles(id),
    message text,
    sent_at timestamp with time zone default now(),
    seen boolean default false
);

alter table messages enable row level security;

create policy "Users can access their messages"
  on messages for all
  using (auth.uid() = sender_id or auth.uid() = receiver_id);

-- ============================
-- Table: billing
-- ============================
create table if not exists billing (
    id uuid primary key default gen_random_uuid(),
    parent_id uuid references user_profiles(id),
    student_id uuid references user_profiles(id),
    amount numeric,
    due_date timestamp with time zone,
    status text check (status in ('paid', 'pending', 'overdue')),
    invoice_url text
);

alter table billing enable row level security;

create policy "Parents can see their own billing"
  on billing for all
  using (auth.uid() = parent_id);

-- ============================
-- Table: learning_insights (future)
-- ============================
create table if not exists learning_insights (
    id uuid primary key default gen_random_uuid(),
    student_id uuid references user_profiles(id),
    insight_type text,
    value jsonb,
    created_at timestamp with time zone default now()
);

alter table learning_insights enable row level security;

create policy "Students can see their own insights"
  on learning_insights for all
  using (auth.uid() = student_id);
