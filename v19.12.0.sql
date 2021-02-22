-- Deployment file for version 19.12.0
--     as of 2021-02-22
-- ./changes/ocd-3401.sql
-- temp fix so that the load script will work
;
-- ./changes/ocd-3517.sql
DROP TABLE IF EXISTS openchpl.certification_criterion_attribute;

CREATE TABLE openchpl.certification_criterion_attribute (
  id                 bigserial NOT NULL,
  criterion_id       bigint NOT NULL,
  svap               bool NOT NULL DEFAULT false,
  creation_date      timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted            bool NOT NULL DEFAULT false,
  CONSTRAINT certification_criterion_attribute_pk PRIMARY KEY (id),
  CONSTRAINT certification_criterion_id_fk FOREIGN KEY (criterion_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER certification_criterion_attribute_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_criterion_attribute FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_criterion_attribute_timestamp BEFORE UPDATE on openchpl.certification_criterion_attribute FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (21, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (25, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (26, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (43, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (44, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (45, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (46, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (48, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (49, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (58, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (182, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (165, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (166, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (167, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (168, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (169, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (170, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (171, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (172, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (178, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (179, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (56, true, -1);
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, svap, last_modified_user) VALUES (57, true, -1);
;
-- ./changes/ocd-3563.sql
DROP TABLE IF EXISTS openchpl.listing_validation_report;

CREATE TABLE openchpl.listing_validation_report (
  id                        bigserial NOT NULL,
  certified_product_id      bigint NOT NULL,
  chpl_product_number       text NOT NULL,
  certification_body_id     bigint NOT NULL,
  product                   text NOT NULL,
  version                   text NOT NULL,
  developer                 text NOT NULL,
  certification_body        text NOT NULL,
  certification_status_name text NOT NULL,
  listing_modified_date     timestamp NOT NULL,
  error_message             text NOT NULL,
  report_date               timestamp NOT NULL DEFAULT NOW(),
  creation_date             timestamp NOT NULL DEFAULT NOW(),
  last_modified_date        timestamp NOT NULL DEFAULT NOW(),
  last_modified_user        bigint NOT NULL,
  deleted                   boolean NOT NULL DEFAULT false,
  CONSTRAINT PK_listing_validation_report PRIMARY KEY ( id )
);

CREATE TRIGGER listing_validation_report_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_validation_report_timestamp BEFORE UPDATE on openchpl.listing_validation_report FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ./changes/ocd-3573.sql
DROP TABLE IF EXISTS openchpl.certification_result_g1_macra;
DROP TABLE IF EXISTS openchpl.certification_result_g2_macra;
DROP TABLE IF EXISTS openchpl.pending_certification_result_g1_macra;
DROP TABLE IF EXISTS openchpl.pending_certification_result_g2_macra;
;
-- ./changes/ocd-3609.sql
DROP FUNCTION IF EXISTS openchpl.add_missing_measure_criteria_mapping(bigint,bigint,text,text,text,boolean) ;
CREATE FUNCTION openchpl.add_missing_measure_criteria_mapping(origCriterionId bigint, curesCriterionId bigint, uploadValue text, name text, description text, removed boolean)
  RETURNS void AS $$
	DECLARE
	  measureId bigint;
	BEGIN
		SELECT DISTINCT measure_id 
		INTO measureId		
		FROM openchpl.allowed_measure_criteria
		WHERE id =
			(SELECT allowed_criteria_measure_id FROM openchpl.allowed_measure_criteria_legacy_map
			WHERE macra_criteria_map_id = 
				(SELECT id FROM openchpl.macra_criteria_map
				WHERE criteria_id = origCriterionId
				AND value = uploadValue)
			);
		
		IF measureId IS NULL THEN
			RAISE NOTICE 'No measure id found for criterion id % and upload value %', origCriterionId, uploadValue;
		ELSE 
			-- insert an entry for the cures criterion into the "deprecated" macra measure table
			INSERT INTO openchpl.macra_criteria_map
				(criteria_id, value, name, description, removed, last_modified_user)
			SELECT curesCriterionId, uploadValue, name, description, removed, -1
			WHERE
				NOT EXISTS (
					SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = curesCriterionId and value = uploadValue
				);
	
			-- insert an entry into the table that maps between "deprecated" macra measures and the new allowed measures
			INSERT INTO openchpl.allowed_measure_criteria_legacy_map
				(allowed_criteria_measure_id, macra_criteria_map_id, last_modified_user)
				SELECT 
					(SELECT id FROM openchpl.allowed_measure_criteria WHERE certification_criterion_id = curesCriterionId
					AND measure_id = measureId ORDER BY id ASC LIMIT 1),
				(SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = curesCriterionId and value = uploadValue),
				-1
			WHERE
				NOT EXISTS (
					SELECT id FROM openchpl.allowed_measure_criteria_legacy_map 
					WHERE allowed_criteria_measure_id = 
						(SELECT id FROM openchpl.allowed_measure_criteria WHERE certification_criterion_id = curesCriterionId
						AND measure_id = measureId ORDER BY id ASC LIMIT 1)
					AND macra_criteria_map_id = (SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = curesCriterionId and value = uploadValue)
				);
		END IF;
	END;
$$ language plpgsql
volatile;

SELECT openchpl.add_missing_measure_criteria_mapping(16, 165, 'RT7 EC ACI Transition', 'Patient Care Record Exchange: Eligible Clinician', 'Required Test 7: Promoting Interoperability Transition Objective 6 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(16, 165, 'RT7 EH/CAH Stage 2', 'Patient Care Record Exchange: Eligible Hospital/Critical Access Hospital', 'Required Test 7: Stage 2 Objective 5', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(16, 165, 'RT7 EP Stage 2', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Stage 2 Objective 5', true);

SELECT openchpl.add_missing_measure_criteria_mapping(16, 165, 'RT8 EC ACI', 'Request/Accept Patient Care Record: Eligible Clinician', 'Required Test 8: Promoting Interoperability Objective 5 Measure 2', true);
	
-- b2 = 17, b2 cures = 166
SELECT openchpl.add_missing_measure_criteria_mapping(17, 166, 'EC ACI', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Objective 5 Measure 3', true);

SELECT openchpl.add_missing_measure_criteria_mapping(17, 166, 'EC ACI Transition', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Transition Objective 7 Measure 1', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(17, 166, 'EH/CAH Stage 2', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Stage 2 Objective 7', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(17, 166, 'EP Stage 2', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Stage 2 Objective 7', true);
	
-- b3 = 18, b3 cures = 167
SELECT openchpl.add_missing_measure_criteria_mapping(18, 167, 'EC ACI Transition', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Promoting Interoperability Transition Objective 2 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(18, 167, 'EH/CAH Stage 2', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 2 Objective 4', true);	

SELECT openchpl.add_missing_measure_criteria_mapping(18, 167, 'EP Stage 2', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Stage 2 Objective 4', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(18, 167, 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(18, 167, 'RT13 EH/CAH Stage 3', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital', 'Required Test 13: Stage 3', true);

-- e1 = 40, e1 cures = 178
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2a EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2a EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2a EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2b EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2b EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT2b EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);	

SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4a EC', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4a EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true);	

SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4a EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);	

SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4a EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4b EC', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true);

SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4b EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4b EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);		
	
SELECT openchpl.add_missing_measure_criteria_mapping(40, 178, 'RT4b EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);
	
-- g9 = 58, g9 cures = 181
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2a EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2a EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2a EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2c EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2c EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT2c EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4a EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4a EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4a EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4a EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4c EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4c EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true);	
	
SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4c EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);

SELECT openchpl.add_missing_measure_criteria_mapping(58, 181, 'RT4c EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true);	
	
DROP FUNCTION IF EXISTS openchpl.add_missing_measure_criteria_mapping(bigint,bigint,text,text,text,boolean) ;
	;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.12.0', '2021-02-22', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
