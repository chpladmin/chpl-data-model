-- Deployment file for version 20.11.0
--     as of 2021-11-29
-- ./changes/ocd-3771.sql
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
;
-- ./changes/ocd-3803.sql
update openchpl.optional_standard
set description = 'CCDS: SNOMED CT® U.S. Edition, September 2019 Release'
where citation = 'CCDS Ref: 170.207(a)(4)';

update openchpl.optional_standard
set description = 'USCDI: SNOMED CT® U.S. Edition, September 2019 Release'
where citation = 'USCDI Ref: 170.207(a)(4)';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.11.0', '2021-11-29', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
