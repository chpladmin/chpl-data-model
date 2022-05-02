-- TODO: After OCD-3921 gets merged, find any records in deprecated_response_field_api that no longer have any deprecated_response_fields and clean those up


-- versionId deprecation
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'version -> versionId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'version -> versionId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'version -> versionId');