-- remove deprecated response field API from /search/beta
-- the deprecated fields are marked deleted from a different table with the soft_delete trigger
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
