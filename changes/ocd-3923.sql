UPDATE openchpl.deprecated_api
SET deleted = true
WHERE http_method = 'DELETE'
and api_operation = '/listings/pending';