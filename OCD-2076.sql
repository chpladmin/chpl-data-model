-- insert newly mapped values into the macra_criteria_map table based on what the old value is

-- 170.315 (a)(1)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Computerized Provider Order Entry - Medications: Eligible Provider', description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)') AND value = 'EP';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)'), 'EP Stage 3', 'Computerized Provider Order Entry - Medications: Eligible Provider', 'Required Test 10: Stage 3 Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)'), 'EH/CAH Stage 3', 'Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 'Required Test 10: Stage 3 Objective 4 Measure 1', -1);

-- 170.315 (a)(2)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Computerized Provider Order  - Laboratory: Eligible Provider', description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)') AND value = 'EP';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)'), 'EP Stage 3', 'Computerized Provider Order  - Laboratory: Eligible Provider', 'Required Test 11: Stage 3 Objective 4 Measure 2', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)'), 'EH/CAH Stage 3', 'Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 'Required Test 11: Stage 3 Objective 4 Measure 2', -1);

-- 170.315 (a)(3)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Provider', description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)') AND value = 'EP';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)'), 'EP Stage 3', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Provider', 'Required Test 12: Stage 3 Objective 4 Measure 3', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)'), 'EH/CAH Stage 3', 'Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 'Required Test 12: Stage 3 Objective 4 Measure 3', -1);

-- 170.315 (a)(10)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Electronic Prescibing: Eligible Provider', description = 'Required Test 1: Stage 2 Objective 4'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EP Stage 3', 'Electronic Prescibing: Eligible Provider', 'Required Test 1: Stage 3 Objective 2', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI Transition',  name = 'Electronic Prescribing: Eligible Clinician', description = 'Required Test 1: ACI Transition Objective 2 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'EC Individual (TIN/NPI)';

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Electronic Prescribing: Eligible Clinician', description = 'Required Test 1: ACI Objective 2 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', description = 'Required Test 1: Stage 2 Objective 4'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'EH/CAH Stage 3', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 3 Objective 2', -1);

-- 170.315 (a)(13)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Patient-Specific Education: Eligible Provider', description = 'Required Test 3: Stage 2 Objective 6'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EP Stage 3', 'Patient-Specific Education: Eligible Provider', 'Required Test 3: Stage 3 Objective 5 Measure 2', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI Transition',  name = 'Patient-Specific Education: Eligible Clinician', description = 'Required Test 3: ACI Transition Objective 4 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)') AND value = 'EC Individual (TIN/NPI)';

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Patient-Specific Education: Eligible Clinician', description = 'Required Test 3: ACI Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)') AND value = 'EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', description ='Required Test 3: Stage 2 Objective 6'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(13)'), 'EH/CAH Stage 3', 'Patient-Specific Education: Eligible Hospital/Critical Access Hospital', 'Required Test 3: Stage 3 Objective 5 Measure 2', -1);


-- 170.315 (b)(1)
UPDATE openchpl.macra_criteria_map 
SET value = 'RT7 EP Stage 2',  name = 'Patient Care Record Exchange: Eligible Provider', description = 'Required Test 7: Stage 2 Objective 5'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT7 EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EP Stage 3', 'Patient Care Record Exchange: Eligible Provider', 'Required Test 7: Stage 3 Objective 7 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT8 EP Stage 3',  name = 'Request/Accept Patient Care Record: Eligible Provider', description = 'Required Test 8: Stage 3 Objective 7 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT8 EP Individual';

UPDATE openchpl.macra_criteria_map 
SET value = 'RT7 EC ACI Transition',  name = 'Patient Care Record Exchange: Eligible Clinician', description = 'Required Test 7: ACI Transition Objective 6 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT7 EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EC ACI', 'Patient Care Record Exchange: Eligible Clinician', 'Required Test 7: ACI Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT8 EC ACI',  name = 'Patient Care Record Exchange: Eligible Clinician', description = 'Required Test 8: ACI Objective 5 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT8 EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'RT7 EH/CAH Stage 2',  name = 'Patient Care Record Exchange:  Eligible Hospital/Critical Access Hospital', description = 'Required Test 7: Stage 2 Objective 5'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT7 EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT7 EH/CAH Stage 3', 'Patient Care Record Exchange: Eligible Hospital/Critical Access Hospital', 'Required Test 7: Stage 3 Objective 7 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT8 EH/CAH Stage 3',  name = 'Request/Accept Patient Care Record: Eligible Hospital/Critical Access Hospital', description = 'Required Test 8: Stage 3 Objective 7 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT8 EH/CAH';

