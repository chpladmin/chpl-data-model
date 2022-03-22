-- Deployment file for version 20.14.0
--     as of 2022-03-22
-- ./changes/ocd-3790.sql
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
SET description = 'We attest to compliance with the Application Programming Interfaces (APIs) Condition and Maintenance of Certification requirements described in [45 CFR 170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).';

UPDATE openchpl.attestation
SET description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [45 CFR 170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).';

UPDATE openchpl.attestation_condition
SET name = 'Application Programming Interfaces'
WHERE name = 'Application Programming Interfaces (APIs)';

UPDATE openchpl.attestation_valid_response
SET response = 'Compliant with the requirements of 45 CFR 170.402; certifies to the criterion at 45 CFR 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in 45 CFR 170.315(b)(10).'
WHERE response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)';

UPDATE openchpl.attestation_valid_response
SET response = 'Compliant with the requirements of 45 CFR 170.402; does not certify to the criterion at 45 CFR 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in 45 CFR 170.315(b)(10).'
WHERE response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)';
;
-- ./changes/ocd-3850.sql
-- remove deprecated response field API from /search/beta
UPDATE openchpl.deprecated_response_field_api
SET deleted = false
WHERE api_operation = '/search/beta';

-- remove deprecated response field usage from /search/beta
UPDATE openchpl.deprecated_response_field_api_usage
SET deleted = true
WHERE deprecated_response_field_api_id IN(
	SELECT id 
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id IN (
		SELECT id 
		FROM openchpl.deprecated_response_field_api
		WHERE api_operation = '/search/beta'));

-- add /search/beta as deprecated endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/search/beta',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /search/v2 to perform searches.',
	'2022-09-07',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/search/beta');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'POST',
	'/search/beta',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please POST to /search/v2 to perform searches.',
	'2022-09-07',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation LIKE '/search/beta');;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.14.0', '2022-03-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
