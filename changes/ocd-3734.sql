ALTER TABLE openchpl.deprecated_api
ADD COLUMN IF NOT EXISTS removal_date date;

ALTER TABLE openchpl.deprecated_api
ADD COLUMN IF NOT EXISTS response_field text;

DROP UNIQUE INDEX deprecated_api_unique_method_and_api_operation_and_parameter;

CREATE UNIQUE INDEX deprecated_api_unique_method_and_api_operation_and_parameter
ON openchpl.deprecated_api(http_method, api_operation, request_parameter, response_field)
WHERE deleted = false;