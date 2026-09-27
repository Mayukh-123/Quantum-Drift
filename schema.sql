-- ============================================
-- Delivery Partner Management System — schema
-- Run this in Supabase: SQL Editor > New query
-- ============================================

-- 1. Delivery partners (riders)
create table partners (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text not null,
  email text not null,
  vehicle_type text not null,
  city text not null,
  status text not null default 'Available',
  joined_at timestamptz not null default now()
);

-- 2. Deliveries assigned to a partner
create table deliveries (
  id uuid primary key default gen_random_uuid(),
  partner_id uuid references partners(id) on delete set null,
  customer_name text not null,
  customer_phone text not null,
  pickup_address text not null,
  drop_address text not null,
  status text not null default 'Pending',
  created_at timestamptz not null default now()
);

create index idx_deliveries_partner_id on deliveries(partner_id);

-- 3. View: each partner's current active workload
create view partner_workload as
select
  p.*,
  coalesce(d.active_count, 0) as active_deliveries
from partners p
left join (
  select partner_id, count(*) as active_count
  from deliveries
  where status in ('Pending', 'Assigned', 'Picked Up')
  group by partner_id
) d on d.partner_id = p.id;

-- 4. Row Level Security — public demo access
alter table partners enable row level security;
alter table deliveries enable row level security;

create policy "Public can view partners" on partners for select using (true);
create policy "Public can add partners" on partners for insert with check (true);

create policy "Public can view deliveries" on deliveries for select using (true);
create policy "Public can add deliveries" on deliveries for insert with check (true);

-- 5. Seed data
insert into partners (name, phone, email, vehicle_type, city, status) values
('Rohan Kadam', '9876543210', 'rohan.kadam@example.com', 'Bike', 'Mumbai', 'Available'),
('Sneha Iyer', '9876501234', 'sneha.iyer@example.com', 'Scooter', 'Mumbai', 'Available'),
('Imran Sheikh', '9876512345', 'imran.sheikh@example.com', 'Van', 'Thane', 'Available');
