-- b1 cures
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 165, 'RT7 EC ACI Transition', 'Patient Care Record Exchange: Eligible Clinician', 'Required Test 7: Promoting Interoperability Transition Objective 6 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 165 and value = 'RT7 EC ACI Transition'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 165, 'RT7 EH/CAH Stage 2', 'Patient Care Record Exchange: Eligible Hospital/Critical Access Hospital', 'Required Test 7: Stage 2 Objective 5', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 165 and value = 'RT7 EH/CAH Stage 2'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 165, 'RT7 EP Stage 2', 'Patient Care Record Exchange: Eligible Professional', 'Required Test 7: Stage 2 Objective 5', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 165 and value = 'RT7 EP Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 165, 'RT8 EC ACI', 'Request/Accept Patient Care Record: Eligible Clinician', 'Required Test 8: Promoting Interoperability Objective 5 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 165 and value = 'RT8 EC ACI'
    );
	
-- b2 cures
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 166, 'EC ACI', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Objective 5 Measure 3', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 166 and value = 'EC ACI'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 166, 'EC ACI Transition', 'Medication/Clinical Information Reconciliation: Eligible Clinician', 'Required Test 9: Promoting Interoperability Transition Objective 7 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 166 and value = 'EC ACI Transition'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 166, 'EH/CAH Stage 2', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Stage 2 Objective 7', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 166 and value = 'EH/CAH Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 166, 'EP Stage 2', 'Medication/Clinical Information Reconciliation: Eligible Professional', 'Required Test 9: Stage 2 Objective 7', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 166 and value = 'EP Stage 2'
    );
	
--b3 cures
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 167, 'EC ACI Transition', 'Electronic Prescribing: Eligible Clinician', 'Required Test 1: Promoting Interoperability Transition Objective 2 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 167 and value = 'EC ACI Transition'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 167, 'EH/CAH Stage 2', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 2 Objective 4', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 167 and value = 'EH/CAH Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 167, 'EP Stage 2', 'Electronic Prescribing: Eligible Professional', 'Required Test 1: Stage 2 Objective 4', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 167 and value = 'EP Stage 2'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 167, 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 167 and value = 'RT13 EC'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 167, 'RT13 EH/CAH Stage 3', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Hospital/Critical Access Hospital', 'Required Test 13: Stage 3', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 167 and value = 'RT13 EH/CAH Stage 3'
    );	

-- e1 cures	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2a EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2a EC ACI Transition'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2a EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2a EH/CAH Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2a EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2a EP Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2b EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2b EC ACI Transition'
    );		
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2b EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2b EH/CAH Stage 2'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT2b EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT2b EP Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4a EC', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4a EC'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4a EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4a EC ACI Transition'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4a EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4a EH/CAH Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4a EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4a EP Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4b EC', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Merit-based Incentive Payment System (MIPS) Promoting Interoperability Performance Category', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4b EC'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4b EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4b EC ACI Transition'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4b EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4b EH/CAH Stage 2'
    );		
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 178, 'RT4b EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 178 and value = 'RT4b EP Stage 2'
    );		
	
--g9 cures
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2a EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2a EC ACI Transition'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2a EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2a EH/CAH Stage 2'
    );
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2a EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2a EP Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2c EC ACI Transition', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: Promoting Interoperability Transition Objective 3 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2c EC ACI Transition'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2c EH/CAH Stage 2', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2c EH/CAH Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT2c EP Stage 2', 'Patient Electronic Access: Eligible Professional', 'Required Test 2: Stage 2 Objective 8 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT2c EP Stage 2'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4a EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4a EC ACI'
    );	

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4a EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4a EC ACI Transition'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4a EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4a EH/CAH Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4a EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4a EP Stage 2'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4c EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Objective 4 Measure 1', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4c EC ACI'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4c EC ACI Transition', 'View, Download, or Transmit (VDT): Eligible Clinician', 'Required Test 4: Promoting Interoperability Transition Objective 3 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4c EC ACI Transition'
    );	
	
INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4c EH/CAH Stage 2', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4c EH/CAH Stage 2'
    );

INSERT INTO openchpl.macra_criteria_map
    (criteria_id, value, name, description, removed, last_modified_user)
SELECT 181, 'RT4c EP Stage 2', 'View, Download, or Transmit (VDT): Eligible Professional', 'Required Test 4: Stage 2 Objective 8 Measure 2', true, -1
WHERE
    NOT EXISTS (
        SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 181 and value = 'RT4c EP Stage 2'
    );	