-- Deployment file for version 24.10.0
--     as of 2024-05-14
-- ./changes/ocd-3907.sql
-- no references to this view in the code
DROP VIEW IF EXISTS openchpl.listings_from_banned_developers;

-- dropping these views because they reference the vendor table
-- and i can't delete the column below with them present
DROP VIEW IF EXISTS openchpl.developer_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.developer_certification_body_map;
DROP VIEW IF EXISTS openchpl.questionable_activity_combined;
DROP VIEW IF EXISTS openchpl.rwt_plans_by_developer;
DROP VIEW IF EXISTS openchpl.rwt_results_by_developer;
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.listing_search;

-- we originally stored only a single "current" status for developers
-- but a long time ago we changed to use a status history type of table 
-- and this PR also removes any remaining references to this column
ALTER TABLE openchpl.vendor DROP COLUMN IF EXISTS vendor_status_id;;
-- ./changes/ocd-4491.sql
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
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.10.0', '2024-05-14', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
