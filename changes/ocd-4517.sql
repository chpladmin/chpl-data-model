CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_plan_summary_report (
    id bigserial not null,
    real_world_testing_year bigint not null,
    certification_body_id bigint not null,
    checked_date date not null,
    checked_count bigint,
    requires_check_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT real_world_testing_plan_summary_report_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_plan_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_plan_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_plan_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_plan_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_plan_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_plan_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_plan_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_plan_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

CREATE TABLE IF NOT EXISTS openchpl.real_world_testing_results_summary_report (
    id bigserial not null,
    real_world_testing_year bigint not null,
    certification_body_id bigint not null,
    checked_date date not null,
    checked_count bigint,
    requires_check_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT real_world_testing_results_summary_report_pk PRIMARY KEY (id),
    CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
                REFERENCES openchpl.certification_body (certification_body_id)
                MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER real_world_testing_results_summary_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.real_world_testing_results_summary_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER real_world_testing_results_summary_report_timestamp BEFORE UPDATE on openchpl.real_world_testing_results_summary_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS real_world_testing_results_summary_report_last_modified_user_constraint ON openchpl.real_world_testing_results_summary_report;
CREATE CONSTRAINT TRIGGER real_world_testing_results_summary_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.real_world_testing_results_summary_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();

