-- Deployment file for version 28.6.1
--     as of 2026-05-11
-- ./changes/ocd-5224.sql
--
-- Add the new Dashboard SBUL report
-- This will fall under the onc-dashboard group which we can use later to query only those charts
--

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Service Base URL List',
        'ServiceBaseUrlList', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZTg2MTMxZDMtMGY3NS00NGY5LTlhYTEtYzU1ZDMxOTNiZjE1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Service Base URL List',
        'ServiceBaseUrlList', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiODM1Yjk4MjktZTNhYi00ZjAxLTk1NTEtOGIzYmVkMjdlNTNlIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Service Base URL List',
        'ServiceBaseUrlList', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOGJmOTMzZmMtNTY3NC00ZTAyLWEyNmEtMzUxMjUzYmEyZWU3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Service Base URL List',
        'ServiceBaseUrlList', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMmI4NWQyMWQtOGZhYy00N2I0LWE0NzItYWFhMDVkMDBmM2ZhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ONC should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'ServiceBaseUrlList' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.6.1', '2026-05-11', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
