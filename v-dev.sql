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


-- In order for this script to be able to be run twice we need to add a constraint on
-- certification_result_g1_macra, certification_result_g2_macra, pending_certification_result_g1_macra, pending_certification_result_g2_macra
-- so that macra_id and certification_result_id are unique for every row (i.e. no certification_result_id can have more than one macra_id)
ALTER TABLE openchpl.certification_result_g1_macra ADD CONSTRAINT macra_id_certification_result_id_unique UNIQUE (macra_id, certification_result_id);
ALTER TABLE openchpl.certification_result_g2_macra ADD CONSTRAINT macra_id_certification_result_id_unique UNIQUE (macra_id, certification_result_id);
ALTER TABLE openchpl.pending_certification_result_g1_macra ADD CONSTRAINT macra_id_certification_result_id_unique UNIQUE (macra_id, pending_certification_result_id);
ALTER TABLE openchpl.pending_certification_result_g2_macra ADD CONSTRAINT macra_id_certification_result_id_unique UNIQUE (macra_id, pending_certification_result_id);

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

--
-- OCD-2223: Duplicate / missing listings
--
DROP VIEW IF EXISTS openchpl.certified_product_search;

CREATE OR REPLACE VIEW openchpl.certified_product_search AS
SELECT cp.certified_product_id,
       child.child,
       parent.parent,
       certs.cert_number AS certs,
       cqms.cqm_number AS cqms,
       openchpl.get_chpl_product_number(cp.certified_product_id) AS chpl_product_number,
       cp.meaningful_use_users,
       cp.transparency_attestation_url,
       edition.year,
       acb.certification_body_name,
       cp.acb_certification_id,
       prac.practice_type_name,
       version.product_version,
       product.product_name,
       vendor.vendor_name,
       owners.history_vendor_name AS owner_history,
       certstatusevent.certification_date,
       certstatus.certification_status_name,
       decert.decertification_date,
       certs_with_api_documentation.cert_number AS api_documentation,
       COALESCE(survs.count_surveillance_activities, 0::bigint) AS surveillance_count,
       COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS open_nonconformity_count,
       COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS closed_nonconformity_count
FROM openchpl.certified_product cp
LEFT JOIN
  (SELECT cse.certification_status_id,
          cse.certified_product_id,
          cse.event_date AS last_certification_status_change
   FROM openchpl.certification_status_event cse
   JOIN
     (SELECT certification_status_event.certified_product_id,
             max(certification_status_event.event_date) AS event_date
      FROM openchpl.certification_status_event
      WHERE certification_status_event.deleted = FALSE
      GROUP BY certification_status_event.certified_product_id) cseinner ON cse.certified_product_id = cseinner.certified_product_id
   AND cse.event_date = cseinner.event_date
   AND cse.deleted = false) certstatusevents ON certstatusevents.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT certification_status.certification_status_id,
          certification_status.certification_status AS certification_status_name
   FROM openchpl.certification_status) certstatus ON certstatusevents.certification_status_id = certstatus.certification_status_id
LEFT JOIN
  (SELECT string_agg(DISTINCT child_chpl_product_number||'☹'||children.child_listing_id::text, '☹'::text) AS child,
          parent_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.parent_listing_id, listing_to_listing_map.child_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(child_listing_id)) AS child_chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) children
   GROUP BY parent_listing_id) child ON cp.certified_product_id = child.parent_listing_id
LEFT JOIN
  (SELECT string_agg(DISTINCT parent_chpl_product_number||'☹'||parents.parent_listing_id::text, '☹'::text) AS parent,
          parents.child_listing_id FROM
     (SELECT certified_product.certified_product_id, listing_to_listing_map.child_listing_id, listing_to_listing_map.parent_listing_id,
        (SELECT chpl_product_number
         FROM openchpl.get_chpl_product_number(parent_listing_id)) AS parent_chpl_product_number, certified_product.chpl_product_number
      FROM openchpl.listing_to_listing_map
      JOIN openchpl.certified_product ON listing_to_listing_map.child_listing_id = certified_product.certified_product_id) parents
   GROUP BY child_listing_id) parent ON cp.certified_product_id = parent.child_listing_id
LEFT JOIN
  (SELECT certification_edition.certification_edition_id,
          certification_edition.year
   FROM openchpl.certification_edition) edition ON cp.certification_edition_id = edition.certification_edition_id
LEFT JOIN
  (SELECT certification_body.certification_body_id,
          certification_body.name AS certification_body_name,
          certification_body.acb_code AS certification_body_code,
          certification_body.deleted AS acb_is_deleted
   FROM openchpl.certification_body) acb ON cp.certification_body_id = acb.certification_body_id
