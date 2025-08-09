-- Create live_sessions table
create table "public"."live_sessions" (
    "id" uuid not null default uuid_generate_v4(),
    "session_id" uuid not null references "public"."class_sessions"("id") on delete cascade,
    "tutor_id" uuid not null references "public"."user_profiles"("id") on delete cascade,
    "student_id" uuid not null references "public"."user_profiles"("id") on delete cascade,
    "start_time" timestamp with time zone not null,
    "end_time" timestamp with time zone,
    "status" text not null check (status in ('waiting', 'active', 'ended', 'cancelled')),
    "whiteboard_data" text,
    "screen_share_url" text,
    "participant_states" jsonb not null default '{}',
    "active_participants" jsonb not null default '[]',
    "created_at" timestamp with time zone not null default now(),
    primary key ("id")
);

-- Set up RLS policies
alter table "public"."live_sessions" enable row level security;

create policy "Enable read access for session participants"
    on "public"."live_sessions"
    for select
    using (
        auth.uid() = tutor_id or
        auth.uid() = student_id
    );

create policy "Enable insert for tutors"
    on "public"."live_sessions"
    for insert
    with check (
        auth.uid() = tutor_id
    );

create policy "Enable update for session participants"
    on "public"."live_sessions"
    for update
    using (
        auth.uid() = tutor_id or
        auth.uid() = student_id
    );

-- Create realtime publication
alter publication supabase_realtime add table public.live_sessions;
