-- Add the new functionalities tested

INSERT INTO openchpl.functionality_tested (number, name, last_modified_user)
	SELECT '(b)(3)(ii)(C)(2)(i)', 'Request to send an additional supply of medication (Resupply)', -1
	WHERE NOT EXISTS 
		(SELECT * FROM openchpl.functionality_tested 
		WHERE number = '(b)(3)(ii)(C)(2)(i)' 
		AND name = 'Request to send an additional supply of medication (Resupply)');

INSERT INTO openchpl.functionality_tested (number, name, last_modified_user)
	SELECT '(b)(3)(ii)(C)(2)(ii)', 'Request and respond to transfer one or more prescriptions between pharmacies (RxTransferRequest, RxTransferResponse)', -1
	WHERE NOT EXISTS 
		(SELECT * FROM openchpl.functionality_tested 
		WHERE number = '(b)(3)(ii)(C)(2)(ii)' 
		AND name = 'Request and respond to transfer one or more prescriptions between pharmacies (RxTransferRequest, RxTransferResponse)');

INSERT INTO openchpl.functionality_tested (number, name, last_modified_user)
	SELECT '(b)(3)(ii)(C)(2)(iii)', 'Complete Risk Evaluation and Mitigation Strategy (REMS) transactions (REMSInitiationRequest, REMSInitiationResponse, REMSRequest, and REMSResponse)', -1
	WHERE NOT EXISTS 
		(SELECT * FROM openchpl.functionality_tested 
		WHERE number = '(b)(3)(ii)(C)(2)(iii)' 
		AND name = 'Complete Risk Evaluation and Mitigation Strategy (REMS) transactions (REMSInitiationRequest, REMSInitiationResponse, REMSRequest, and REMSResponse)');
		
INSERT INTO openchpl.functionality_tested (number, name, last_modified_user)
	SELECT '(b)(3)(ii)(C)(2)(iv)', 'Electronic prior authorization (ePA) transactions (PAInitiationRequest, PAInitiationResponse, PARequest, PAResponse, PAAppealRequest, PAAppealResponse and PACancelRequest, PACancelResponse)', -1
	WHERE NOT EXISTS 
		(SELECT * FROM openchpl.functionality_tested 
		WHERE number = '(b)(3)(ii)(C)(2)(iv)' 
		AND name = 'Electronic prior authorization (ePA) transactions (PAInitiationRequest, PAInitiationResponse, PARequest, PAResponse, PAAppealRequest, PAAppealResponse and PACancelRequest, PACancelResponse)');
		
-- Associate each of the new functionalities tested with b3Cures (ID 167)

INSERT INTO openchpl.functionality_tested_criteria_map (criteria_id, functionality_tested_id, last_modified_user)
	SELECT 167, (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(i)'), -1
	WHERE NOT EXISTS
		(SELECT * from openchpl.functionality_tested_criteria_map
		WHERE criteria_id = 167
		AND functionality_tested_id = (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(i)'));
		
INSERT INTO openchpl.functionality_tested_criteria_map (criteria_id, functionality_tested_id, last_modified_user)
	SELECT 167, (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(ii)'), -1
	WHERE NOT EXISTS
		(SELECT * from openchpl.functionality_tested_criteria_map
		WHERE criteria_id = 167
		AND functionality_tested_id = (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(ii)'));
		
INSERT INTO openchpl.functionality_tested_criteria_map (criteria_id, functionality_tested_id, last_modified_user)
	SELECT 167, (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(iii)'), -1
	WHERE NOT EXISTS
		(SELECT * from openchpl.functionality_tested_criteria_map
		WHERE criteria_id = 167
		AND functionality_tested_id = (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(iii)'));
		
INSERT INTO openchpl.functionality_tested_criteria_map (criteria_id, functionality_tested_id, last_modified_user)
	SELECT 167, (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(iv)'), -1
	WHERE NOT EXISTS
		(SELECT * from openchpl.functionality_tested_criteria_map
		WHERE criteria_id = 167
		AND functionality_tested_id = (SELECT id FROM openchpl.functionality_tested WHERE number = '(b)(3)(ii)(C)(2)(iv)'));
