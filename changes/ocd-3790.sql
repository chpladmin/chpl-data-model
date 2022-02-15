CREATE TABLE IF NOT EXISTS openchpl.attestation_period_developer_exception (
	id bigserial NOT NULL,
	attestation_period_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	exception_end date NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_developer_exception_pk PRIMARY KEY (id),
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TRIGGER attestation_period_developer_exception_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.attestation_period_developer_exception FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER attestation_period_developer_exception_timestamp BEFORE UPDATE on openchpl.attestation_period_developer_exception FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

UPDATE openchpl.attestation_period
SET period_start='2021-01-01', 
	period_end='2022-01-31', 
	submission_start='2022-02-01', 
	submission_end='2022-02-14', 
	description='First Period', 
	creation_date=now(), 
	last_modified_date=now(), 
	last_modified_user=-1
WHERE id = 1;

INSERT INTO openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, last_modified_user)
SELECT '2022-02-01', '2022-09-30', '2022-10-01', '2022-10-30', 'Second Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE period_start = '2022-02-01'
	AND period_end = '2022-09-30');
