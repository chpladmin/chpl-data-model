--
-- Add report metadata for the new dashboard report in all environments
--

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Non-Conformities',
        'DashboardNonconformities', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiN2U5NjMxMTQtYzcwNS00YzQwLThhYzAtZThiNjc3Mzg0NDI4IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Non-Conformities',
        'DashboardNonconformities', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYTU3NDgzY2YtYTQwZS00ZmU4LTg4Y2ItYzU2NDM1MmQwOGI5IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Non-Conformities',
        'DashboardNonconformities', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZTFjNzI2NTYtNzM5MC00YmNkLTk4ODQtMTk1NzQyMTQ5NDdkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Non-Conformities',
        'DashboardNonconformities', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMGMwZjU2NmEtMzY1Zi00NWZlLWE5MDItYzU4ZmQzNTQyNTM1IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ONC should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardNonconformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);