-- Deployment file for version 23.3.1
--     as of 2023-04-03
-- ./changes/ocd-4148.sql
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
;
-- ./changes/ocd-4169.sql
-- hard delete since this is bad data that should have never been here

-- delete duplicate response
DELETE 
FROM openchpl.attestation_submission_response
WHERE attestation_submission_id = 671;

-- delete duplicate submission
DELETE 
FROM openchpl.attestation_submission
WHERE id = 671;

-- delete duplicate change request "Approved" status update
DELETE
FROM openchpl.change_request_status
WHERE id = 2021;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.3.1', '2023-04-03', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
