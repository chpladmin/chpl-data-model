-- can we drop this? If so we need to remove the plans chart from the Power BI report with this ticket
-- and that would be immediate/not flag-based
DROP TABLE IF EXISTS openchpl.real_world_testing_plan_summary_by_acb_report;

-- Rename existing tables and associated triggers, which we will eventually drop in the future
ALTER TABLE IF EXISTS openchpl.real_world_testing_results_summary_by_acb_report RENAME TO openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5;
ALTER TRIGGER openchpl.real_world_testing_results_summary_report_audit ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5_audit;
ALTER TRIGGER openchpl.real_world_testing_results_summary_report_timestamp ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5_timestamp;
ALTER TRIGGER openchpl.real_world_testing_results_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_acb_report_pre_hti5_last_modified_user_constraint;

ALTER TABLE IF EXISTS openchpl.real_world_testing_results_summary_by_developer_report RENAME TO openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5;
ALTER TRIGGER openchpl.real_world_testing_results_summary_by_developer_report_audit ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5_audit;
ALTER TRIGGER openchpl.real_world_testing_results_summary_by_developer_report_timestamp ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5_timestamp;
ALTER TRIGGER openchpl.real_world_testing_results_summary_by_developer_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5 RENAME TO openchpl.real_world_testing_results_summary_by_developer_report_pre_hti5_last_modified_user_constraint;

-- Add tables and triggers
CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_by_acb_report (
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	certification_body_id bigint NOT NULL,
	checked_date date NOT NULL,
	checked_with_gcriteria_count bigint NULL,
	requires_check_with_gcriteria_count bigint NULL,
	checked_with_svap_count bigint NULL,
	requires_check_with_svap_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT real_world_testing_results_summary_by_acb_report_pk PRIMARY KEY (id),
	CONSTRAINT acb_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certifcation_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR REPLACE TRIGGER real_world_testing_results_summary_by_acb_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_acb_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR REPLACE TRIGGER real_world_testing_results_summary_by_acb_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_acb_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_results_summary_by_acb_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_acb_report;
CREATE CONSTRAINT TRIGGER real_world_testing_results_summary_by_acb_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_acb_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_by_developer_report (
	id bigserial NOT NULL,
	real_world_testing_year bigint NOT NULL,
	developer_id bigint NOT NULL,
	checked_date date NOT NULL,
	checked_with_gcriteria_count bigint NULL,
	requires_check_with_gcriteria_count bigint NULL,
	checked_with_svap_count bigint NULL,
	requires_check_with_svap_count bigint NULL,
	creation_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
	last_modified_user bigint NULL,
	last_modified_sso_user uuid NULL,
	deleted boolean NOT NULL DEFAULT false,
	CONSTRAINT real_world_testing_results_summary_by_developer_report_pk PRIMARY KEY (id),
	CONSTRAINT vendor_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR REPLACE TRIGGER real_world_testing_results_summary_by_developer_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_by_developer_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR REPLACE TRIGGER real_world_testing_results_summary_by_developer_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_by_developer_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_results_summary_by_developer_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_by_developer_report;
CREATE CONSTRAINT TRIGGER real_world_testing_results_summary_by_developer_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_by_developer_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
