ALTER TYPE openchpl.attestation RENAME TO transparency_attestation;

-- Old Tables or Previous designs
DROP TABLE IF EXISTS openchpl.change_request_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_answer CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_question CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_category CASCADE;

-- New Tables
DROP TABLE IF EXISTS openchpl.change_request_attestation_response CASCADE;
DROP TABLE IF EXISTS openchpl.change_request_attestation_submission CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation_response CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation_submission CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_form CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_period CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_valid_response CASCADE;
DROP TABLE IF EXISTS openchpl.attestation CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_condition CASCADE;

-- Clear out the Change requests for now, since they have been psuedo orphaned by removing the CR Attestation tables	
delete from openchpl.change_request_status;
delete from openchpl.change_request;

CREATE TABLE IF NOT EXISTS openchpl.attestation_period (
	id bigserial NOT NULL,
	period_start date NOT NULL,
	period_end date NOT NULL,
	submission_start date NOT NULL,
	submission_end date NOT NULL,
	description text NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, last_modified_user)
SELECT '2021-01-01', '2022-03-31', '2022-01-01', '2022-04-30', 'First Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE period_start = '2021-01-01'
	AND period_end = '2022-03-31');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_condition (
	id bigserial NOT NULL,
	name text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_condition_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Information Blocking', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Information Blocking');	


INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Assurances', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Assurances');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Communications', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Communications');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Application Programming Interfaces (APIs)', 4, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Application Programming Interfaces (APIs)');

INSERT INTO openchpl.attestation_condition (name, sort_order, last_modified_user)
SELECT 'Real World Testing', 5, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_condition
	WHERE name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation (
	id bigserial NOT NULL,
	attestation_condition_id bigint NOT NULL,
	description text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_pk PRIMARY KEY (id),
	CONSTRAINT attestation_condition_id_fk FOREIGN KEY (attestation_condition_id)
      REFERENCES openchpl.attestation_condition (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Information Blocking'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND cat.name = 'Information Blocking');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Assurances'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND cat.name = 'Assurances');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Communications'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND cat.name = 'Communications');

INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Application Programming Interfaces (APIs)'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND cat.name = 'Application Programming Interfaces (APIs)');


INSERT INTO openchpl.attestation (description, attestation_condition_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).', 
	(SELECT id FROM openchpl.attestation_condition WHERE name = 'Real World Testing'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation ques
		INNER JOIN openchpl.attestation_condition cat
			ON cat.id = ques.attestation_condition_id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND cat.name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_valid_response (
	id bigserial NOT NULL,
	response text NOT NULL,
	meaning text,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_valid_response_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Noncompliant', 10, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Noncompliant');

INSERT INTO openchpl.attestation_valid_response (response, sort_order, last_modified_user)
SELECT 'Not Applicable', 20, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_valid_response
	WHERE response = 'Not Applicable');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_form (
	id bigserial NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_form_pk PRIMARY KEY (id),
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in [§170.401](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.401).'
	AND ans.response = 'Noncompliant');
	
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Compliant with the requirements of §45 CFR §170.402; certifies to the criterion at §45 CFR §170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

	
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Compliant with the requirements of §45 CFR §170.402; does not certify to the criterion at §45 CFR §170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR §170.315(b)(10)');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [§170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in [§170.403](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.403).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in [§170.404](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.404).'
	AND ans.response = 'Not Applicable');

----
INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_id, attestation_valid_response_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation WHERE description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'),
	(SELECT id from openchpl.attestation_valid_response WHERE response = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation ques
			ON form.attestation_id = ques.id
		INNER JOIN openchpl.attestation_valid_response ans
			ON form.attestation_valid_response_id = ans.id
	WHERE ques.description = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in [§170.405](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.405).'
	AND ans.response = 'Not Applicable');

------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_submission (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_submission_pk PRIMARY KEY (id),
	CONSTRAINT change_request_id_fk FOREIGN KEY (change_request_id)
      REFERENCES openchpl.change_request (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_response (
	id bigserial NOT NULL,
	change_request_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT change_request_attestation_submission_id_fk FOREIGN KEY (change_request_attestation_submission_id)
      REFERENCES openchpl.change_request_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_submission (
	id bigserial NOT NULL,
	developer_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestation_submission_pk PRIMARY KEY (id),
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_response (
	id bigserial NOT NULL,
	developer_attestation_submission_id bigint NOT NULL,
	attestation_id bigint NOT NULL,
	attestation_valid_response_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT developer_attestation_id_fk FOREIGN KEY (developer_attestation_submission_id)
      REFERENCES openchpl.developer_attestation_submission (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_id_fk FOREIGN KEY (attestation_id)
      REFERENCES openchpl.attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_valid_response_id_fk FOREIGN KEY (attestation_valid_response_id)
      REFERENCES openchpl.attestation_valid_response (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);