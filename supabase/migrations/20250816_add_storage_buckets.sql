-- Create profile-assets bucket
insert into storage.buckets (id, name, public)
values ('profile-assets', 'profile-assets', true)
on conflict (id) do nothing;

-- Allow authenticated users to upload their own profile images
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Allow authenticated users to upload profile images'
  ) then
    create policy "Allow authenticated users to upload profile images"
      on storage.objects for insert
      to authenticated
      with check (
        bucket_id = 'profile-assets' 
        and (storage.foldername(name))[1] = 'profile_images'
        and storage.filename(name) like auth.uid() || '_%'
      );
  end if;
end
$$ language plpgsql;

-- Allow public read access to profile images
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Public read access to profile images'
  ) then
    create policy "Public read access to profile images"
      on storage.objects for select
      to public
      using (bucket_id = 'profile-assets');
  end if;
end
$$ language plpgsql;

-- Add RLS for updating/deleting profile images
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'storage'
      and tablename = 'objects'
      and policyname = 'Users can manage their own profile images'
  ) then
    create policy "Users can manage their own profile images"
      on storage.objects for all 
      using (
        bucket_id = 'profile-assets'
        and auth.uid()::text = (storage.foldername(name))[1]
      );
  end if;
end
$$ language plpgsql;
