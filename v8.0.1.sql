INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user, deleted)
SELECT
	(SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)'),
	'EH/CAH', 'Eligible Hospital/Critical Access Hospital: Computerized Provider Order Entry - Medications',
	'Required Test 10: Stage 2 Objective 3 Measure 1 and Stage 3 Objective 4 Measure 1', -1, false
WHERE
	NOT EXISTS ( SELECT id from openchpl.macra_criteria_map 
			WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(1)')
			AND value = 'EH/CAH' );


INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user, deleted)
SELECT
	(SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)'),
	'EH/CAH', 'Eligible Hospital/Critical Access Hospital: Computerized Provider Order Entry - Laboratory',
	'Required Test 11: Stage 2 Objective 3 Measure 2 and Stage 3 Objective 4 Measure 2', -1, false
WHERE
	NOT EXISTS ( SELECT id from openchpl.macra_criteria_map 
			WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(2)')
			AND value = 'EH/CAH' );


INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user, deleted)
SELECT
	(SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)'),
	'EH/CAH', 'Eligible Hospital/Critical Access Hospital: Computerized Provider Order Entry - Diagnostic Imaging',
	'Required Test 12: Stage 2 Objective 3 Measure 3 and Stage 3 Objective 4 Measure 3', -1, false
WHERE
	NOT EXISTS ( SELECT id from openchpl.macra_criteria_map 
			WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(3)')
			AND value = 'EH/CAH' );
			