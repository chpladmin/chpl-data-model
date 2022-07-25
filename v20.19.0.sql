-- Deployment file for version 20.19.0
--     as of 2022-07-25
-- ./changes/ocd-3873.sql
INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 'GET',
    '/developers/{developerId}/attestations/exception',
    'This endpoint is deprecated and will be removed in a future release. Please use /developers/{developerId}/attestations/{attestationPeriodId}/exception to get the Attestation Form for an Attestation Period',
    '2023-01-01',
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.deprecated_api
    WHERE http_method = 'GET'
    AND api_operation = '/developers/{developerId}/attestations/exception'
    AND deleted = false);

INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 'GET',
    '/attestations/form',
    'This endpoint is deprecated and will be removed in a future release. Please use /attestations/periods/{periodId}/form to get the Attestation Form for an Attestation Period',
    '2023-01-01',
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.deprecated_api
    WHERE http_method = 'GET'
    AND api_operation = '/attestations/form'
    AND deleted = false);

INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET',
    '/developers/{developerId}/attestations',
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.deprecated_response_field_api
    WHERE http_method = 'GET'
    AND api_operation = '/developers/{developerId}/attestations'
    AND deleted = false);

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT
    (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/attestations'),
    'canSubmitAttestationChangeRequest',
    '2023-01-01',
    'This field is deprecated and will be removed from the response data in a future release. Please use submittablePeriod.',
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.deprecated_response_field
    WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/attestations')
    AND response_field = 'canSubmitAttestationChangeRequest'
    AND deleted = false);
;
-- ./changes/ocd-3951.sql
UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'GET'
AND api_operation = '/complaints';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'POST'
AND api_operation = '/complaints';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'PUT'
AND api_operation = '/complaints/{complaintId}';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'GET'
AND api_operation = '/surveillance-report/quarterly/{quarterlyReportId}/listings';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'GET'
AND api_operation = '/surveillance-report/quarterly/{quarterlyReportId}/complaints';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE http_method = 'PUT'
AND api_operation = '/surveillance-report/quarterly/{quarterlyReportId}/listings/{listingId}';

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE id IN (249, 250, 251, 252, 253, 254, 256, 261, 262, 263, 264, 265, 266, 269, 349, 355);



;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.19.0', '2022-07-25', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
