-- rename stage 2 macra measures

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(1)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(1)'
AND value = 'GAP-EH/CAH';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(2)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(2)'
AND value = 'GAP-EH/CAH';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(3)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(3)'
AND value = 'GAP-EH/CAH';


-- add stage 3 macra measures

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional',
		'Required Test 10: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital',
		'Required Test 10: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional',
		'Required Test 11: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital',
		'Required Test 11: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional',
		'Required Test 12: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital',
		'Required Test 12: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)')
);

-- add the new Stage 3 measures to every certification result that has one of the Stage 2 measures
DROP FUNCTION If EXISTS openchpl.insert_stage_3(text, text, text);

CREATE OR REPLACE FUNCTION openchpl.insert_stage_3 (criterion_number text, old_macra_value text, new_macra_value text)
RETURNS void AS $$
DECLARE
	old_macra_id bigint;
	new_macra_id bigint;
	existingG1Macra RECORD;
	existingG2Macra RECORD;
	
BEGIN
	SELECT mcm.id INTO old_macra_id
	FROM openchpl.macra_criteria_map mcm 
	JOIN openchpl.certification_criterion cc ON mcm.criteria_id = cc.certification_criterion_id
	WHERE mcm.value = old_macra_value
	AND cc.number = criterion_number;
	
	SELECT mcm.id INTO new_macra_id
	FROM openchpl.macra_criteria_map mcm 
	JOIN openchpl.certification_criterion cc ON mcm.criteria_id = cc.certification_criterion_id
	WHERE mcm.value = new_macra_value
	AND cc.number = criterion_number;
	
	FOR existingG1Macra IN
		SELECT g1.*
		FROM openchpl.certification_result_g1_macra g1
		JOIN openchpl.certification_result cr ON cr.certification_result_id = g1.certification_result_id
		JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
		WHERE g1.deleted = false
		AND cr.deleted = false
		AND cc.number = criterion_number
		AND g1.macra_id = old_macra_id
	LOOP
		INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user)
		SELECT  new_macra_id,
				existingG1Macra.certification_result_id,
				-1
		WHERE NOT EXISTS (
			SELECT * FROM openchpl.certification_result_g1_macra
			WHERE macra_id = new_macra_id
			AND certification_result_id = existingG1Macra.certification_result_id
		);
	END LOOP;
	
	FOR existingG2Macra IN
		SELECT g2.*
		FROM openchpl.certification_result_g2_macra g2
		JOIN openchpl.certification_result cr ON cr.certification_result_id = g2.certification_result_id
		JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
		WHERE g2.deleted = false
		AND cr.deleted = false
		AND cc.number = criterion_number
		AND g2.macra_id = old_macra_id
	LOOP
		INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user)
		SELECT  new_macra_id,
				existingG2Macra.certification_result_id,
				-1
		WHERE NOT EXISTS (
			SELECT * FROM openchpl.certification_result_g2_macra
			WHERE macra_id = new_macra_id
			AND certification_result_id = existingG2Macra.certification_result_id
		);
	END LOOP;
END;
$$ language plpgsql
volatile;

SELECT openchpl.insert_stage_3('170.315 (a)(1)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(1)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(2)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(2)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(3)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(3)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');

DROP FUNCTION If EXISTS openchpl.insert_stage_3(text, text, text);
