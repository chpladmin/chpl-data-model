DROP TABLE IF EXISTS openchpl.attestation_report_developer;

CREATE TABLE IF NOT EXISTS
  openchpl.attestation_report_developer (
    id bigserial NOT NULL,
    attestation_report_id bigint NOT NULL,
    developer_id bigint NOT NULL,
    change_request_status_id bigint NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NULL,
    deleted boolean NOT NULL DEFAULT false,
    last_modified_sso_user uuid NULL,
	CONSTRAINT attestation_report_developer_pk PRIMARY KEY (id),
        CONSTRAINT attestation_report_fk FOREIGN KEY (attestation_report_id)
		REFERENCES openchpl.attestation_report (id)
		MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
                REFERENCES openchpl.vendor (vendor_id)
                MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT,
        CONSTRAINT change_request_status_fk FOREIGN KEY (change_request_status_id)
                REFERENCES openchpl.change_request_status (id)
                MATCH simple ON UPDATE NO ACTION ON DELETE RESTRICT
  );

CREATE OR replace TRIGGER attestation_report_developer_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_report_developer FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE OR replace TRIGGER attestation_report_developer_timestamp BEFORE UPDATE on openchpl.attestation_report_developer FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS attestation_report_developer_last_modified_user_constraint ON openchpl.attestation_report_developer;
CREATE CONSTRAINT TRIGGER attestation_report_developer_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.attestation_report_developer DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
