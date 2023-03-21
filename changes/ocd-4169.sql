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
