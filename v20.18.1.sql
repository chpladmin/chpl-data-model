-- Deployment file for version 20.18.1
--     as of 2022-06-27
-- ./changes/ocd-3956.sql
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
AND api_operation = '/change-requests/{changeRequestId}';;
-- ./changes/ocd-3989.sql
UPDATE openchpl.conformance_method
SET name = 'Drummond G10+ FHIR API powered by Touchstone'
WHERE name = 'Touchstone';;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.18.1', '2022-06-27', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
