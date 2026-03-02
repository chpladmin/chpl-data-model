-- Deployment file for version 28.4.0
--     as of 2026-03-02
-- ./changes/ocd-5135.sql
UPDATE openchpl.certification_result_test_standard
SET deleted = true, last_modified_user = NULL, last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE certification_result_test_standard_id IN (13868,13869,13870);
;
-- ./changes/ocd-5153.sql
ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g7 boolean;

ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g9 boolean;

ALTER TABLE openchpl.attestation_checkin_report
ADD COLUMN IF NOT EXISTS attests_g10 boolean;

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.4.0', '2026-03-02', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
