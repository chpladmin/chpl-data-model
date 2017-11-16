DROP TABLE IF EXISTS openchpl.certification_result_test_procedure_temp;
DROP TABLE IF EXISTS openchpl.test_procedure_criteria_map_temp;
DROP TABLE IF EXISTS openchpl.test_procedure_temp;

CREATE TABLE openchpl.test_procedure_temp (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_procedure_temp_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.test_procedure_criteria_map_temp (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	test_procedure_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_procedure_criteria_map_temp_pk PRIMARY KEY (id),
	CONSTRAINT test_procedure_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_temp_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure_temp (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE openchpl.certification_result_test_procedure_temp (
	id bigserial NOT NULL,
	certification_result_id bigint NOT NULL,
	test_procedure_id bigint NOT NULL,
	version varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT certification_result_test_procedure_temp_pk PRIMARY KEY (id),
	CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
		REFERENCES openchpl.certification_result (certification_result_id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_procedure_temp_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure_temp (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO openchpl.test_procedure_temp (name, last_modified_user)
VALUES
('ONC Test Method', -1),
('NCQA eCQM Test Method', -1),
('HIMSS-IIP Test Method', -1);

--allow ONC Test Method for every criteria
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.certification_edition_id = (SELECT certification_edition_id FROM openchpl.certification_edition WHERE year = '2015')
	AND tpt.name = 'ONC Test Method'
);
--allow the other test methods for only a few specific criteria
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.number = '170.315 (c)(2)'
	AND tpt.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.number = '170.315 (c)(3)'
	AND tpt.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.number = '170.315 (c)(4)'
	AND tpt.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.number = '170.315 (f)(1)'
	AND tpt.name = 'HIMSS-IIP Test Method'
);
	
INSERT INTO openchpl.certification_result_test_procedure_temp (certification_result_id, test_procedure_id, version, creation_date, last_modified_date, last_modified_user, deleted)
(
	SELECT crtp.certification_result_id, (SELECT id FROM openchpl.test_procedure_temp WHERE name = 'ONC Test Method'), 
		tp.version, crtp.creation_date, crtp.last_modified_date, crtp.last_modified_user, crtp.deleted 
	FROM openchpl.certification_result_test_procedure crtp JOIN openchpl.test_procedure tp ON crtp.test_procedure_id = tp.test_procedure_id
);

	
CREATE TRIGGER test_procedure_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_temp_timestamp BEFORE UPDATE on openchpl.test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();	
CREATE TRIGGER test_procedure_criteria_map_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_criteria_map_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_criteria_map_temp_timestamp BEFORE UPDATE on openchpl.test_procedure_criteria_map_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_procedure_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_procedure_temp_timestamp BEFORE UPDATE on openchpl.certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--remove refs to test_data
ALTER TABLE openchpl.certification_result_test_data DROP COLUMN IF EXISTS test_data_id;
DROP TABLE IF EXISTS openchpl.test_data_criteria_map;
DROP TABLE IF EXISTS openchpl.test_data;

CREATE TABLE openchpl.test_data (
	id bigserial NOT NULL,
	name varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_data_pk PRIMARY KEY (id)
);

CREATE TABLE openchpl.test_data_criteria_map (
	id bigserial NOT NULL,
	criteria_id bigint NOT NULL,
	test_data_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_data_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT test_procedure_criteria_fk FOREIGN KEY (criteria_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_data_fk FOREIGN KEY (test_data_id)
		REFERENCES openchpl.test_data (id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO openchpl.test_data (name, last_modified_user)
VALUES
('ONC Test Method', -1),
('NCQA eCQM Test Method', -1),
('HIMSS-IIP Test Method', -1);

--allow ONC Test Method for every criteria
INSERT INTO openchpl.test_data_criteria_map(criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.certification_edition_id = (SELECT certification_edition_id FROM openchpl.certification_edition WHERE year = '2015')
	AND td.name = 'ONC Test Method'
);
--allow the other test methods for only a few specific criteria
INSERT INTO openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.number = '170.315 (c)(2)'
	AND td.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.number = '170.315 (c)(3)'
	AND td.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.number = '170.315 (c)(4)'
	AND td.name = 'NCQA eCQM Test Method'
);
INSERT INTO openchpl.test_data_criteria_map (criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.number = '170.315 (f)(1)'
	AND td.name = 'HIMSS-IIP Test Method'
);

ALTER TABLE openchpl.certification_result_test_data ADD COLUMN test_data_id bigint;
ALTER TABLE openchpl.certification_result_test_data ADD CONSTRAINT 
	test_data_fk FOREIGN KEY (test_data_id)
	REFERENCES openchpl.test_data (id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE;
UPDATE openchpl.certification_result_test_data SET test_data_id = (SELECT id FROM openchpl.test_data where name = 'ONC Test Method');
ALTER TABLE openchpl.certification_result_test_data ALTER COLUMN test_data_id SET NOT NULL;


CREATE TRIGGER test_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_timestamp BEFORE UPDATE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_data_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_criteria_map_timestamp BEFORE UPDATE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();