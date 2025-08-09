-- Create table for parent-student relationships
create table if not exists parent_students (
    id uuid primary key default gen_random_uuid(),
    parent_id uuid references user_profiles(id) not null,
    student_id uuid references user_profiles(id) not null,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    -- Ensure a student can only be linked to one parent
    unique(student_id)
);

-- Enable RLS
alter table parent_students enable row level security;

-- Create policies for parent_students table
create policy "Parents can view their linked students"
    on parent_students
    for select
    using (auth.uid() = parent_id);

create policy "Parents can link students"
    on parent_students
    for insert
    with check (auth.uid() = parent_id);

create policy "Parents can unlink their students"
    on parent_students
    for delete
    using (auth.uid() = parent_id);

-- Create an index for faster lookups
create index parent_students_parent_id_idx on parent_students(parent_id);
create index parent_students_student_id_idx on parent_students(student_id);

-- Function to automatically update updated_at
create or replace function update_parent_students_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

-- Create trigger for updated_at
create trigger parent_students_updated_at
    before update on parent_students
    for each row
    execute function update_parent_students_updated_at();
