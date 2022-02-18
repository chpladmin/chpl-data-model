-- add newly deprecated endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'DELETE',
	'/listings/pending',
	NULL,
	'This endpoint is deprecated and will be removed in a future release.',
	'2022-09-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'DELETE' and api_operation LIKE '/listings/pending');