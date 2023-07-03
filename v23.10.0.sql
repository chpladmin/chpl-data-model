-- Deployment file for version 23.10.0
--     as of 2023-07-03
-- ./changes/ocd-4200.sql
ALTER TABLE openchpl.change_request_attestation_submission_response
ADD COLUMN IF NOT EXISTS response_message text;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.10.0', '2023-07-03', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
