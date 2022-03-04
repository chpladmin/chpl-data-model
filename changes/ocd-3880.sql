-- add deprecated endpoint for /developers/{developerId}/public-attestations
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/developers/{developerId}/public-attestations',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please GET a specific developer with /developers/{developerId} to access its public attestation data.',
	'2022-10-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api 
					WHERE http_method = 'GET' 
					AND api_operation LIKE 	'/developers/{developerId}/public-attestations');
