CREATE TABLE IF NOT EXISTS openchpl.attestation_report (
    id bigserial not null,
	report_date date not null,
    attestation_period_id bigint not null,
	certification_body_id bigint not null,
    developer_count bigint,
	approved_count bigint,
    pending_acb_action_count bigint,
    pending_developer_action_count bigint,
    no_submission_count bigint,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
    CONSTRAINT attestation_report_pk PRIMARY KEY (id),
	CONSTRAINT attestation_period_fk FOREIGN KEY (attestation_period_id)
		REFERENCES openchpl.attestation_period (id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT certification_body_fk FOREIGN KEY (certification_body_id)
		REFERENCES openchpl.certification_body (certification_body_id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE OR replace TRIGGER attestation_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER attestation_report_timestamp BEFORE UPDATE on openchpl.attestation_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS attestation_report_last_modified_user_constraint ON openchpl.attestation_report;
CREATE CONSTRAINT TRIGGER attestation_report_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.attestation_report DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();        