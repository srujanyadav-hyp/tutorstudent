-- Fix RLS policies for student linking functionality

-- Drop existing restrictive policies
drop policy if exists "Students can see/edit themselves" on students;

-- Create new policies that allow proper linking
create policy "Students can see/edit themselves"
  on students for all
  using (auth.uid() = id);

create policy "Parents can link students"
  on students for update
  using (auth.uid() = parent_id);

create policy "Parents can view linked students"
  on students for select
  using (auth.uid() = parent_id);

-- Also fix the duplicate policy on student_tutor_connections
drop policy if exists "Students can see/edit themselves" on student_tutor_connections;

-- Drop existing policies on student_tutor_connections to recreate them properly
drop policy if exists "Tutors can manage their connections" on student_tutor_connections;

-- Create proper policies for student_tutor_connections
create policy "Tutors can manage their connections"
  on student_tutor_connections for all
  using (auth.uid() = tutor_id);

create policy "Students can view their connections"
  on student_tutor_connections for select
  using (auth.uid() = student_id);

-- Add policy for user_profiles to allow email lookup for linking
drop policy if exists "Allow email lookup for linking" on user_profiles;
create policy "Allow email lookup for linking"
  on user_profiles for select
  using (true);

-- Add insert policy for students table to allow parent linking
create policy "Parents can insert student records"
  on students for insert
  with check (auth.uid() = parent_id);
