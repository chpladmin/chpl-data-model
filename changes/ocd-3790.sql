DROP TABLE IF EXISTS openchpl.attestation_period_developer_exception;

TRUNCATE openchpl.change_request_website,
	openchpl.change_request_developer_details,
	openchpl.change_request_attestation_submission,
	openchpl.change_request_attestation_response,
	openchpl.change_request_status,
	openchpl.change_request,
	openchpl.developer_attestation_response,
	openchpl.developer_attestation_submission, 
	openchpl.attestation_period RESTART IDENTITY;

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


-- Set the correct attestation periods for go live!
INSERT INTO openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, last_modified_user)
SELECT '2020-06-30', '2022-03-31', '2022-04-01', '2022-04-30', 'First Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE description = 'First Period');


INSERT INTO openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, last_modified_user)
SELECT '2022-04-01', '2022-09-30', '2022-10-01', '2022-10-30', 'Second Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE description = 'Second Period');

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [45 CFR 170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
WHERE description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).';

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).';

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [45 CFR 170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
WHERE description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).';

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).';

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).';
