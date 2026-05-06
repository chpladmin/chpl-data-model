--
-- Rename existing tables to make clear what is stored in them
--

ALTER TABLE IF EXISTS openchpl.real_world_testing_plan_summary_report
RENAME TO real_world_testing_plan_by_acb_summary_report;

ALTER TABLE IF EXISTS openchpl.real_world_testing_results_summary_report
RENAME TO real_world_testing_results_by_acb_summary_report;

--
-- Create new tables to hold the RWT summary counts by developer
--

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_plan_by_developer_summary_report(
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	developer_id bigint NOT NULL,
	checked_date date NOT NULL,
	checked_count bigint NULL,
	requires_check_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT real_world_testing_plan_by_developer_summary_report_pk PRIMARY KEY (id),
	CONSTRAINT vendor_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_plan_by_developer_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_plan_by_developer_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_plan_by_developer_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_plan_by_developer_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_plan_by_developer_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_plan_by_developer_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_plan_by_developer_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_plan_by_developer_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_by_developer_summary_report(
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	developer_id bigint NOT NULL,
	checked_date date NOT NULL,
	checked_count bigint NULL,
	requires_check_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT real_world_testing_results_by_developer_summary_report_pk PRIMARY KEY (id),
	CONSTRAINT vendor_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_results_by_developer_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_by_developer_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_results_by_developer_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_by_developer_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_results_by_developer_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_results_by_developer_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_results_by_developer_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_by_developer_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

--
-- Add report metadata for the new dashboard report in all environments
--

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Real World Testing',
        'DashboardRealWorldTesting', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiNWMyOWQxNGYtNDU4YS00OTFhLTk3ODMtYmMwNjBjMTIxZDljIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Real World Testing',
        'DashboardRealWorldTesting', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiOTI5MWE1OGYtNTBhNC00YTIyLWFiZGItZWQzNTViMGJlMDhiIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Real World Testing',
        'DashboardRealWorldTesting', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZTNiMzg2NWYtODlhZi00MjZkLWExOGQtYTg4MzNmZDQ2NTQwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_key, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Real World Testing',
        'DashboardRealWorldTesting', 
        'onc-dashboard', 
        'https://app.powerbi.com/view?r=eyJrIjoiZmViOGY4YzctM2M4Zi00ZDMwLWEwYTQtZDRkMTA2ODk5ODk4IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '500px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard' 
);

--
-- Add role mappings for these reports
-- ADMIN and ONC should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND report_key = 'DashboardRealWorldTesting' AND report_group = 'onc-dashboard') 
		AND role_name = 'chpl-onc' 
);