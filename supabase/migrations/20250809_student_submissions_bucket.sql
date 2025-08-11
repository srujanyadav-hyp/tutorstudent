-- Create bucket for student submissions (id: student-submissions)
insert into storage.buckets (id, name, public)
values ('student-submissions', 'student-submissions', true)
on conflict (id) do nothing;

-- Allow authenticated users to upload files into the bucket
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Allow authenticated users to upload student submissions'
  ) then
    create policy "Allow authenticated users to upload student submissions"
      on storage.objects for insert
      to authenticated
      with check (
        bucket_id = 'student-submissions' and auth.role() = 'authenticated'
      );
  end if;
end
$$ language plpgsql;

-- Allow public read access to the submissions (or tighten later)
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Public read access to student submissions'
  ) then
    create policy "Public read access to student submissions"
      on storage.objects for select
      to public
      using (bucket_id = 'student-submissions');
  end if;
end
$$ language plpgsql;


