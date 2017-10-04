INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(1)',
	'GAP-EP',
	'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Provider', 
   'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(1)',
	AND value = 'GAP-EP',
	AND name = '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Provider',
	AND description = 'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1',
	AND last_modified_user = -1
);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(1)',
	'GAP-EH/CAH',
	'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital', 
   'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(1)',
	AND value = 'GAP-EH/CAH',
	AND name = '(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital',
	AND description = 'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1',
	AND last_modified_user = -1
);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(2)',
	'GAP-EP',
	'(Gap Certified) Computerized Provider Order - Laboratory: Eligible Provider', 
   'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(2)',
	AND value = 'GAP-EP',
	AND name = '(Gap Certified) Computerized Provider Order - Laboratory: Eligible Provider',
	AND description = 'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2',
	AND last_modified_user = -1
);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(2)',
	'GAP-EH/CAH',
	'(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital', 
   'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(2)',
	AND value = 'GAP-EH/CAH',
	AND name = '(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital',
	AND description = 'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2',
	AND last_modified_user = -1
);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(3)',
	'GAP-EP',
	'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Provider', 
   'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(3)',
	AND value = 'GAP-EP',
	AND name = '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Provider',
	AND description = 'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3',
	AND last_modified_user = -1
);
INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT '170.315 (a)(3)',
	'GAP-EH/CAH',
	'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital', 
   'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3', 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
	WHERE  ceriteria_id = '170.315 (a)(3)',
	AND value = 'GAP-EH/CAH',
	AND name = '(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital',
	AND description = 'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3',
	AND last_modified_user = -1
);