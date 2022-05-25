-- IcsFamilyTreeNode
-- /certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/ics_relationships') and response_field = 'version -> versionId');

-- IcsFamilyTreeNode
-- /certified-products/{chplPrefix}-{identifier}/ics_relationships
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{chplPrefix}-{identifier}/ics_relationships') and response_field = 'version -> versionId');

-- IcsFamilyTreeNode
-- /certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified-products/{certifiedProductId:^-?\\d+$}/ics_relationships') and response_field = 'version -> versionId');

-- CertifiedProductSearchDetails
-- /certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details') and response_field = 'version -> versionId');

-- CertifiedProductSearchDetails
-- /certified_products/{chplPrefix}-{identifier}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details') and response_field = 'version -> versionId');

-- CertifiedProductSearchDetails
-- /certified_products/{certifiedProductId:^-?\d+$}/details
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details') and response_field = 'version -> versionId');

-- CertifiedProductSearchDetails
-- GET /listings/pending/{id:^-?\\d+$}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/listings/pending/{id:^-?\\d+$}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/listings/pending/{id:^-?\\d+$}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'surveillance -> authority',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2022-05-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'surveillance -> authority');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}') and response_field = 'version -> versionId');

-- CertifiedProductSearchDetails
-- GET /listings/pending/{id:^-?\\d+$}/submitted
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/listings/pending/{id:^-?\\d+$}/submitted', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/listings/pending/{id:^-?\\d+$}/submitted');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'surveillance -> authority',
	'This field is deprecated and will be removed from the response data in a future release.',
	'2022-05-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'surveillance -> authority');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/listings/pending/{id:^-?\\d+$}/submitted') and response_field = 'version -> versionId');


-- CertifiedProductSearchDetails
-- PUT /certified_products/{certifiedProductId}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/certified_products/{certifiedProductId}') and response_field = 'version -> versionId');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}') and response_field = 'version -> versionId');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{chplPrefix}-{identifier}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{chplPrefix}-{identifier}') and response_field = 'version -> versionId');

-- CertifiedProductSearchBasicDetails
-- /certified_products/{certifiedProductId:^-?\d+$}
INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'product -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'product -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'product -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'product -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'product -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use product -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'product -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'),
	'version -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use version -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}') and response_field = 'version -> versionId');

-- ChangeRequest
-- GET /change-requests/{changeRequestId}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/change-requests/{changeRequestId}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/change-requests/{changeRequestId}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/change-requests/{changeRequestId}'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/change-requests/{changeRequestId}') and response_field = 'developer -> developerId');

-- ChangeRequest
-- GET /change-requests
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/change-requests', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/change-requests');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/change-requests'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/change-requests') and response_field = 'developer -> developerId');

-- ChangeRequest
-- PUT /change-requests
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'PUT', '/change-requests', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation = '/change-requests');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/change-requests'),
	'developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/change-requests') and response_field = 'developer -> developerId');

-- ChangeRequestResults
-- POST /change-requests
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'POST', '/change-requests', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation = '/change-requests');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/change-requests'),
	'results -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use results -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/change-requests') and response_field = 'results -> developer -> developerId');

-- DeveloperResults
-- GET /developers
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/developers', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/developers');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers'),
	'developers -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use developers -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers') and response_field = 'developers -> developerId');

-- Developer
-- GET /developers/{developerId}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/developers/{developerId}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/developers/{developerId}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}'),
	'developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}') and response_field = 'developerId');

-- PUT /developers/{developerId}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'PUT', '/developers/{developerId}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation = '/developers/{developerId}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/developers/{developerId}'),
	'developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/developers/{developerId}') and response_field = 'developerId');

-- DeveloperTree
-- GET /developers/{developerId}/hierarchy
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/developers/{developerId}/hierarchy', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/developers/{developerId}/hierarchy');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy'),
	'developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy') and response_field = 'developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy'),
	'products -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy') and response_field = 'products -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy'),
	'products -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy') and response_field = 'products -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy'),
	'products -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy') and response_field = 'products -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy'),
	'products -> versions -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> versions -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/developers/{developerId}/hierarchy') and response_field = 'products -> versions -> versionId');

-- ProductResults
-- GET /products
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/products', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/products');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products'),
	'products -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products') and response_field = 'products -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products'),
	'products -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products') and response_field = 'products -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products'),
	'products -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use products -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products') and response_field = 'products -> ownerHistory -> developer -> developerId');

-- Product
-- GET /products/{productId}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/products/{productId}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/products/{productId}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}'),
	'productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}') and response_field = 'productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}'),
	'owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}') and response_field = 'owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}'),
	'ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/products/{productId}') and response_field = 'ownerHistory -> developer -> developerId');

-- PUT /products
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'PUT', '/products', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation = '/products');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products'),
	'productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products') and response_field = 'productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products'),
	'owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products') and response_field = 'owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products'),
	'ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/products') and response_field = 'ownerHistory -> developer -> developerId');


-- SplitProductResponse
-- POST /products/{productId}/split
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'POST', '/products/{productId}/split', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation = '/products/{productId}/split');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'oldProduct -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use oldProduct -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'oldProduct -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'oldProduct -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use oldProduct -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'oldProduct -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'oldProduct -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use oldProduct -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'oldProduct -> ownerHistory -> developer -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'newProduct -> productId',
	'This field is deprecated and will be removed from the response data in a future release. Please use newProduct -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'newProduct -> productId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'newProduct -> owner -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use newProduct -> owner -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'newProduct -> owner -> developerId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split'),
	'newProduct -> ownerHistory -> developer -> developerId',
	'This field is deprecated and will be removed from the response data in a future release. Please use newProduct -> ownerHistory -> developer -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/products/{productId}/split') and response_field = 'newProduct -> ownerHistory -> developer -> developerId');

-- ProductVersion
-- GET /versions/{versionId}
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/versions/{versionId}', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/versions/{versionId}');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/versions/{versionId}'),
	'versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/versions/{versionId}') and response_field = 'versionId');

-- GET /versions
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'GET', '/versions', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation = '/versions');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/versions'),
	'versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'GET' AND api_operation = '/versions') and response_field = 'versionId');

-- PUT /versions
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'PUT', '/versions', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation = '/versions');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/versions'),
	'versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'PUT' AND api_operation = '/versions') and response_field = 'versionId');


-- SplitVersionResponse
-- POST /versions/{versionId}/split
INSERT INTO openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
SELECT 'POST', '/versions/{versionId}/split', -1
WHERE NOT EXISTS (SELECT * from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation = '/versions/{versionId}/split');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/versions/{versionId}/split'),
	'oldVersion -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use oldVersion -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/versions/{versionId}/split') and response_field = 'oldVersion -> versionId');

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, change_description, removal_date, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/versions/{versionId}/split'),
	'newVersion -> versionId',
	'This field is deprecated and will be removed from the response data in a future release. Please use newVersion -> id.',
	'2022-11-30',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_response_field WHERE deprecated_api_id = (SELECT id FROM openchpl.deprecated_response_field_api WHERE http_method = 'POST' AND api_operation = '/versions/{versionId}/split') and response_field = 'newVersion -> versionId');


