-- update height of RWT chart because of Plans removal
UPDATE openchpl.report_metadata
SET height = '550px'
WHERE title = 'Real World Testing'
AND report_group = 'charts';

-- Add metadata for the new RWT Results chart 

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'DEV', 
        'Real World Testing Results',
        'charts', 
        'https://app.powerbi.com/view?r=eyJrIjoiOWQwMjk3NGUtNzg1Ni00ZmYwLTlhZjQtMDI0MzVkMDE4MDRmIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '875px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'QA', 
        'Real World Testing Results',
        'charts', 
        'https://app.powerbi.com/view?r=eyJrIjoiMTIzNDljNWEtN2E5OC00NDM0LWI5Y2UtNzIxNjVkZDdiZmM4IiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '875px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'STG', 
        'Real World Testing Results',
        'charts', 
        'https://app.powerbi.com/view?r=eyJrIjoiMGVlNDEzNzUtZmQ0ZS00YTMyLTk5NmQtZmY1YWUwZTllZTNhIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '875px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts' 
);

INSERT INTO openchpl.report_metadata (environment, title, report_group, url, height, last_modified_sso_user)
SELECT 'PROD', 
        'Real World Testing Results',
        'charts', 
        'https://app.powerbi.com/view?r=eyJrIjoiMjI4ZWI2ZjYtMDI2OC00N2U0LWI0NmMtMzk1NDlhZmI0MzIwIiwidCI6IjMwN2QyMTJhLWZiODYtNDgwNy04NGRkLTg2Nzc2OWI4MDQyYSIsImMiOjF9',
        '875px',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts' 
);

--
-- Add role mappings for the new report
-- ADMIN, ONC, and ONC-ACB should have access
--
INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-admin',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-admin' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc-acb',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'DEV' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc-acb',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'QA' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc-acb',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'STG' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

INSERT INTO openchpl.report_metadata_role_map (report_metadata_id, role_name, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts'), 
        'chpl-onc-acb',
        '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
        SELECT * FROM openchpl.report_metadata_role_map 
		WHERE report_metadata_id = (SELECT id FROM openchpl.report_metadata WHERE environment = 'PROD' AND title = 'Real World Testing Results' AND report_group = 'charts') 
		AND role_name = 'chpl-onc' 
);

-- Removal of RWT Plans Summaries
DROP TABLE IF EXISTS openchpl.real_world_testing_plan_summary_by_acb_report;

-- Rename existing tables and associated triggers, which we will eventually drop in the future
-- The renaming needs to be done conditionally because after we rename these tables we are then adding new tables of the same (old) names, so when the script
-- runs a second time it gets errors trying to rename those new tables.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.tables 
        WHERE table_schema = 'openchpl' 
          AND table_name = 'real_world_testing_results_summary_by_acb_report_pre_hti5'
    ) THEN
        EXECUTE 'ALTER TABLE IF EXISTS openchpl.real_world_testing_results_summary_by_acb_report RENAME TO real_world_testing_results_summary_by_acb_report_pre_hti5';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_report_audit ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5';
		EXECUTE 'CREATE OR REPLACE TRIGGER rwt_results_summary_by_acb_report_pre_hti5_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func()';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_report_timestamp ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5';
		EXECUTE 'CREATE OR REPLACE TRIGGER rwt_results_summary_by_acb_report_pre_hti5_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column()';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5';
		EXECUTE 'CREATE CONSTRAINT TRIGGER rwt_results_summary_by_acb_report_pre_hti5_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint()';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.tables 
        WHERE table_schema = 'openchpl' 
          AND table_name = 'real_world_testing_results_summary_by_developer_report_pre_hti5'
    ) THEN
        EXECUTE 'ALTER TABLE IF EXISTS openchpl.real_world_testing_results_summary_by_developer_report RENAME TO real_world_testing_results_summary_by_developer_report_pre_hti5';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_by_developer_report_audit ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5';
		EXECUTE 'CREATE OR REPLACE TRIGGER rwt_results_summary_by_developer_report_pre_hti5_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func()';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_by_developer_report_timestamp ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5';
		EXECUTE 'CREATE OR REPLACE TRIGGER rwt_results_summary_by_developer_report_pre_hti5_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column()';
		EXECUTE 'DROP TRIGGER IF EXISTS real_world_testing_results_summary_by_developer_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5';
		EXECUTE 'CREATE CONSTRAINT TRIGGER rwt_results_summary_by_developer_report_pre_hti5_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint()';
    END IF;
END $$;

DO $$ 
BEGIN 
    IF EXISTS (
        SELECT 1 
        FROM pg_constraint 
        WHERE conname = 'real_world_testing_results_summary_by_developer_report_pk'
    ) THEN
        EXECUTE 'ALTER TABLE openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5
        RENAME CONSTRAINT real_world_testing_results_summary_by_developer_report_pk TO rwt_results_summary_by_developer_report_pre_hti5_pk';
    END IF;
END $$;

-- Add new tables and triggers
CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_by_acb_report (
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	certification_body_id bigint NOT NULL,
	checked_date date NOT NULL,
	-- let's leave in the checked count and requires check count because the gcriteria and svap counts can count the same listing twice
	-- so if we want a true "total" value for anything, we will still need these fields to avoid duplicates
	checked_count bigint NULL,
	requires_check_count bigint NULL,
	checked_with_gcriteria_count bigint NULL,
	requires_check_with_gcriteria_count bigint NULL,
	checked_with_svap_count bigint NULL,
	requires_check_with_svap_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT rwt_results_summary_by_acb_report_pk PRIMARY KEY (id),
	CONSTRAINT acb_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR REPLACE TRIGGER rwt_results_summary_by_acb_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_acb_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR REPLACE TRIGGER rwt_results_summary_by_acb_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_acb_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS rwt_results_summary_by_acb_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_acb_report;
CREATE CONSTRAINT TRIGGER rwt_results_summary_by_acb_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_acb_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_by_developer_report (
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	developer_id bigint NOT NULL,
	checked_date date NOT NULL,
	-- let's leave in the checked count and requires check count because the gcriteria and svap counts can count the same listing twice
	-- so if we want a true "total" value for anything, we will still need these fields to avoid duplicates
	checked_count bigint NULL,
	requires_check_count bigint NULL,
	checked_with_gcriteria_count bigint NULL,
	requires_check_with_gcriteria_count bigint NULL,
	checked_with_svap_count bigint NULL,
	requires_check_with_svap_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT rwt_results_summary_by_developer_report_pk PRIMARY KEY (id),
	CONSTRAINT vendor_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR REPLACE TRIGGER rwt_results_summary_by_developer_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_developer_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR REPLACE TRIGGER rwt_results_summary_by_developer_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_developer_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE OR REPLACE TRIGGER rwt_results_summary_by_developer_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_developer_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS rwt_results_summary_by_developer_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_developer_report;
CREATE CONSTRAINT TRIGGER rwt_results_summary_by_developer_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_developer_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

-- TODO
-- Add report_metadata for the new RWT Results Chart