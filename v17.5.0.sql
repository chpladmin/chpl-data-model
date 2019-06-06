-- Deployment file for version 17.5.0
--     as of 2019-06-03
-- ocd-2885.sql
DROP SCHEMA IF EXISTS ff4j CASCADE;

\i dev/openchpl_ff4j.sql
;
-- ocd-2683-part2.sql
---------------------------------------
-- OCD-2683
-- Step 2
-- Drop the ACL backup tables
---------------------------------------

DROP TABLE IF EXISTS openchpl.acl_object_identity_backup_for_atl;
DROP TABLE IF EXISTS openchpl.acl_class_backup_for_atl;
DROP TABLE IF EXISTS openchpl.acl_entry_backup_for_atl;;
-- ocd-2818-part2.sql
--
-- OCD-2818 part 2 - drop tables no longer used
--
DROP TABLE IF EXISTS openchpl.global_user_permission_map;
DROP TABLE IF EXISTS openchpl.invited_user_permission;
ALTER TABLE openchpl.invited_user DROP COLUMN certification_body_id;
ALTER TABLE openchpl.invited_user DROP COLUMN testing_lab_id;;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.5.0', '2019-06-03', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
