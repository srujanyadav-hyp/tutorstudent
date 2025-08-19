-- Create session bookings table
create table session_bookings (
  id uuid primary key default gen_random_uuid(),
  student_id uuid references auth.users(id) on delete cascade,
  tutor_id uuid references auth.users(id) on delete cascade,
  start_time timestamp with time zone not null,
  end_time timestamp with time zone not null,
  topic text,
  notes text,
  status text not null check (status in ('pending', 'confirmed', 'cancelled', 'completed')) default 'pending',
  created_at timestamp with time zone default timezone('utc'::text, now()),
  updated_at timestamp with time zone,
  check (end_time > start_time)
);

-- RLS Policies
alter table session_bookings enable row level security;

-- Students can create bookings and view their own bookings
create policy "Students can manage their bookings"
  on session_bookings
  using (auth.uid() = student_id);

-- Tutors can view and update bookings they're involved in
create policy "Tutors can manage their bookings"
  on session_bookings
  using (auth.uid() = tutor_id);
