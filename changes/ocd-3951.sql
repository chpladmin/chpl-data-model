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



