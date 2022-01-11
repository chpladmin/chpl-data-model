CREATE TABLE IF NOT EXISTS openchpl.attestation_periods (
	id bigserial NOT NULL,
	period_start date NOT NULL,
	period_end date NOT NULL,
	description text NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_periods_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_periods (period_start, period_end, description, last_modified_user)
SELECT '2021-01-01', '2022-03-31', 'First Period', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.attestation_periods
	WHERE period_start = '2021-01-01'
	AND period_end = '2022-03-31');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_categories (
	id bigserial NOT NULL,
	name text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_categories_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_categories (name, sort_order, last_modified_user)
SELECT 'Information Blocking', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_categories
	WHERE name = 'Information Blocking');	


INSERT INTO openchpl.attestation_categories (name, sort_order, last_modified_user)
SELECT 'Assurances', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_categories
	WHERE name = 'Assurances');

INSERT INTO openchpl.attestation_categories (name, sort_order, last_modified_user)
SELECT 'Communications', 3, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_categories
	WHERE name = 'Communications');

INSERT INTO openchpl.attestation_categories (name, sort_order, last_modified_user)
SELECT 'Application Programming Interfaces (APIs)', 4, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_categories
	WHERE name = 'Application Programming Interfaces (APIs)');

INSERT INTO openchpl.attestation_categories (name, sort_order, last_modified_user)
SELECT 'Real World Testing', 5, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_categories
	WHERE name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_questions (
	id bigserial NOT NULL,
	attestation_category_id bigint NOT NULL,
	question text NOT NULL,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_questions_pk PRIMARY KEY (id),
	CONSTRAINT attestation_category_id_fk FOREIGN KEY (attestation_category_id)
      REFERENCES openchpl.attestation_categories (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation_questions (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.', 
	(SELECT id FROM openchpl.attestation_categories WHERE name = 'Information Blocking'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_questions ques
		INNER JOIN openchpl.attestation_categories cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND cat.name = 'Information Blocking');

INSERT INTO openchpl.attestation_questions (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.', 
	(SELECT id FROM openchpl.attestation_categories WHERE name = 'Assurances'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_questions ques
		INNER JOIN openchpl.attestation_categories cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND cat.name = 'Assurances');

INSERT INTO openchpl.attestation_questions (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.', 
	(SELECT id FROM openchpl.attestation_categories WHERE name = 'Communications'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_questions ques
		INNER JOIN openchpl.attestation_categories cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND cat.name = 'Communications');

INSERT INTO openchpl.attestation_questions (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.', 
	(SELECT id FROM openchpl.attestation_categories WHERE name = 'Application Programming Interfaces (APIs)'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_questions ques
		INNER JOIN openchpl.attestation_categories cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND cat.name = 'Application Programming Interfaces (APIs)');


INSERT INTO openchpl.attestation_questions (question, attestation_category_id, sort_order, last_modified_user)
SELECT 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.', 
	(SELECT id FROM openchpl.attestation_categories WHERE name = 'Real World Testing'),
	1, 
	-1
WHERE NOT EXISTS (
    SELECT ques.*
	FROM openchpl.attestation_questions ques
		INNER JOIN openchpl.attestation_categories cat
			ON cat.id = ques.attestation_category_id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND cat.name = 'Real World Testing');

------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS openchpl.attestation_answers (
	id bigserial NOT NULL,
	answer text NOT NULL,
	meaning text,
	sort_order bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT attestation_answers_pk PRIMARY KEY (id)
);

INSERT INTO openchpl.attestation_answers (answer, sort_order, last_modified_user)
SELECT 'Compliant', 1, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answers
	WHERE answer = 'Compliant');

INSERT INTO openchpl.attestation_answers (answer, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answers
	WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_answers (answer, sort_order, last_modified_user)
SELECT 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)', 2, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answers
	WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_answers (answer, sort_order, last_modified_user)
SELECT 'Noncompliant', 10, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answers
	WHERE answer = 'Noncompliant');

INSERT INTO openchpl.attestation_answers (answer, sort_order, last_modified_user)
SELECT 'Not Applicable', 20, -1
WHERE NOT EXISTS (
    SELECT *
	FROM openchpl.attestation_answers
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
      REFERENCES openchpl.attestation_questions (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT attestation_answer_id_fk FOREIGN KEY (attestation_answer_id)
      REFERENCES openchpl.attestation_answers (id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Information Blocking Condition of Certification requirement described in § 170.401.'
	AND ans.answer = 'Noncompliant');
	
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Compliant with the requirements of §45 CFR § 170.402 ; certifies to the criterion at §45 CFR § 170.315(b)(10) and provides all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

	
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Compliant with the requirements of §45 CFR § 170.402; does not certify to the criterion at §45 CFR § 170.315(b)(10) or does not provide all of its customers of certified health IT with health IT certified to the certification criterion in §45 CFR § 170.315(b)(10)');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in § 170.402.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Communications Condition and Maintenance of Certification requirements described in § 170.403.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the APIs Condition and Maintenance of Certification requirements described in § 170.404.'
	AND ans.answer = 'Not Applicable');

----
INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Compliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Compliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Noncompliant'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Noncompliant');

INSERT INTO openchpl.attestation_form (attestation_question_id, attestation_answer_id, last_modified_user)
SELECT 
	(SELECT id from openchpl.attestation_questions WHERE question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'),
	(SELECT id from openchpl.attestation_answers WHERE answer = 'Not Applicable'),
	-1
WHERE NOT EXISTS (
	SELECT form.*
	FROM openchpl.attestation_form form
		INNER JOIN openchpl.attestation_questions ques
			ON form.attestation_question_id = ques.id
		INNER JOIN openchpl.attestation_answers ans
			ON form.attestation_answer_id = ans.id
	WHERE ques.question = 'We attest to compliance with the Real World Testing Condition and Maintenance of Certification requirements described in § 170.405.'
	AND ans.answer = 'Not Applicable');
