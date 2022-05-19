UPDATE openchpl.deprecated_api
SET deleted = true
WHERE removal_date = '04-15-2022'
and api_operation = '/meaningful_use/upload';

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE removal_date = '04-15-2022'
AND response_field = 'meaningfulUseUserHistory';