-- 170.315 (b)(2)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Medication/Clinical Information Reconciliation: Eligible Provider', description = 'Required Test 9: Stage 2 Objective 7'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EP Stage 3', 'Medication/Clinical Information Reconciliation: Eligible Provider', 'Required Test 9: Stage 3 Objective 7 Measure 3', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI Transition',  name = 'Medication/Clinical Information Reconciliation: Eligible Clinician', description = 'Required Test 9: ACI Transition Objective 7 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'EC Individual (TIN/NPI)';

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Medication/Clinical Information Reconciliation: Eligible Clinician', description = 'Required Test 9: ACI Objective 5 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', description ='Required Test 9: Stage 2 Objective 7'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'EH/CAH Stage 3', 'Medication/Clinical Information Reconciliation: Eligible Hospital/Critical Access Hospital', 'Required Test 9: Stage 3 Objective 7 Measure 3', -1);

-- 170.315 (b)(3)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Electronic Prescribing: Eligible Provider', description = 'Required Test 1: Stage 2 Objective 4'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EP Stage 3', 'Electronic Prescribing: Eligible Provider', 'Required Test 1: Stage 3 Objective 2', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI Transition',  name = 'Electronic Prescribing: Eligible Clinician', description = 'Required Test 1: ACI Transition Objective 2 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'EC Individual (TIN/NPI)';

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Electronic Prescribing: Eligible Clinician', description = 'Required Test 1: ACI Objective 2 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', description ='Required Test 1: Stage 2 Objective 4'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'EH/CAH Stage 3', 'Electronic Prescribing: Eligible Hospital/Critical Access Hospital', 'Required Test 1: Stage 3 Objective 2', -1);

-- 170.315 (e)(1)
UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2b EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2b EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT4a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4b EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT4b EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4b EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description = 'Required Test 4: ACI Transition Objective 3 Measure 2 '
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EC ACI', 'Patient Electronic Access: Eligible Clinician', 'Required Test 2: ACI Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2b EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2b EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: ACI Transition Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EC ACI Transition',  name = 'View, Download, or Transmit (VDT): Eligible Clinician', description ='Required Test 4: ACI Transition Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT4a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EH/CAH Stage 2',  name = 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2a EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2b EH/CAH Stage 2',  name = 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT2b EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT2b EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT4a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4a EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4b EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)') AND value = 'RT4b EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(1)'), 'RT4b EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

-- 170.315 (e)(2)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 2',  name = 'Secure Electronic Messaging: Eligible Provider', description ='Required Test 5: Stage 2 Objective 9'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EP Stage 3', 'Secure Electronic Messaging: Eligible Provider ', 'Required Test 5: Stage 3 Objective 6 Measure 2', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI Transition',  name = 'Secure Electronic Messaging: Eligible Clinician', description ='Required Test 5: ACI Transition Objective 5 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)') AND value = 'EC Individual (TIN/NPI)';
UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Secure Electronic Messaging: Eligible Clinician', description ='Required Test 5: ACI Objective 4 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)') AND value = 'EC Group';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 2',  name = 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', description ='Required Test 5: Stage 2 Objective 9'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)') AND value = 'EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(2)'), 'EH/CAH Stage 3', 'Secure Electronic Messaging: Eligible Hospital/Critical Access Hospital', 'Required Test 5: Stage 3 Objective 6 Measure 2', -1);

-- 170.315 (e)(3)
UPDATE openchpl.macra_criteria_map 
SET value = 'EP Stage 3',  name = 'Eligible Provider Individual: Patient-Generated Health Data', description ='Required Test 6: Stage 3 Objective 6 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)') AND value = 'EP Individual';

UPDATE openchpl.macra_criteria_map 
SET value = 'EH/CAH Stage 3',  name = 'Patient-Generated Health Data: Eligible Hospital/Critical Access Hospital', description ='Required Test 6: Stage 3 Objective 6 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)') AND value = 'EH/CAH';

UPDATE openchpl.macra_criteria_map 
SET value = 'EC ACI',  name = 'Patient-Generated Health Data: Eligible Clinician Individual (TIN/NPI)', description ='Required Test 6: ACI Objective 4 Measure 3'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)') AND value = 'EC Individual (TIN/NPI)';

