-- CertifiedProductSearchDetails
-- /certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchDetails
-- /certified_products/{chplPrefix}-{identifier}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchDetails
-- /certified_products/{certifiedProductId:^-?\d+$}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchDetails
-- GET /listings/pending/{id:^-?\d+$}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchDetails
-- GET /listings/pending/{id:^-?\d+$}/submitted
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}/submitted'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}/submitted') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}/submitted'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\d+$}/submitted') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchDetails
-- PUT /certified_products/{certifiedProductId}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{chplPrefix}-{identifier}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{certifiedProductId:^-?\d+$}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'surveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'surveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'surveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'surveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- Surveillance
-- /suveillance/pending/confirm
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/pending/confirm'),
	'requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/pending/confirm') and response_field = 'requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/pending/confirm'),
	'requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/pending/confirm') and response_field = 'requirements -> nonconformities -> nonconformityTypeName');

-- Surveillance
-- /suveillance
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance'),
	'requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance') and response_field = 'requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance'),
	'requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance') and response_field = 'requirements -> nonconformities -> nonconformityTypeName');

-- Surveillance
-- /suveillance/{surveillanceId}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/surveillance/{surveillanceId}'),
	'requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/surveillance/{surveillanceId}') and response_field = 'requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/surveillance/{surveillanceId}'),
	'requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/surveillance/{surveillanceId}') and response_field = 'requirements -> nonconformities -> nonconformityTypeName');

-- SurveillanceResults
-- /suveillance/pending
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/surveillance/pending'),
	'pendingSurveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/surveillance/pending') and response_field = 'pendingSurveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/surveillance/pending'),
	'pendingSurveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/surveillance/pending') and response_field = 'pendingSurveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- SurveillanceResults
-- /suveillance/upload
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/upload'),
	'pendingSurveillance -> requirements -> requirementName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/upload') and response_field = 'pendingSurveillance -> requirements -> requirementName');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/upload'),
	'pendingSurveillance -> requirements -> nonconformities -> nonconformityTypeName',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/surveillance/upload') and response_field = 'pendingSurveillance -> requirements -> nonconformities -> nonconformityTypeName');

-- Add Non-Conformity Document is deprecated 
-- POST to '/surveillance/{surveillanceId}/nonconformity/{nonconformityId}/document'
INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 
	'POST',
	'/surveillance/{surveillanceId}/nonconformity/{nonconformityId}/document',
	'This endpoint is deprecated and will be removed in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'POST' and api_operation = '/surveillance/{surveillanceId}/nonconformity/{nonconformityId}/document');

-- Delete Non-conformity Document is deprecated
-- DELETE to '/surveillance/{surveillanceId}/document/{docId}'
INSERT INTO openchpl.deprecated_api (http_method, api_operation, change_description, removal_date, last_modified_user)
SELECT 
	'DELETE',
	'/surveillance/{surveillanceId}/document/{docId}',
	'This endpoint is deprecated and will be removed in a future release.',
	'2023-01-01',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'DELETE' and api_operation = '/surveillance/{surveillanceId}/document/{docId}');


