INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'POST'
AND api_operation = '/certified_products/pending/{pcpId:^-?\d+$}/beta/confirm'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'POST'
		AND api_operation = '/certified_products/pending/{pcpId:^-?\d+$}/beta/confirm'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/details'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{chplPrefix}-{identifier}/details'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/details'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{chplPrefix}-{identifier}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{chplPrefix}-{identifier}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{certifiedProductId:^-?\d+$}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/pending/{pcpId:^-?\d+$}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/pending/{pcpId:^-?\d+$}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/certified_products/{certifiedProductId}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/certified_products/{certifiedProductId}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'POST'
AND api_operation = '/certified_products/upload'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'POST'
		AND api_operation = '/certified_products/upload'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/collections/certified-products'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/collections/certified-products'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/listings/pending/{id}'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/listings/pending/{id}'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'POST'
AND api_operation = '/search/beta'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'POST'
		AND api_operation = '/search/beta'));

INSERT INTO openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT deprecated_response_field_api.id,
	'transparencyAttestation',
	'2022-03-01',
	'This field is deprecated and will be removed from the response data in a future release.',
	-1
FROM openchpl.deprecated_response_field_api
WHERE http_method = 'GET'
AND api_operation = '/search/beta'
AND NOT EXISTS
    (SELECT *
    FROM openchpl.deprecated_response_field
	WHERE response_field = 'transparencyAttestation'
	AND removal_date = '2022-03-01'
	AND change_description = 'This field is deprecated and will be removed from the response data in a future release.'
	AND deprecated_api_id =
	    (SELECT id
		FROM openchpl.deprecated_response_field_api
		WHERE http_method = 'GET'
		AND api_operation = '/search/beta'));
