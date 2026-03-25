-- 
-- Add the report_group column back in because we actually have a use for it
--
ALTER TABLE openchpl.report_metadata ADD COLUMN IF NOT EXISTS report_group text;

--
-- Set all existing reports to have the 'charts' grouping
--
UPDATE openchpl.report_metadata SET report_group = 'charts' WHERE report_group IS NULL;


--
-- Add the new ASTP Questionable URLs report
-- This will fall under the astp-dashboard group which we can use later to query only those charts
--

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Questionable URLs',
        'QuestionableUrls', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZGUwYjk5NzYtYzI2NS00MWU1LTgyYzEtOGI0ZjdjODU3ODM2IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '325px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Questionable URLs',
        'QuestionableUrls', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYmZiMzQyODYtMGQ4OS00N2MzLTlhZWItNTUxMDkxMjg5MWVmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '325px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Questionable URLs',
        'QuestionableUrls', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZWMzYjM2MjAtYzVhMy00MGVhLTg5OGYtYjM5Y2Q3ZWVhZjQyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '325px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Questionable URLs',
        'QuestionableUrls', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiMGZlNmZjZTctMWI0Mi00YjNhLTk5MmEtZjRmMDVlZTQxYjY3IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '325px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ASTP should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'QuestionableUrls' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);


--
-- Add the new ASTP Developer Attestations report
-- This will fall under the astp-dashboard group which we can use later to query only those charts
--

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZTcxYTAzMzgtOTFhYi00YTRhLThjZjItZGY3ZmQwYzYzMDlhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '525px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYjYwYTQ1YjAtMGQ1ZC00ZGEzLWJjOTktZmVhMjM5YzcxNTljIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '525px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'  
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYjFhMTA3ZWItZDlmOS00NjdkLWE3ZWEtMmNiZWRmOTQ3ZGMyIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '525px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Developer Attestations',
        'DeveloperAttestations', 
        'astp-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiYjBiZWE4NTktNzcyMi00OWE2LWIzNjUtMWUyYjFhNWY0OWI0IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '525px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard' 
);

--
-- Add new role mappings for the ASTP reports
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-admin' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DeveloperAttestations' AND report_group = 'astp-dashboard') 
		AND role_name = 'chpl-onc' 
);