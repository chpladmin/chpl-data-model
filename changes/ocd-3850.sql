-- remove deprecated response field API from /search/beta
UPDATE openchpl.deprecated_response_field_api
SET deleted = false
WHERE api_operation = '/search/beta';

-- remove deprecated response field usage from /search/beta
UPDATE openchpl.deprecated_response_field_api_usage
SET deleted = true
WHERE deprecated_response_field_api_id IN(
	SELECT id 
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id IN (
		SELECT id 
		FROM openchpl.deprecated_response_field_api
		WHERE api_operation = '/search/beta'));

-- add /search/beta as deprecated endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/search/beta',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /search/v2 to perform searches.',
	'2022-09-07',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/search/beta');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'POST',
	'/search/beta',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please POST to /search/v2 to perform searches.',
	'2022-09-07',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation LIKE '/search/beta');