-- Add column for user group name
alter table openchpl.change_request_status add column if not exists user_group_name text;

-- Temporarily set the field to be nullable (only applies if the column was not just created
alter table openchpl.change_request_status alter column user_group_name drop not null;

-- Populate the new column used on the user_permission_id column
update openchpl.change_request_status crs
set user_group_name =
    (select authority
    from openchpl.user_permission
    where user_permission_id = crs.user_permission_id)
where user_permission_id is not null;

-- Make user group name column "not null"
alter table openchpl.change_request_status alter column user_group_name set not null;

-- Drop the "not null" constraint for  user permission id, since it will no longer be used
alter table openchpl.change_request_status alter column user_permission_id drop not null;
