DROP TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp;
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

CREATE TABLE openchpl.pending_certification_result_test_procedure_temp (
	id bigserial NOT NULL,
	pending_certification_result_id bigint NOT NULL,
	test_procedure_id bigint,
	test_procedure_name text,
	version varchar(255) NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT pending_certification_result_test_procedure_temp_pk PRIMARY KEY (id),
	CONSTRAINT pending_certification_result_temp_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT test_procedure_temp_fk FOREIGN KEY (test_procedure_id)
		REFERENCES openchpl.test_procedure_temp (id) MATCH FULL
		ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO openchpl.test_procedure_temp (name, last_modified_user)
VALUES
('ONC Test Method', -1),
('NCQA eCQM Test Method', -1),
('HIMSS-IIP Test Method', -1);

--allow ONC Test Method for every 2014 criteria
INSERT INTO openchpl.test_procedure_criteria_map_temp(criteria_id, test_procedure_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, tpt.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_procedure_temp tpt
	WHERE cc.certification_edition_id = (SELECT certification_edition_id FROM openchpl.certification_edition WHERE year = '2014')
	AND tpt.name = 'ONC Test Method'
);

--allow ONC Test Method for every 2015 criteria
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

-- fill in the pending certification result test procedure table
INSERT INTO openchpl.pending_certification_result_test_procedure_temp (pending_certification_result_id, test_procedure_id, version, creation_date, last_modified_date, last_modified_user, deleted)
(
	SELECT pcrtp.pending_certification_result_id, (SELECT id FROM openchpl.test_procedure_temp WHERE name = 'ONC Test Method'), 
		pcrtp.test_procedure_version, pcrtp.creation_date, pcrtp.last_modified_date, pcrtp.last_modified_user, pcrtp.deleted 
	FROM openchpl.pending_certification_result_test_procedure pcrtp 
);
	
CREATE TRIGGER test_procedure_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_temp_timestamp BEFORE UPDATE on openchpl.test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();	
CREATE TRIGGER test_procedure_criteria_map_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_criteria_map_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_criteria_map_temp_timestamp BEFORE UPDATE on openchpl.test_procedure_criteria_map_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_procedure_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_procedure_temp_timestamp BEFORE UPDATE on openchpl.certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_procedure_temp_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_procedure_temp_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_procedure_temp FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--remove refs to test_data
ALTER TABLE openchpl.pending_certification_result_test_data DROP COLUMN IF EXISTS test_data_id;
ALTER TABLE openchpl.pending_certification_result_test_data DROP COLUMN IF EXISTS test_data_name;
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

--allow ONC Test Method for every 2014 criteria
INSERT INTO openchpl.test_data_criteria_map(criteria_id, test_data_id, last_modified_user)
(
	SELECT cc.certification_criterion_id, td.id, -1
	FROM openchpl.certification_criterion cc CROSS JOIN openchpl.test_data td
	WHERE cc.certification_edition_id = (SELECT certification_edition_id FROM openchpl.certification_edition WHERE year = '2014')
	AND td.name = 'ONC Test Method'
);

--allow ONC Test Method for every 2015 criteria
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

-- add test data mapping column to pending
ALTER TABLE openchpl.pending_certification_result_test_data ADD COLUMN test_data_id bigint;
ALTER TABLE openchpl.pending_certification_result_test_data ADD CONSTRAINT 
	test_data_fk FOREIGN KEY (test_data_id)
	REFERENCES openchpl.test_data (id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE;
UPDATE openchpl.pending_certification_result_test_data SET test_data_id = (SELECT id FROM openchpl.test_data where name = 'ONC Test Method');
ALTER TABLE openchpl.pending_certification_result_test_data ADD COLUMN test_data_name text;

CREATE TRIGGER test_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_timestamp BEFORE UPDATE on openchpl.test_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER test_data_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_data_criteria_map_timestamp BEFORE UPDATE on openchpl.test_data_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- delete and insert the new chpl upload version
INSERT INTO openchpl.upload_template_version (name, available_as_of_date, header_csv, last_modified_user, deprecated, deleted)
SELECT '2015 CHPL Upload Template v12', '2017-12-04',
'UNIQUE_CHPL_ID__C,RECORD_STATUS__C,VENDOR__C,PRODUCT__C,VERSION__C,CERT_YEAR__C,ACB_CERTIFICATION_ID__C,CERTIFYING_ACB__C,TESTING_ATL__C,CERTIFICATION_DATE__C,VENDOR_STREET_ADDRESS__C,VENDOR_STATE__C,VENDOR_CITY__C,VENDOR_ZIP__C,VENDOR_WEBSITE__C,VENDOR_EMAIL__C,VENDOR_PHONE__C,VENDOR_CONTACT_NAME__C,Developer-Identified Target Users,QMS Standard,QMS Standard Applicable Criteria,QMS Modification Description,ICS,ICS Source,Accessibility Certified,Accessibility Standard,170.523(k)(1) URL,170.523(k)(2) ATTESTATION,CQM Number,CQM Version,CQM Criteria,SED Report Hyperlink,Description of the Intended Users,Date SED Testing was Concluded,Participant Identifier,Participant Gender,Participant Age,Participant Education,Participant Occupation/Role,Participant Professional Experience,Participant Computer Experience,Participant Product Experience,Participant Assistive Technology Needs,Task Identifier,Task Description,Task Success - Mean (%),Task Success - Standard Deviation (%),Task Path Deviation - Observed #,Task Path Deviation - Optimal #,Task Time - Mean (seconds),Task Time - Standard Deviation (seconds),Task Time Deviation - Mean Observed Seconds,Task Time Deviation - Mean Optimal Seconds,Task Errors  Mean(%),Task Errors - Standard Deviation (%),Task Rating - Scale Type,Task Rating,Task Rating - Standard Deviation,CRITERIA_170_315_A_1__C,GAP,Privacy and Security Framework,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_2__C,GAP,Privacy and Security Framework,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_3__C,GAP,Privacy and Security Framework,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_4__C,GAP,Privacy and Security Framework,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_5__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_6__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_7__C,GAP,Privacy and Security Framework,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_8__C,GAP,Privacy and Security Framework,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_9__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_10__C,GAP,Privacy and Security Framework,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_A_11__C,GAP,Privacy and Security Framework,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_A_12__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_A_13__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_A_14__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_A_15__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_B_1__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_B_2__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_B_3__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,UCD Process Selected,UCD Process Details,Task Identifier,Participant Identifier,CRITERIA_170_315_B_4__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_B_5__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_B_6__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_B_7__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,CRITERIA_170_315_B_8__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_B_9__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_C_1__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_C_2__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_C_3__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_C_4__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_D_1__C,GAP,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_2__C,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_3__C,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_4__C,GAP,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_5__C,GAP,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_6__C,GAP,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_7__C,GAP,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_8__C,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_9__C,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_10__C,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_D_11__C,GAP,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_E_1__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_E_2__C,Privacy and Security Framework,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_E_3__C,Privacy and Security Framework,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_F_1__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_F_2__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_F_3__C,GAP,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_F_4__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_F_5__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_F_6__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,CRITERIA_170_315_F_7__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_G_1__C,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_G_2__C,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_G_3__C,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,CRITERIA_170_315_G_4__C,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,CRITERIA_170_315_G_5__C,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,CRITERIA_170_315_G_6__C,Standard Tested Against,Functionality Tested,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_G_7__C,Privacy and Security Framework,API Documentation Link,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test procedure version,CRITERIA_170_315_G_8__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,API Documentation Link,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test Procedure,Test procedure version,CRITERIA_170_315_G_9__C,Privacy and Security Framework,Standard Tested Against,Functionality Tested,API Documentation Link,Measure Successfully Tested for G1,Measure Successfully Tested for G2,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_H_1__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description,CRITERIA_170_315_H_2__C,Privacy and Security Framework,Standard Tested Against,Additional Software,CP Source,CP Source Grouping,Non CP Source,Non CP Source Version,Non CP Source Grouping,Test tool name,Test tool version,Test Procedure,Test procedure version,Test Data,Test data version,Test data alteration,Test data alteration description', -1, false, false
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.upload_template_version WHERE name = '2015 CHPL Upload Template v12'
    );