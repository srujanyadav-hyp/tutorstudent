-- Create subject_progress table
create table if not exists subject_progress (
    id uuid primary key default gen_random_uuid(),
    student_id uuid references user_profiles(id) on delete cascade,
    subject text not null,
    progress numeric check (progress >= 0 and progress <= 100) default 0,
    last_updated timestamp with time zone default now(),
    created_at timestamp with time zone default now(),
    unique(student_id, subject)
);

-- Enable RLS
alter table subject_progress enable row level security;

-- Policies for subject_progress
create policy "Students can see their own progress"
  on subject_progress for select
  using (auth.uid() = student_id);

create policy "Tutors can see their students' progress"
  on subject_progress for select
  using (
    auth.uid() in (
      select tutor_id from student_tutor_connections 
      where student_id = subject_progress.student_id 
      and status = 'active'
    )
  );

create policy "Tutors can update their students' progress"
  on subject_progress for update
  using (
    auth.uid() in (
      select tutor_id from student_tutor_connections 
      where student_id = subject_progress.student_id 
      and status = 'active'
    )
  );

create policy "Tutors can insert progress for their students"
  on subject_progress for insert
  with check (
    auth.uid() in (
      select tutor_id from student_tutor_connections 
      where student_id = subject_progress.student_id 
      and status = 'active'
    )
  );

-- Create index for better performance
create index if not exists idx_subject_progress_student_id on subject_progress(student_id);
create index if not exists idx_subject_progress_subject on subject_progress(subject);
