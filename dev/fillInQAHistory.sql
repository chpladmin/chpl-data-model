// 1 - Certification Criteria Added
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN json_array_length(original_data::json->'certificationResults') < json_array_length(new_data::json->'certificationResults') THEN json_array_length(original_data::json->'certificationResults') END as original, CASE WHEN json_array_length(original_data::json->'certificationResults') < json_array_length(new_data::json->'certificationResults') THEN json_array_length(new_data::json->'certificationResults') END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 2 - Certification Criteria Removed
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN json_array_length(original_data::json->'certificationResults') > json_array_length(new_data::json->'certificationResults') THEN json_array_length(original_data::json->'certificationResults') END as original, CASE WHEN json_array_length(original_data::json->'certificationResults') > json_array_length(new_data::json->'certificationResults') THEN json_array_length(new_data::json->'certificationResults') END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 3 - CQM Added
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN json_array_length(original_data::json->'certificationResults') < json_array_length(new_data::json->'certificationResults') THEN json_array_length(original_data::json->'certificationResults') END as original, CASE WHEN json_array_length(original_data::json->'certificationResults') < json_array_length(new_data::json->'certificationResults') THEN json_array_length(new_data::json->'certificationResults') END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 4 - CQM Removed
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN json_array_length(original_data::json->'certificationResults') > json_array_length(new_data::json->'certificationResults') THEN json_array_length(original_data::json->'certificationResults') END as original, CASE WHEN json_array_length(original_data::json->'certificationResults') > json_array_length(new_data::json->'certificationResults') THEN json_array_length(new_data::json->'certificationResults') END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// TODO: 5 - Measure Successfully Tested for 170.314 (g)(1) Edited
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(1) Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// TODO: 6 - Measure Successfully Tested for 170.314 (g)(2) Edited
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(2) Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 12 - Surveillance Removed
TRUNCATE openchpl.questionable_activity_listing;
SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Surveillance Removed'), (new_data::json->>'id')::bigint as listing_id, original_data, new_data, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
AND original_data IS NOT NULL AND new_data IS NOT NULL AND (original_data::json->'certificationEdition'->>'name')::bigint = 2011;

// 13 - 2011 Listing Edited
SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = '2011 Listing Edited'), (new_data::json->>'id')::bigint as listing_id, original_data, new_data, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
AND original_data IS NOT NULL AND new_data IS NOT NULL AND (original_data::json->'certificationEdition'->>'name')::bigint = 2011;

// 14 - Certification status edited
TRUNCATE openchpl.questionable_activity_listing;
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Status Edited'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN original_data::json->'certificationStatus'->>'name' END as original, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN new_data::json->'certificationStatus'->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 15 - Developer Name Edited
TRUNCATE openchpl.questionable_activity_developer;
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Name Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 16 - Developer Status Edited
TRUNCATE openchpl.questionable_activity_developer;
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->'statuses'->>'status')::text != (new_data::json->'statuses'->>'status')::text THEN original_data::json->'statuses'->>'status' END as original, CASE WHEN (original_data::json->'statuses'->>'status')::text != (new_data::json->'statuses'->>'status')::text THEN new_data::json->'statuses'->>'status' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 20 - Product name change
TRUNCATE openchpl.questionable_activity_product;
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Name Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 21 - Product owner change
TRUNCATE openchpl.questionable_activity_product;
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN original_data::json->>'developerId' END as original, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN new_data::json->>'developerId' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL)

// 25 - Version name change
TRUNCATE openchpl.questionable_activity_version;
INSERT INTO openchpl.questionable_activity_version (questionable_activity_trigger_id, version_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Version Name Edited'), (new_data::json->>'id')::bigint as version_id, original_data::json->>'version' as original_version, new_data::json->>'version' as new_version, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'VERSION') AND original_data IS NOT NULL AND new_data IS NOT NULL;


// Product owner history change
DO $$
BEGIN
	FOR productId IN 1..2768 LOOP
		INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user)
		SELECT 22, product_id, (original_data::json->>'developerId')::bigint, new_developer_id, creation_date, last_modified_user, last_modified_user FROM 
		((SELECT (new_data::json->>'id')::bigint as product_id, (new_data::json->>'developerId')::bigint as new_developer_id, count(*) 
		FROM openchpl.activity WHERE activity_object_concept_id = 2 AND new_data::json->>'id' = productId::text 
		GROUP BY product_id, new_developer_id HAVING count(*) < 2) inter 
		INNER JOIN openchpl.activity ON (inter.product_id = (activity.new_data::json->>'id')::bigint));
	END LOOP;
END; $$
LANGUAGE plpgsql;