DELETE FROM openchpl.certification_result_g1_macra 
WHERE macra_id = (SELECT id from openchpl.macra_criteria_map where value = 'EC Group' AND name = 'Patient-Generated Health Data: Eligible Clinician Group' AND description = 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3');

DELETE FROM openchpl.certification_result_g2_macra 
WHERE macra_id = (SELECT id from openchpl.macra_criteria_map where value = 'EC Group' AND name = 'Patient-Generated Health Data: Eligible Clinician Group' AND description = 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3');

DELETE FROM openchpl.pending_certification_result_g1_macra 
WHERE macra_id = (SELECT id from openchpl.macra_criteria_map where value = 'EC Group' AND name = 'Patient-Generated Health Data: Eligible Clinician Group' AND description = 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3');

DELETE FROM openchpl.pending_certification_result_g2_macra 
WHERE macra_id = (SELECT id from openchpl.macra_criteria_map where value = 'EC Group' AND name = 'Patient-Generated Health Data: Eligible Clinician Group' AND description = 'Required Test 6: Stage 3 Objective 6 Measure 3, ACI Objective 4 Measure 3');

DELETE FROM openchpl.macra_criteria_map 
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (e)(3)') AND value = 'EC Group';

-- 170.315 (g)(8)
UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2c EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4c EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: ACI Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2c EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: ACI Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EC ACI Transition',  name = 'View, Download, or Transmit (VDT): Eligible Clinician Group', description ='Required Test 4: ACI Transition Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician Individual (TIN/NPI)', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EC ACI Transition',  name = 'View, Download, or Transmit (VDT): Eligible Clinician Group', description ='Required Test 4: ACI Transition Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4c EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician Individual (TIN/NPI)', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EH/CAH Stage 2',  name = 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2a EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT2c EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT2c EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4a EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)') AND value = 'RT4c EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(8)'), 'RT4c EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

-- 170.315 (g)(9)

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2a EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EP Stage 2',  name = 'Patient Electronic Access: Eligible Provider', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2c EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2c EP Stage 3', 'Patient Electronic Access: Eligible Provider', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4a EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4a EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EP Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Provider', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4c EP Individual';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4c EP Stage 3', 'View, Download, or Transmit (VDT): Eligible Provider ', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2a EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: ACI Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EC ACI Transition',  name = 'Patient Electronic Access: Eligible Clinician Group', description ='Required Test 2: ACI Transition Objective 3 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2c EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2c EC ACI', 'Patient Electronic Access: Eligible Clinician Group', 'Required Test 2: ACI Objective 3 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EC ACI Transition',  name = 'View, Download, or Transmit (VDT): Eligible Clinician', description ='Required Test 4: ACI Transition Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4a EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4a EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EC ACI Transition',  name = 'View, Download, or Transmit (VDT): Eligible Clinician Group', description ='Required Test 4: ACI Transition Objective 3 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4c EC Individual (TIN/NPI)';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4c EC ACI', 'View, Download, or Transmit (VDT): Eligible Clinician Group', 'Required Test 4: ACI Objective 4 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2a EH/CAH Stage 2',  name = 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2a EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT2c EH/CAH Stage 2',  name = 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', description ='Required Test 2: Stage 2 Objective 8 Measure 1'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT2c EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT2c EH/CAH Stage 3', 'Patient Electronic Access: Eligible Hospital/Critical Access Hospital', 'Required Test 2: Stage 3 Objective 5 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4a EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4a EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4a EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);

UPDATE openchpl.macra_criteria_map 
SET value = 'RT4c EH/CAH Stage 2',  name = 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', description ='Required Test 4: Stage 2 Objective 8 Measure 2'
WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)') AND value = 'RT4c EH/CAH';
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user) values
((SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (g)(9)'), 'RT4c EH/CAH Stage 3', 'View, Download, or Transmit (VDT): Eligible Hospital/Critical Access Hospital', 'Required Test 4: Stage 3 Objective 6 Measure 1', -1);


-- for every new pair add the second mapped value that corresponds to the first
-- i.e. if EP maps to EP Stage 2 and EP Stage 3, if EP stage 2 is in any related table (i.e certification_result_g1_macra) then add EP Stage 3 to that table also
create or replace function openchpl.add_macra_measures() returns void as $$
	declare g1_macra record;
	declare g2_macra record;
    begin
    	FOR g1_macra IN (SELECT * FROM openchpl.certification_result_g1_macra) LOOP
    		-- if EP Stage 2 is in the certification result g1 macra table, then add EP Stage 3 to that table
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(1 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(2 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(3 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(10 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(13 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(17 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(18 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(41 AS BIGINT), 'EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;

    		-- if EH/CAH Stage 2 is in the certification result g1 macra table, then add EH/CAH Stage 3 to that table
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(1 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(2 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(3 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(10 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(13 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(17 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(18 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(41 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;

    		-- for 170.315 (b)(1)
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;

    		-- 170.315 (e)(1)
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;

    		-- 170.315(g)(8) and 170.315(g)(9)
    		FOR i in 57..58 LOOP
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EP Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EP Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EC ACI Transition'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EC ACI' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EH/CAH Stage 2'::varchar) THEN
    			INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user) values
    			((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EH/CAH Stage 3' LIMIT 1), g1_macra.certification_result_id, -1);
    		END IF;
    		END LOOP;

    	END LOOP;

    	FOR g2_macra IN (SELECT * FROM openchpl.certification_result_g2_macra) LOOP
            -- if EP Stage 2 is in the certification result g2 macra table, then add EP Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(1 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(2 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(3 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(10 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(17 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(18 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(41 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;

            -- if EH/CAH Stage 2 is in the certification result g2 macra table, then add EH/CAH Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(1 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(2 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(3 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(10 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'RT7 EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(17 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(18 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(41 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;

            -- for 170.315 (b)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;

            -- 170.315 (e)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;

            -- 170.315(g)(8) and 170.315(g)(9)
            FOR i in 57..58 LOOP
                IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EP Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EC ACI' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EH/CAH Stage 3' LIMIT 1), g2_macra.certification_result_id, -1);
            END IF;
            END LOOP;
    	END LOOP;

    	-- update g1 pending certification results
    	FOR g1_macra IN (SELECT * FROM openchpl.pending_certification_result_g1_macra) LOOP
            -- if EP Stage 2 is in the certification result g1 macra table, then add EP Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(1 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(2 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(3 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(10 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(13 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EP Stage 3' LIMIT 1), 'RT7 EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(17 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(18 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(41 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;

            -- if EH/CAH Stage 2 is in the certification result g1 macra table, then add EH/CAH Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(1 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(2 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(3 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(10 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(13 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(13 AS BIGINT), 'RT7 EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'RT7 EH/CAH Stage 3' LIMIT 1), 'RT7 EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(17 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(18 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(41 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;

            -- for 170.315 (b)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EC ACI' LIMIT 1), 'RT7 EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;

            -- 170.315 (e)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EP Stage 3' LIMIT 1), 'RT2a EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EP Stage 3' LIMIT 1), 'RT2b EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EP Stage 3'),'RT4a EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EP Stage 3' LIMIT 1), 'RT4b EP Stage 3',g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EC ACI' LIMIT 1), 'RT2a EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EC ACI' LIMIT 1), 'RT2b EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EC ACI' LIMIT 1), 'RT4a EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EC ACI' LIMIT 1), 'RT4b EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), 'RT2a EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), 'RT4a EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EH/CAH Stage 3' LIMIT 1), 'RT2b EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EH/CAH Stage 3' LIMIT 1), 'RT4b EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;

            -- 170.315(g)(8) and 170.315(g)(9)
            FOR i in 57..58 LOOP
                IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EP Stage 3' LIMIT 1), 'RT2a EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EP Stage 3' LIMIT 1), 'RT2c EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EP Stage 3' LIMIT 1), 'RT4a EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EP Stage 3' LIMIT 1), 'RT4c EP Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EC ACI' LIMIT 1), 'RT2a EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EC ACI' LIMIT 1), 'RT2c EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EC ACI' LIMIT 1), 'RT4a EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EC ACI' LIMIT 1), 'RT4c EC ACI', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), 'RT2a EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), 'RT4a EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EH/CAH Stage 3' LIMIT 1), 'RT2c EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g1_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g1_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EH/CAH Stage 3' LIMIT 1), 'RT4c EH/CAH Stage 3', g1_macra.pending_certification_result_id, -1);
            END IF;
            END LOOP;
        END LOOP;

        -- update g2 pending certification results
    	FOR g2_macra IN (SELECT * FROM openchpl.pending_certification_result_g2_macra) LOOP
            -- if EP Stage 2 is in the certification result g2 macra table, then add EP Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(1 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(2 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(3 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(10 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EP Stage 3' LIMIT 1), 'RT7 EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(17 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(18 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(41 AS BIGINT), 'EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EP Stage 3' LIMIT 1), 'EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;

            -- if EH/CAH Stage 2 is in the certification result g2 macra table, then add EH/CAH Stage 3 to that table
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(1 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 1 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(2 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 2 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(3 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 3 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(10 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 10 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(13 AS BIGINT), 'RT7 EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 13 AND value = 'RT7 EH/CAH Stage 3' LIMIT 1), 'RT7 EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(17 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 17 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(18 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 18 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(41 AS BIGINT), 'EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 41 AND value = 'EH/CAH Stage 3' LIMIT 1), 'EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;

            -- for 170.315 (b)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(16 AS BIGINT), 'RT7 EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 16 AND value = 'RT7 EC ACI' LIMIT 1), 'RT7 EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;

            -- 170.315 (e)(1)
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EP Stage 3' LIMIT 1), 'RT2a EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EP Stage 3' LIMIT 1), 'RT2b EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EP Stage 3'),'RT4a EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EP Stage 3' LIMIT 1), 'RT4b EP Stage 3',g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EC ACI' LIMIT 1), 'RT2a EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EC ACI' LIMIT 1), 'RT2b EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EC ACI' LIMIT 1), 'RT4a EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EC ACI' LIMIT 1), 'RT4b EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), 'RT2a EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT2b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), 'RT4a EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT2b EH/CAH Stage 3' LIMIT 1), 'RT2b EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(40 AS BIGINT), 'RT4b EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = 40 AND value = 'RT4b EH/CAH Stage 3' LIMIT 1), 'RT4b EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;

            -- 170.315(g)(8) and 170.315(g)(9)
            FOR i in 57..58 LOOP
                IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EP Stage 3' LIMIT 1), 'RT2a EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EP Stage 3' LIMIT 1), 'RT2c EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EP Stage 3' LIMIT 1), 'RT4a EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EP Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EP Stage 3' LIMIT 1), 'RT4c EP Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EC ACI' LIMIT 1), 'RT2a EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EC ACI' LIMIT 1), 'RT2c EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EC ACI' LIMIT 1), 'RT4a EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EC ACI Transition'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EC ACI' LIMIT 1), 'RT4c EC ACI', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2a EH/CAH Stage 3' LIMIT 1), 'RT2a EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT2c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4a EH/CAH Stage 3' LIMIT 1), 'RT4a EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4a EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT2c EH/CAH Stage 3' LIMIT 1), 'RT2c EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            IF (SELECT (criteria_id, value) FROM openchpl.macra_criteria_map WHERE id = g2_macra.macra_id) = (CAST(i AS BIGINT), 'RT4c EH/CAH Stage 2'::varchar) THEN
                INSERT INTO openchpl.pending_certification_result_g2_macra (macra_id, macra_value, pending_certification_result_id, last_modified_user) values
                ((SELECT id FROM openchpl.macra_criteria_map WHERE criteria_id = i AND value = 'RT4c EH/CAH Stage 3' LIMIT 1), 'RT4c EH/CAH Stage 3', g2_macra.pending_certification_result_id, -1);
            END IF;
            END LOOP;
        END LOOP;
    end;
    $$ language plpgsql;
select openchpl.add_macra_measures();
drop function openchpl.add_macra_measures();

-- Update pending certification results g1, g2 macra macra_values (macra name)
UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'EP Stage 2'
WHERE macra_value = 'EP';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'EP Stage 2'
WHERE macra_value = 'EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'EC Individual (TIN/NPI)'
WHERE macra_value = 'EC ACI Transition';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'EC Group'
WHERE macra_value = 'EC ACI';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'EH/CAH Stage 2'
WHERE macra_value = 'EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EP Stage 2'
WHERE macra_value = 'RT7 EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EP Stage 3'
WHERE macra_value = 'RT8 EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EC ACI Transition'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EC ACI Transition'
WHERE macra_value = 'RT7 EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EC ACI'
WHERE macra_value = 'RT8 EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EH/CAH Stage 2'
WHERE macra_value = 'RT7 EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EH/CAH Stage 3'
WHERE macra_value = 'RT8 EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EP Stage 2'
WHERE macra_value = 'RT2a EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2b EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4b EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2b EC ACI Transition'
WHERE macra_value = 'RT2b EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2b EC ACI Transition'
WHERE macra_value = 'RT2b EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4b EC ACI Transition'
WHERE macra_value = 'RT4b EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4b EC ACI Transition'
WHERE macra_value = 'RT4b EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EH/CAH Stage 2'
WHERE macra_value = 'RT2a EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2b EH/CAH Stage 2'
WHERE macra_value = 'RT2b EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EH/CAH Stage 2'
WHERE macra_value = 'RT4a EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4b EH/CAH Stage 2'
WHERE macra_value = 'RT4b EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EP Stage 2'
WHERE macra_value = 'RT2a EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2c EP Stage 2'
WHERE macra_value = 'RT2c EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EP Stage 2'
WHERE macra_value = 'RT4a EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4c EP Stage 2'
WHERE macra_value = 'RT4c EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2c EC ACI Transition'
WHERE macra_value = 'RT2c EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2c EC ACI Transition'
WHERE macra_value = 'RT2c EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4c EC ACI Transition'
WHERE macra_value = 'RT4c EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4c EC ACI Transition'
WHERE macra_value = 'RT4c EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2a EH/CAH Stage 2'
WHERE macra_value = 'RT2a EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT2c EH/CAH Stage 2'
WHERE macra_value = 'RT2c EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4a EH/CAH Stage 2'
WHERE macra_value = 'RT4a EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT4c EH/CAH Stage 2'
WHERE macra_value = 'RT4c EH/CAH';


-- Update pending certification results g2 macra macra_values
UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'EP Stage 2'
WHERE macra_value = 'EP';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'EP Stage 2'
WHERE macra_value = 'EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'EC Individual (TIN/NPI)'
WHERE macra_value = 'EC ACI Transition';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'EC Group'
WHERE macra_value = 'EC ACI';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'EH/CAH Stage 2'
WHERE macra_value = 'EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EP Stage 2'
WHERE macra_value = 'RT7 EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EP Stage 3'
WHERE macra_value = 'RT8 EP Individual';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EC ACI Transition'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EC ACI Transition'
WHERE macra_value = 'RT7 EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EC ACI'
WHERE macra_value = 'RT8 EC Group';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT7 EH/CAH Stage 2'
WHERE macra_value = 'RT7 EH/CAH';

UPDATE openchpl.pending_certification_result_g1_macra
SET macra_value = 'RT8 EH/CAH Stage 3'
WHERE macra_value = 'RT8 EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EP Stage 2'
WHERE macra_value = 'RT2a EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2b EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4b EP Stage 2'
WHERE macra_value = 'RT7 EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2b EC ACI Transition'
WHERE macra_value = 'RT2b EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2b EC ACI Transition'
WHERE macra_value = 'RT2b EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4b EC ACI Transition'
WHERE macra_value = 'RT4b EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4b EC ACI Transition'
WHERE macra_value = 'RT4b EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EH/CAH Stage 2'
WHERE macra_value = 'RT2a EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2b EH/CAH Stage 2'
WHERE macra_value = 'RT2b EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EH/CAH Stage 2'
WHERE macra_value = 'RT4a EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4b EH/CAH Stage 2'
WHERE macra_value = 'RT4b EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EP Stage 2'
WHERE macra_value = 'RT2a EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2c EP Stage 2'
WHERE macra_value = 'RT2c EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EP Stage 2'
WHERE macra_value = 'RT4a EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4c EP Stage 2'
WHERE macra_value = 'RT4c EP Individual';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EC ACI Transition'
WHERE macra_value = 'RT2a EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2c EC ACI Transition'
WHERE macra_value = 'RT2c EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2c EC ACI Transition'
WHERE macra_value = 'RT2c EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EC ACI Transition'
WHERE macra_value = 'RT4a EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4c EC ACI Transition'
WHERE macra_value = 'RT4c EC Individual (TIN/NPI)';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4c EC ACI Transition'
WHERE macra_value = 'RT4c EC Group';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2a EH/CAH Stage 2'
WHERE macra_value = 'RT2a EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT2c EH/CAH Stage 2'
WHERE macra_value = 'RT2c EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4a EH/CAH Stage 2'
WHERE macra_value = 'RT4a EH/CAH';

UPDATE openchpl.pending_certification_result_g2_macra
SET macra_value = 'RT4c EH/CAH Stage 2'
WHERE macra_value = 'RT4c EH/CAH';