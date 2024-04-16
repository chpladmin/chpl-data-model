alter table openchpl.user_invitation add column if not exists group_name text;
alter table openchpl.user_invitation add column if not exists organization_id bigint;

