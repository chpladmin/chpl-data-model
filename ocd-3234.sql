alter table openchpl.vendor drop column if exists self_developer cascade;
alter table openchpl.vendor add column self_developer bool not null default false;