LEFT JOIN
  (SELECT practice_type.practice_type_id,
          practice_type.name AS practice_type_name
   FROM openchpl.practice_type) prac ON cp.practice_type_id = prac.practice_type_id
LEFT JOIN
  (SELECT product_version.product_version_id,
          product_version.version AS product_version,
          product_version.product_id
   FROM openchpl.product_version) VERSION ON cp.product_version_id = version.product_version_id
LEFT JOIN
  (SELECT product_1.product_id,
          product_1.vendor_id,
          product_1.name AS product_name
   FROM openchpl.product product_1) product ON version.product_id = product.product_id
LEFT JOIN
  (SELECT vendor_1.vendor_id,
          vendor_1.name AS vendor_name,
          vendor_1.vendor_code
   FROM openchpl.vendor vendor_1) vendor ON product.vendor_id = vendor.vendor_id
LEFT JOIN
  (SELECT string_agg(vendor_1.name, '|') AS history_vendor_name,
          product_owner_history_map.product_id AS history_product_id
   FROM openchpl.vendor vendor_1
   JOIN openchpl.product_owner_history_map ON vendor_1.vendor_id = product_owner_history_map.vendor_id
   WHERE product_owner_history_map.deleted = FALSE
   GROUP BY history_product_id) owners ON owners.history_product_id = product.product_id
LEFT JOIN
  (SELECT min(certification_status_event.event_date) AS certification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = 1
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) certstatusevent ON cp.certified_product_id = certstatusevent.certified_product_id
LEFT JOIN
  (SELECT max(certification_status_event.event_date) AS decertification_date,
          certification_status_event.certified_product_id
   FROM openchpl.certification_status_event
   WHERE certification_status_event.certification_status_id = ANY (ARRAY[3::bigint,
                                                                         4::bigint,
                                                                         8::bigint])
     AND certification_status_event.deleted = FALSE
   GROUP BY certification_status_event.certified_product_id) decert ON cp.certified_product_id = decert.certified_product_id
LEFT JOIN
  (SELECT surveillance.certified_product_id,
          count(*) AS count_surveillance_activities
   FROM openchpl.surveillance
   WHERE surveillance.deleted <> TRUE
   GROUP BY surveillance.certified_product_id) survs ON cp.certified_product_id = survs.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_open_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
   WHERE surv.deleted <> TRUE
     AND nc_status.name::text = 'Open'::text
   GROUP BY surv.certified_product_id) nc_open ON cp.certified_product_id = nc_open.certified_product_id
LEFT JOIN
  (SELECT surv.certified_product_id,
          count(*) AS count_closed_nonconformities
   FROM openchpl.surveillance surv
   JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id
   AND surv_req.deleted <> TRUE
   JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id
   AND surv_nc.deleted <> TRUE
   JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
   WHERE surv.deleted <> TRUE
     AND nc_status.name::text = 'Closed'::text
   GROUP BY surv.certified_product_id) nc_closed ON cp.certified_product_id = nc_closed.certified_product_id
LEFT JOIN
  (SELECT certification_result.certified_product_id,
          string_agg(DISTINCT certification_criterion.number, '☺') AS cert_number
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) AS certs ON certs.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT certification_criterion.number::text||'☹'||certification_result.api_documentation, '☺') AS cert_number, --certification_result.api_documentation,
 certification_result.certified_product_id
   FROM openchpl.certification_criterion
   JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
   WHERE certification_result.success = TRUE
     AND certification_result.api_documentation IS NOT NULL
     AND certification_result.deleted = FALSE
     AND certification_criterion.deleted = FALSE
   GROUP BY certified_product_id) certs_with_api_documentation ON certs_with_api_documentation.certified_product_id = cp.certified_product_id
LEFT JOIN
  (SELECT string_agg(DISTINCT COALESCE(cqm_criterion.cms_id, ('NQF-'::text || cqm_criterion.nqf_number::text)::CHARACTER varying), '☺') AS cqm_number,
          cqm_result.certified_product_id
   FROM openchpl.cqm_criterion
   JOIN openchpl.cqm_result ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
   WHERE cqm_result.success = TRUE
     AND cqm_result.deleted = FALSE
     AND cqm_criterion.deleted = FALSE
   GROUP BY certified_product_id) cqms ON cqms.certified_product_id = cp.certified_product_id
WHERE cp.deleted <> TRUE;

--re-run grants
\i dev/openchpl_grant-all.sql
