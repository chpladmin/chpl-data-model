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
					AND measure_id = measureId),
				(SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = curesCriterionId and value = uploadValue),
				-1
			WHERE
				NOT EXISTS (
					SELECT id FROM openchpl.allowed_measure_criteria_legacy_map 
					WHERE allowed_criteria_measure_id = 
						(SELECT id FROM openchpl.allowed_measure_criteria WHERE certification_criterion_id = curesCriterionId
						AND measure_id = measureId)
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
	