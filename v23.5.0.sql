-- Deployment file for version 23.5.0
--     as of 2023-05-01
-- ./changes/ocd-4064.sql
ALTER TABLE openchpl.listing_validation_report
DROP COLUMN IF EXISTS listing_modified_date;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.5.0', '2023-05-01', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
