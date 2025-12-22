-- Deployment file for version 28.3.0
--     as of 2025-12-22
-- ./changes/ocd-5058.sql
UPDATE openchpl.report_metadata 
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiZTQzYzU0OTQtNTQ0Zi00MGZiLWEyYTEtYzEwNzFjMzIwYTc3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'DEV'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata 
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiOTY4MzI1YTUtOTYzOC00YmNhLWFhMjgtMjg2NTU2MWM4MDVlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'QA'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata 
SET url = 'https://app.powerbi.com/view?r=eyJrIjoiYmNiNDVmMTQtNTQ1Yy00MTczLWI5MDMtNGJlNzYwOGQyMTZjIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'STG'
AND report_key = 'UpdatedCriteriaStatus';

UPDATE openchpl.report_metadata 
SET url = 
'https://app.powerbi.com/view?r=eyJrIjoiNDBiZTllZTAtMzMzYi00ZjFkLTlhZGQtNGEyYzRiZTdjZDgzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9'
WHERE environment = 'PROD'
AND report_key = 'UpdatedCriteriaStatus';
;
-- ./changes/ocd-5059.sql
--
-- Add "Required Standard From Group Not Attested" reason
--
INSERT INTO openchpl.criterion_not_up_to_date_reason (name, last_modified_sso_user)
SELECT 'Required Standard From Group Not Attested', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
    SELECT 1
    FROM openchpl.criterion_not_up_to_date_reason
    WHERE name = 'Required Standard From Group Not Attested'
);

--
-- Add column to store standard group name
--
ALTER TABLE openchpl.updated_criterion_status_report ADD COLUMN IF NOT EXISTS standard_group_name text;

--
-- Add column to store required date
--
ALTER TABLE openchpl.updated_criterion_status_report ADD COLUMN IF NOT EXISTS required_day date;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.3.0', '2025-12-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
