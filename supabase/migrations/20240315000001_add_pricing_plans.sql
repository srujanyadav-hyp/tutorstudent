-- Create pricing plans table
create table pricing_plans (
  id uuid primary key default gen_random_uuid(),
  tutor_id uuid references auth.users(id) on delete cascade,
  monthly_rate decimal not null check (monthly_rate >= 0),
  description text,
  features text[] default array[]::text[],
  created_at timestamp with time zone default timezone('utc'::text, now()),
  updated_at timestamp with time zone default timezone('utc'::text, now()),
  unique (tutor_id)
);

-- RLS Policies
alter table pricing_plans enable row level security;

-- Allow tutors to manage their own pricing plans
create policy "Tutors can manage their own pricing plans"
  on pricing_plans
  using (auth.uid() = tutor_id)
  with check (auth.uid() = tutor_id);

-- Allow public to view pricing plans
create policy "Public can view pricing plans"
  on pricing_plans
  for select
  to public
  using (true);
