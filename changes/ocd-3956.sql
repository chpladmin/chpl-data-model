INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 
	'GET',
	'/change-requests',
	'This endpoint is deprecated and will be removed in a future release. Please use /change-requests/search.',
	'2022-12-31',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' AND api_operation = '/change-requests');

-- ChangeRequest has a deprecated response field - developerId
-- We need to remove /change-requests from the deprecated_response_field_api table data 
-- since the whole endpoint is now deprecated
UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'GET'
AND api_operation = '/change-requests'
AND deleted = false;

-- Update '/change-requests/{changeRequestId}' so mapping is not ambiguous with new /change-requests/search endpoint
UPDATE openchpl.deprecated_response_field_api
SET api_operation = '/change-requests/{changeRequestId:^-?\d+$}'
WHERE http_method = 'GET'
AND api_operation = '/change-requests/{changeRequestId}';