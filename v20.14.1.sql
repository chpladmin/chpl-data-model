-- Deployment file for version 20.14.1
--     as of 2022-04-01
-- ./changes/ocd-3751.sql
-- conformance method version IS allowed to be NULL
ALTER TABLE openchpl.certification_result_conformance_method
ALTER COLUMN version DROP NOT NULL;

-- add newly deprecated endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'DELETE',
	'/listings/pending',
	NULL,
	'This endpoint is deprecated and will be removed in a future release.',
	'2022-09-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'DELETE' and api_operation LIKE '/listings/pending');;
-- ./changes/ocd-3881.sql
INSERT INTO openchpl.surveillance_requirement_type (name, last_modified_user)
SELECT 'Attestations Submission', -1
WHERE NOT EXISTS(
   SELECT *
   FROM openchpl.surveillance_requirement_type
   WHERE name = 'Attestations Submission'
);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.14.1', '2022-04-01', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
