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
