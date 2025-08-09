-- Create chats table if it doesn't exist
create table if not exists "public"."chats" (
    "id" uuid not null default uuid_generate_v4(),
    "sender_id" uuid not null references "public"."user_profiles"("id") on delete cascade,
    "receiver_id" uuid not null references "public"."user_profiles"("id") on delete cascade,
    "message" text not null,
    "is_read" boolean not null default false,
    "attachment_url" text,
    "created_at" timestamp with time zone not null default now(),
    primary key ("id")
);

-- Set up RLS policies
alter table "public"."chats" enable row level security;

create policy "Users can read their own chats"
    on "public"."chats"
    for select
    using (
        auth.uid() = sender_id or
        auth.uid() = receiver_id
    );

create policy "Users can insert messages"
    on "public"."chats"
    for insert
    with check (
        auth.uid() = sender_id
    );

create policy "Users can update read status of received messages"
    on "public"."chats"
    for update
    using (
        auth.uid() = receiver_id and
        is_read = false
    )
    with check (
        is_read = true
    );

-- Enable realtime subscriptions
alter publication supabase_realtime add table "public"."chats";
