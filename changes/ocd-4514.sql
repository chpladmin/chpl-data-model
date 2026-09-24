--
-- Add the Compliance Dashboard Questionable Activity report
--

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Questionable Activity',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiMjEzNTIxYWYtY2YzMC00NjIxLWE0NTktZDllNTczNDg0MzgzIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Questionable Activity',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiYzc1MTQxOWQtYWU0MS00NzNiLTgyZDAtYTlhYmNiNWY4MmJhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9', 
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Questionable Activity',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiOGVkNTBjZTQtZDgzYS00NzM1LThjY2YtNTgxNzhhMDZiNWM2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9', 
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Questionable Activity',
        'onc-dashboard', 
		'https://app.powerbi.com/view?r=eyJrIjoiZDBkYWI3NTctYTMwNy00MDA4LTgxYjUtOGJhOGY3OWM2MmMxIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '600px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ONC should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Questionable Activity' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);