-- update description of currently deprecated collections endpoint to point to new search endpoint
UPDATE openchpl.deprecated_api
SET change_description = 'This endpoint is deprecated and will be removed in a future release. Please use /search/beta to access this data.'
WHERE http_method = 'GET'
AND api_operation = '/collections/certified_products';

-- add newly deprecated collections endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/collections/certified-products',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /search/beta to access this data.',
	'2022-06-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation = '/collections/certified-products');
