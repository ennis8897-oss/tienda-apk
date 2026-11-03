-- Ejecutar completo en Supabase > SQL Editor > New query.
create extension if not exists pgcrypto;
create table if not exists public.apps (
 id uuid primary key default gen_random_uuid(),
 name text not null,
 version text not null default '1.0',
 description text not null default '',
 file_url text not null,
 file_path text,
 published boolean not null default true,
 created_by uuid references auth.users(id) on delete set null,
 created_at timestamptz not null default now()
);
alter table public.apps enable row level security;
drop policy if exists "Public can read published apps" on public.apps;
create policy "Public can read published apps" on public.apps for select to anon, authenticated using (published = true);
drop policy if exists "Authenticated admins can insert apps" on public.apps;
create policy "Authenticated admins can insert apps" on public.apps for insert to authenticated with check (auth.uid() = created_by);
drop policy if exists "Authenticated admins can delete own apps" on public.apps;
create policy "Authenticated admins can delete own apps" on public.apps for delete to authenticated using (auth.uid() = created_by);
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('apks','apks',true,52428800,array['application/vnd.android.package-archive','application/octet-stream'])
on conflict (id) do update set public=true,file_size_limit=52428800,allowed_mime_types=excluded.allowed_mime_types;
drop policy if exists "Public can download APKs" on storage.objects;
create policy "Public can download APKs" on storage.objects for select to anon,authenticated using (bucket_id='apks');
drop policy if exists "Authenticated users can upload APKs" on storage.objects;
create policy "Authenticated users can upload APKs" on storage.objects for insert to authenticated with check (bucket_id='apks' and (storage.foldername(name))[1]=auth.uid()::text and storage.extension(name)='apk');
drop policy if exists "Authenticated users can delete APKs" on storage.objects;
create policy "Authenticated users can delete APKs" on storage.objects for delete to authenticated using (bucket_id='apks' and (storage.foldername(name))[1]=auth.uid()::text);
