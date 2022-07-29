INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 'GET',
    '/certification_ids',
    'This endpoint is deprecated and will be removed in a future release. Please use /certification_ids/report-request to receive the CMS IDs file.',
    '2023-02-01',
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.deprecated_api
    WHERE http_method = 'GET'
    AND api_operation = '/certification_ids'
    AND deleted = false);