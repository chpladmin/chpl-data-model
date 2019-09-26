INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'RT13 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'RT13 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)'), 'RT14 EC', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (a)(10)') AND value = 'RT14 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)'), 'RT15 EC', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(1)') AND value = 'RT15 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)'), 'RT15 EC', 'Support Electronic Referral Loops by Receiving and Incorporating Health Information: Eligible Clinician', 'Required Test 15: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(2)') AND value = 'RT15 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'RT13 EC', 'Query of Prescription Drug Monitoring Program (PDMP): Eligible Clinician', 'Required Test 13: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'RT13 EC');

INSERT INTO openchpl.macra_criteria_map (criteria_id, value, name, description, last_modified_user)
SELECT (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)'), 'RT14 EC', 'Verify Opioid Treatment Agreement: Eligible Clinician', 'Required Test 14: Promoting Interoperability', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.macra_criteria_map
    WHERE criteria_id = (SELECT certification_criterion_id from openchpl.certification_criterion where number = '170.315 (b)(3)') AND value = 'RT14 EC');
