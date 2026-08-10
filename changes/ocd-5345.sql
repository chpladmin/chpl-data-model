--
-- Add the Compliance Dashboard Direct Review report
-- This will fall under the onc-dashboard group which we can use later to query only those charts
--

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Direct Review Non-conformities',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiZjRkYTBjNzctZTcwMy00MjNmLTk3NWEtYzQ3NmY1NzVjZjMyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Direct Review Non-conformities',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiNDUzNDM0NjAtOTU3OS00Yzg0LWJkYTctYTQwOTI0NTRmNmMyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9', 
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Direct Review Non-conformities',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiNzA2ZTIwMDMtYTk5YS00NjU2LTgzMjEtY2I5M2Q3ODc2NDIwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9', 
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Direct Review Non-conformities',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiMmRmMzQ0N2YtMDY2My00OGFkLWJlZWYtZGRkZTQ1ZTRkOGRkIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ONC should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Direct Review Non-conformities' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);