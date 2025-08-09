-- Create bucket for chat attachments
insert into storage.buckets (id, name, public)
values ('chat_attachments', 'chat_attachments', true);

-- Allow authenticated users to upload files
create policy "Allow authenticated users to upload files"
  on storage.objects for insert
  to authenticated
  with check (
    bucket_id = 'chat_attachments' and
    auth.role() = 'authenticated'
  );

-- Allow access to public files
create policy "Allow public access to chat attachments"
  on storage.objects for select
  to public
  using (bucket_id = 'chat_attachments');
