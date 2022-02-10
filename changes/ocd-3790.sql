CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_period_exception (
	id bigserial NOT NULL,
	attestation_period_id bigint NOT NULL,
	exception_end date NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestation_period_exception_pk PRIMARY KEY (id),
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER developer_attestation_period_exception_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.developer_attestation_period_exception FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER developer_attestation_period_exception_timestamp BEFORE UPDATE on openchpl.developer_attestation_period_exception FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
