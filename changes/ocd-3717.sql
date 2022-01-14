DROP TABLE IF EXISTS openchpl.attestation_answer CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_question CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_category CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_form CASCADE;
DROP TABLE IF EXISTS openchpl.attestation_period CASCADE;
DROP TABLE IF EXISTS openchpl.change_request_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.change_request_attestation_response CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation CASCADE;
DROP TABLE IF EXISTS openchpl.developer_attestation_response CASCADE;
	

CREATE TABLE IF NOT EXISTS openchpl.attestation_period (
	id bigserial NOT NULL,
	period_start date NOT NULL,
	period_end date NOT NULL,
	description text NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_period_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_period (period_start, period_end, description, last_modified_user)
SELECT '2021-01-01', '2022-03-31', 'First Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_period
	WHERE period_start = '2021-01-01'
	AND period_end = '2022-03-31');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_category (
	id bigserial NOT NULL,
	name text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_category_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_category (name, sort_order, last_modified_user)
SELECT 'Information Blocking', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_category
	WHERE name = 'Information Blocking');	


INSERT INTO openchpl.attestation_category (name, sort_order, last_modified_user)
SELECT 'Assurances', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_category
	WHERE name = 'Assurances');

INSERT INTO openchpl.attestation_category (name, sort_order, last_modified_user)
SELECT 'Communications', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_category
	WHERE name = 'Communications');

INSERT INTO openchpl.attestation_category (name, sort_order, last_modified_user)
SELECT 'Application Programming Interfaces (APIs)', 4, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_category
	WHERE name = 'Application Programming Interfaces (APIs)');

INSERT INTO openchpl.attestation_category (name, sort_order, last_modified_user)
SELECT 'Real World Testing', 5, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_category
	WHERE name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_question (
	id bigserial NOT NULL,
	attestation_category_id bigint NOT NULL,
	question text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_question_pk PRIMARY KEY (id),
	CONSTRAINT attestation_category_id_fk FOREIGN KEY (attestation_category_id)
      REFERENCES openchpl.attestation_category (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation_question (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.', 
	(SELECT id FROM openchpl.attestation_category WHERE name = 'Information Blocking'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_question ques
		INNER JOIN openchpl.attestation_category cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND cat.name = 'Information Blocking');

INSERT INTO openchpl.attestation_question (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.', 
	(SELECT id FROM openchpl.attestation_category WHERE name = 'Assurances'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_question ques
		INNER JOIN openchpl.attestation_category cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND cat.name = 'Assurances');

INSERT INTO openchpl.attestation_question (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.', 
	(SELECT id FROM openchpl.attestation_category WHERE name = 'Communications'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_question ques
		INNER JOIN openchpl.attestation_category cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND cat.name = 'Communications');

INSERT INTO openchpl.attestation_question (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.', 
	(SELECT id FROM openchpl.attestation_category WHERE name = 'Application Programming Interfaces (APIs)'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_question ques
		INNER JOIN openchpl.attestation_category cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND cat.name = 'Application Programming Interfaces (APIs)');


INSERT INTO openchpl.attestation_question (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.', 
	(SELECT id FROM openchpl.attestation_category WHERE name = 'Real World Testing'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_question ques
		INNER JOIN openchpl.attestation_category cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND cat.name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_answer (
	id bigserial NOT NULL,
	answer text NOT NULL,
	meaning text,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_answer_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_answer (answer, sort_order, last_modified_user)
SELECT 'Compliant', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answer
	WHERE answer = 'Compliant');

INSERT INTO openchpl.attestation_answer (answer, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answer
	WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_answer (answer, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answer
	WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_answer (answer, sort_order, last_modified_user)
SELECT 'Noncompliant', 10, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answer
	WHERE answer = 'Noncompliant');

INSERT INTO openchpl.attestation_answer (answer, sort_order, last_modified_user)
SELECT 'Not Applicable', 20, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answer
	WHERE answer = 'Not Applicable');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_form (
	id bigserial NOT NULL,
	attestation_question_id bigint NOT NULL,
	attestation_answer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_form_pk PRIMARY KEY (id),
	CONSTRAINT attestation_question_id_fk FOREIGN KEY (attestation_question_id)
      REFERENCES openchpl.attestation_question (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_answer_id_fk FOREIGN KEY (attestation_answer_id)
      REFERENCES openchpl.attestation_answer (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND ans.answer = 'Noncompliant');
	
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

	
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Not Applicable');

----
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_question WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answer WHERE answer = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_question ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answer ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Not Applicable');

------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation (
	id bigserial NOT NULL,
	change_request_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_pk PRIMARY KEY (id),
	CONSTRAINT change_request_id_fk FOREIGN KEY (change_request_id)
      REFERENCES openchpl.change_request (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS openchpl.change_request_attestation_response (
	id bigserial NOT NULL,
	change_request_attestation_id bigint NOT NULL,
	attestation_question_id bigint NOT NULL,
	attestation_answer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT change_request_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT change_request_attestation_id_fk FOREIGN KEY (change_request_attestation_id)
      REFERENCES openchpl.change_request_attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_question_id_fk FOREIGN KEY (attestation_question_id)
      REFERENCES openchpl.attestation_question (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS openchpl.developer_attestation (
	id bigserial NOT NULL,
	developer_id bigint NOT NULL,
	attestation_period_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestations_pk PRIMARY KEY (id),
	CONSTRAINT developer_id_fk FOREIGN KEY (developer_id)
      REFERENCES openchpl.vendor (vendor_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_period_id_fk FOREIGN KEY (attestation_period_id)
      REFERENCES openchpl.attestation_period (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS openchpl.developer_attestation_response (
	id bigserial NOT NULL,
	developer_attestation_id bigint NOT NULL,
	attestation_question_id bigint NOT NULL,
	attestation_answer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT developer_attestations_response_pk PRIMARY KEY (id),
	CONSTRAINT developer_attestation_id_fk FOREIGN KEY (developer_attestation_id)
      REFERENCES openchpl.developer_attestation (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_question_id_fk FOREIGN KEY (attestation_question_id)
      REFERENCES openchpl.attestation_question (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);