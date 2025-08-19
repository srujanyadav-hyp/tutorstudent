-- Create tutor-resources bucket
insert into storage.buckets (id, name, public)
values ('tutor-resources', 'tutor-resources', true)
on conflict (id) do nothing;

-- Allow authenticated users to upload tutor resources
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Allow authenticated users to upload tutor resources'
  ) then
    create policy "Allow authenticated users to upload tutor resources"
      on storage.objects for insert
      to authenticated
      with check (
        bucket_id = 'tutor-resources' and auth.role() = 'authenticated'
      );
  end if;
end
$$ language plpgsql;

-- Allow public read access to tutor resources
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Public read access to tutor resources'
  ) then
    create policy "Public read access to tutor resources"
      on storage.objects for select
      to public
      using (bucket_id = 'tutor-resources');
  end if;
end
$$ language plpgsql;

-- Allow tutors to manage their own resources
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Tutors can manage their own resources'
  ) then
    create policy "Tutors can manage their own resources"
      on storage.objects for all 
      using (
        bucket_id = 'tutor-resources'
        and auth.uid()::text = (storage.foldername(name))[1]
      );
  end if;
end
$$ language plpgsql;
