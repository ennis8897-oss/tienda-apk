-- Ejecutá TODO este archivo en Supabase > SQL Editor.
create table if not exists public.apps (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  version text default '1.0',
  description text default '',
  file_url text not null,
  file_path text not null,
  published boolean default true,
  created_by uuid references auth.users(id),
  created_at timestamptz default now()
);

alter table public.apps enable row level security;

create policy "Public can read published apps"
on public.apps for select
using (published = true or auth.uid() = created_by);

create policy "Authenticated users can insert apps"
on public.apps for insert
to authenticated
with check (auth.uid() = created_by);

create policy "Owners can delete apps"
on public.apps for delete
to authenticated
using (auth.uid() = created_by);

insert into storage.buckets (id,name,public)
values ('apks','apks',true)
on conflict (id) do nothing;

create policy "Authenticated can upload APKs"
on storage.objects for insert
to authenticated
with check (bucket_id = 'apks');

create policy "Public can download APKs"
on storage.objects for select
using (bucket_id = 'apks');

create policy "Authenticated can delete APKs"
on storage.objects for delete
to authenticated
using (bucket_id = 'apks');
