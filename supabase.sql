-- VIGENTRA PRO — schéma Supabase (à exécuter dans SQL Editor)
-- À exécuter sur un nouveau projet ou après vérification de l'absence de tables homonymes.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  role text not null default 'agent' check (role in ('manager','agent')),
  created_at timestamptz not null default now()
);
create table if not exists public.agents (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid unique references public.profiles(id) on delete set null,
  full_name text not null,
  email text,
  qualifications text[] not null default '{}',
  card_expiry date,
  created_at timestamptz not null default now()
);
create table if not exists public.sites (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  client_name text,
  address text,
  hourly_rate numeric(10,2) not null default 0,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
create table if not exists public.shifts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  shift_date date not null,
  site_id uuid references public.sites(id) on delete set null,
  agent_id uuid references public.agents(id) on delete set null,
  start_time time not null,
  end_time time not null,
  status text not null default 'planifiee',
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);
create table if not exists public.time_entries (
  id uuid primary key default gen_random_uuid(),
  shift_id uuid not null references public.shifts(id) on delete cascade,
  agent_id uuid not null references public.agents(id) on delete cascade,
  clock_in timestamptz,
  clock_out timestamptz,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);
create table if not exists public.invoices (
  id uuid primary key default gen_random_uuid(),
  invoice_number text not null unique,
  client_name text not null,
  issue_date date not null,
  due_date date,
  total_ttc numeric(12,2) not null default 0,
  status text not null default 'Brouillon',
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- Crée automatiquement un profil agent lors d'une inscription.
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, full_name, role)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''), 'agent')
  on conflict (id) do nothing;
  return new;
end;
$$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();

create or replace function public.is_manager()
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists(select 1 from public.profiles p where p.id = auth.uid() and p.role = 'manager');
$$;
create or replace function public.my_agent_id()
returns uuid language sql stable security definer set search_path = ''
as $$
  select a.id from public.agents a where a.profile_id = auth.uid() limit 1;
$$;

alter table public.profiles enable row level security;
alter table public.agents enable row level security;
alter table public.sites enable row level security;
alter table public.shifts enable row level security;
alter table public.time_entries enable row level security;
alter table public.invoices enable row level security;

-- Profils : chaque utilisateur lit son profil ; le responsable peut lire tous les profils.
drop policy if exists "profiles read self or manager" on public.profiles;
create policy "profiles read self or manager" on public.profiles for select to authenticated
using (id = auth.uid() or public.is_manager());
-- Les utilisateurs ne peuvent pas modifier leur rôle eux-mêmes.
drop policy if exists "profiles update self safe" on public.profiles;
create policy "profiles update self safe" on public.profiles for update to authenticated
using (id = auth.uid() or public.is_manager())
with check (id = auth.uid() or public.is_manager());

-- Agents : le responsable gère tout ; l'agent ne voit que sa propre fiche.
drop policy if exists "agents manager all" on public.agents;
create policy "agents manager all" on public.agents for all to authenticated
using (public.is_manager()) with check (public.is_manager());
drop policy if exists "agents self read" on public.agents;
create policy "agents self read" on public.agents for select to authenticated
using (profile_id = auth.uid());

-- Sites : lecture des agents autorisée pour afficher leurs vacations ; écriture responsable uniquement.
drop policy if exists "sites authenticated read" on public.sites;
create policy "sites authenticated read" on public.sites for select to authenticated using (true);
drop policy if exists "sites manager write" on public.sites;
create policy "sites manager write" on public.sites for all to authenticated
using (public.is_manager()) with check (public.is_manager());

-- Planning : les agents lisent uniquement leurs vacations ; responsable gère tout.
drop policy if exists "shifts manager all" on public.shifts;
create policy "shifts manager all" on public.shifts for all to authenticated
using (public.is_manager()) with check (public.is_manager());
drop policy if exists "shifts assigned agent read" on public.shifts;
create policy "shifts assigned agent read" on public.shifts for select to authenticated
using (agent_id = public.my_agent_id());

-- Pointages : responsable gère tout ; agent ne lit/insère/modifie que ses pointages.
drop policy if exists "time manager all" on public.time_entries;
create policy "time manager all" on public.time_entries for all to authenticated
using (public.is_manager()) with check (public.is_manager());
drop policy if exists "time agent read" on public.time_entries;
create policy "time agent read" on public.time_entries for select to authenticated
using (agent_id = public.my_agent_id());
drop policy if exists "time agent insert" on public.time_entries;
create policy "time agent insert" on public.time_entries for insert to authenticated
with check (agent_id = public.my_agent_id());
drop policy if exists "time agent update" on public.time_entries;
create policy "time agent update" on public.time_entries for update to authenticated
using (agent_id = public.my_agent_id()) with check (agent_id = public.my_agent_id());

-- Factures : visibles et modifiables par le responsable uniquement.
drop policy if exists "invoices manager all" on public.invoices;
create policy "invoices manager all" on public.invoices for all to authenticated
using (public.is_manager()) with check (public.is_manager());

-- IMPORTANT : après votre première inscription, trouvez votre UUID dans Authentication > Users.
-- Puis exécutez cette requête en remplaçant UUID_DU_RESPONSABLE :
-- update public.profiles set role='manager', full_name='Responsable VIGENTRA' where id='UUID_DU_RESPONSABLE';
-- Pour lier un agent à son compte, utilisez le profile_id du profil correspondant :
-- update public.agents set profile_id='UUID_DU_COMPTE_AGENT' where id='UUID_DE_LA_FICHE_AGENT';
