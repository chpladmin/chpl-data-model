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

