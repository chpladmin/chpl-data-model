create table if not exists openchpl.updated_criteria_status_report (
	id bigserial not null,
	report_day date not null,
	certification_criterion_id bigint not null,
	listings_with_criterion_count int not null,
	fully_up_to_date_count int not null,
	code_sets_up_to_date_count int not null,
	functionalities_tested_up_to_date_count int not null,
	standards_up_to_date_count int not null,
	creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	constraint updated_criteria_status_report_pk primary key (id),
	constraint certification_criterion_fk foreign key (certification_criterion_id)
        references openchpl.certification_criterion (certification_criterion_id)
        match simple on update no action on delete restrict
);

CREATE or replace TRIGGER updated_criteria_status_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.updated_criteria_status_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER updated_criteria_status_report_timestamp BEFORE UPDATE on openchpl.updated_criteria_status_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS updated_criteria_status_report_last_modified_user_constraint ON openchpl.updated_criteria_status_report;
CREATE CONSTRAINT TRIGGER updated_criteria_status_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.updated_criteria_status_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
