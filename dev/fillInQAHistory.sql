/* 1 - Certification Criteria Added */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added') as trigger_id, 
	all_listing_activity.listing_id, null as "before_data", cert_results_added_activity.cert_results_added as "after_data",
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) all_listing_activity

INNER JOIN 

-- This will give rows where the cert result number + cert result success field are 1 thing in 'new data' 
-- but are something different in 'original data'. All of the cert results are listed regardless of true/false success
-- so there will always be the same list of criteria in original data vs new data (meaning we are not looking for a 
-- piece of data that's present in one and missing in another; all of the cert results are always present
-- it's just the success flag that might have changed).
-- So for example, number '170.314 (b)(7)' + success 'f' in the resultset means that b7+false is
-- present in the new data but was NOT present in the original data. Therefore the success value of b7 is
-- FALSE in the new data and was TRUE in the original data and we can conclude that b7 was removed.
-- Similarly, if the success flag is 't' we know that the cert result was added (true in new data => false in original data)
(SELECT activity_id, activity_date, string_agg(number,';') as cert_results_added
--SELECT *
FROM
	-- pull back each cert result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.new_data::json->'certificationResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 

	EXCEPT ALL

	-- pull back each cert result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.original_data::json->'certificationResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	) diff
WHERE success = true -- switch to success = false for criteria removed
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cert_results_added_activity
ON all_listing_activity.activity_id = cert_results_added_activity.activity_id
)
;

/* 2 - Certification Criteria Removed */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Removed') as trigger_id, 
	all_listing_activity.listing_id, cert_results_added_activity.cert_results_removed as "before_data", null as "after_data",
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) all_listing_activity

INNER JOIN 

-- This will give rows where the cert result number + cert result success field are 1 thing in 'new data' 
-- but are something different in 'original data'. All of the cert results are listed regardless of true/false success
-- so there will always be the same list of criteria in original data vs new data (meaning we are not looking for a 
-- piece of data that's present in one and missing in another; all of the cert results are always present
-- it's just the success flag that might have changed).
-- So for example, number '170.314 (b)(7)' + success 'f' in the resultset means that b7+false is
-- present in the new data but was NOT present in the original data. Therefore the success value of b7 is
-- FALSE in the new data and was TRUE in the original data and we can conclude that b7 was removed.
-- Similarly, if the success flag is 't' we know that the cert result was added (true in new data => false in original data)
(SELECT activity_id, activity_date, string_agg(number,';') as cert_results_removed
--SELECT *
FROM
	-- pull back each cert result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.new_data::json->'certificationResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 

	EXCEPT ALL

	-- pull back each cert result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.original_data::json->'certificationResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	) diff
WHERE success = false -- switch to success = false for criteria removed
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cert_results_added_activity
ON all_listing_activity.activity_id = cert_results_added_activity.activity_id
)
;

/* 3 - CQM Added */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'CQM Added') as trigger_id, 
	all_listing_activity.listing_id, null as "before_data", cert_results_added_activity.cert_results_added as "after_data",
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) all_listing_activity

INNER JOIN 

-- This will give rows where the cert result number + cert result success field are 1 thing in 'new data' 
-- but are something different in 'original data'. All of the cert results are listed regardless of true/false success
-- so there will always be the same list of criteria in original data vs new data (meaning we are not looking for a 
-- piece of data that's present in one and missing in another; all of the cert results are always present
-- it's just the success flag that might have changed).
-- So for example, number '170.314 (b)(7)' + success 'f' in the resultset means that b7+false is
-- present in the new data but was NOT present in the original data. Therefore the success value of b7 is
-- FALSE in the new data and was TRUE in the original data and we can conclude that b7 was removed.
-- Similarly, if the success flag is 't' we know that the cert result was added (true in new data => false in original data)
(SELECT activity_id, activity_date, string_agg(number,';') as cert_results_added
--SELECT *
FROM
	-- pull back each cert result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.new_data::json->'cqmResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 

	EXCEPT ALL

	-- pull back each cert result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.original_data::json->'cqmResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	) diff
WHERE success = true -- switch to success = false for criteria removed
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cert_results_added_activity
ON all_listing_activity.activity_id = cert_results_added_activity.activity_id
)
;

/* 4 - CQM Removed */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'CQM Removed') as trigger_id, 
	all_listing_activity.listing_id, cert_results_added_activity.cqm_results_removed as "before_data", null as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) all_listing_activity

INNER JOIN 

-- This will give rows where the cert result number + cert result success field are 1 thing in 'new data' 
-- but are something different in 'original data'. All of the cert results are listed regardless of true/false success
-- so there will always be the same list of criteria in original data vs new data (meaning we are not looking for a 
-- piece of data that's present in one and missing in another; all of the cert results are always present
-- it's just the success flag that might have changed).
-- So for example, number '170.314 (b)(7)' + success 'f' in the resultset means that b7+false is
-- present in the new data but was NOT present in the original data. Therefore the success value of b7 is
-- FALSE in the new data and was TRUE in the original data and we can conclude that b7 was removed.
-- Similarly, if the success flag is 't' we know that the cert result was added (true in new data => false in original data)
(SELECT activity_id, activity_date, string_agg(number,';') as cqm_results_removed
--SELECT *
FROM
	-- pull back each cert result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.new_data::json->'cqmResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 

	EXCEPT ALL

	-- pull back each cert result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, certResult.number, certResult.success
	FROM
	openchpl.activity
	CROSS JOIN LATERAL
	json_to_recordset(activity.original_data::json->'cqmResults') as certResult("number" text, "success" boolean)
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	) diff
WHERE success = false -- switch to success = false for criteria removed
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cert_results_added_activity
ON all_listing_activity.activity_id = cert_results_added_activity.activity_id
)
;

/* TODO: 5 - Measure Successfully Tested for 170.314 (g)(1) Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(1) Edited'), certification_result_id, null, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as certification_result_id,
CASE WHEN (SELECT count(*) FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, g1success text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, g1success text))) diff) > 0 
THEN (SELECT string_agg(number || ':' || g1success, ';') FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, g1success text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, g1success text))) diff) END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE new IS NOT NULL);

/* TODO: 6 - Measure Successfully Tested for 170.314 (g)(2) Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(2) Edited'), certification_result_id, null, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as certification_result_id,
CASE WHEN (SELECT count(*) FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, g2Success text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, g2Success text))) diff) > 0 
THEN (SELECT string_agg(number || ':' || g2Success, ';') FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, g2Success text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, g2Success text))) diff) END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE new IS NOT NULL);

/* TODO: 7 - Measure Successfully Tested for 170.315 (g)(1) Added */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
VALUES (7, 452707, null, '170.315 (b)(3):EC Individual (TIN/NPI)', '2017-09-10 14:52:30.569', 5, 5, '2017-09-10 14:52:30.569', '2017-09-10 14:52:30.569');

/* TODO: 10 - Measure Successfully Tested for 170.315 (g)(2) Removed */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
VALUES (8, 446650, '170.315 (a)(1):EH/CAH;170.315 (a)(10):EH/CAH;170.315 (a)(13):EH/CAH;170.315 (a)(2):EH/CAH;170.315 (a)(3):RT8 EH/CAH,RT7 EH/CAH;170.315 (b)(2):EH/CAH;170.315 (b)(3):EH/CAH;170.315 (e)(1):RT2a EH/CAH,RT4a EH/CAH;170.315 (e)(2):EH/CAH;170.315 (e)(3):EH/CAH', null, '2017-08-22 17:25:17.046', -2, -2, '2017-08-22 17:25:17.046', '2017-08-22 17:25:17.046');

/* TODO: 11 - GAP Status Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'GAP Status Edited'), certification_result_id, null, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as certification_result_id,
CASE WHEN (SELECT count(*) FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, gap text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, gap text))) diff) > 0 
THEN (SELECT string_agg(number || ':' || gap, ';') FROM ((SELECT * FROM json_to_recordset(original_data::json->'certificationResults') as results(number text, gap text)) EXCEPT ALL (SELECT * FROM json_to_recordset(new_data::json->'certificationResults') as results(number text, gap text))) diff) END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE new IS NOT NULL);

/* 12 - Surveillance Removed */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Surveillance Removed'), listing_id, before_data, after_data, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN new_data::json->>'surveillance' = '[]' AND original_data::json->>'surveillance' != '[]' THEN original_data::json->>'id' END as before_data, CASE WHEN new_data::json->>'surveillance' = '[]' AND original_data::json->>'surveillance' != '[]' THEN original_data::json->>'id' END as after_data, creation_date, last_modified_user as activity_user_id, last_modified_user
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as surv
WHERE before_data IS NOT NULL AND after_data IS NOT NULL);

/* 13 - 2011 Listing Edited */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = '2011 Listing Edited'), (new_data::json->>'id')::bigint as listing_id, original_data, new_data, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
AND original_data IS NOT NULL AND new_data IS NOT NULL AND (original_data::json->'certificationEdition'->>'name')::bigint = 2011;

/* 14 - Certification status edited */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Status Edited'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN original_data::json->'certificationStatus'->>'name' END as original, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN new_data::json->'certificationStatus'->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 15 - Developer Name Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Name Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 16 - Developer Status Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->'statuses'->>'status')::text != (new_data::json->'statuses'->>'status')::text THEN original_data::json->'statuses'->>'status' END as original, CASE WHEN (original_data::json->'statuses'->>'status')::text != (new_data::json->'statuses'->>'status')::text THEN new_data::json->'statuses'->>'status' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 17 - Developer Status History Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status History Edited'), 
	developer_status_added_activity.developer_id, 
	developer_status_old_activity.old_status, 
	developer_status_new_activity.new_status, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, developer_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER'))) diff) developer_status_added_activity
ON developer_status_added_activity.activity_id = activity.activity_id
WHERE developer_status_added_activity IS NOT NULL;

/* 18 - Developer Status History Added */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status History Added'), 
	developer_status_added_activity.developer_id, 
	null, 
	developer_status_added_activity.added, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, developer_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND json_array_length(original_data::json->'statusEvents') < json_array_length(new_data::json->'statusEvents'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND json_array_length(original_data::json->'statusEvents') < json_array_length(new_data::json->'statusEvents'))) diff) developer_status_added_activity
ON developer_status_added_activity.activity_id = activity.activity_id
WHERE developer_status_added_activity IS NOT NULL;

/* 19 - Developer Status History Removed */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status History Removed'), 
	developer_status_removed_activity.developer_id,
	developer_status_removed_activity.removed, 
	null,
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, developer_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as removed
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND json_array_length(original_data::json->'statusEvents') > json_array_length(new_data::json->'statusEvents'))
	
	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND json_array_length(original_data::json->'statusEvents') > json_array_length(new_data::json->'statusEvents'))) diff) developer_status_removed_activity
ON developer_status_removed_activity.activity_id = activity.activity_id
WHERE developer_status_removed_activity IS NOT NULL;

/* 20 - Product name change */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Name Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 21 - Product owner change */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN original_data::json->>'developerId' END as original, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN new_data::json->>'developerId' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')) as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 22 - Product owner history change */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Edited'), 
	developer_status_added_activity.product_id, 
	null, 
	developer_status_added_activity.added, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT'))) diff) developer_status_added_activity
ON developer_status_added_activity.activity_id = activity.activity_id
WHERE developer_status_added_activity IS NOT NULL;

/* 23 - Product Owner History Added */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Added'), 
	developer_status_added_activity.product_id, 
	null, 
	developer_status_added_activity.added, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND json_array_length(original_data::json->'ownerHistory') < json_array_length(new_data::json->'ownerHistory'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND json_array_length(original_data::json->'ownerHistory') < json_array_length(new_data::json->'ownerHistory'))) diff) developer_status_added_activity
ON developer_status_added_activity.activity_id = activity.activity_id
WHERE developer_status_added_activity IS NOT NULL;

/* 24 - Product Owner History Removed */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Removed'), 
	developer_status_added_activity.product_id,
	developer_status_added_activity.removed, 
	null, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as removed
FROM
	((SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as status_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND json_array_length(original_data::json->'ownerHistory') > json_array_length(new_data::json->'ownerHistory'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as status_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND json_array_length(original_data::json->'ownerHistory') > json_array_length(new_data::json->'ownerHistory'))) diff) developer_status_added_activity
ON developer_status_added_activity.activity_id = activity.activity_id
WHERE developer_status_added_activity IS NOT NULL;

/* 25 - Version name change */
INSERT INTO openchpl.questionable_activity_version (questionable_activity_trigger_id, version_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Version Name Edited'), (new_data::json->>'id')::bigint as version_id, original_data::json->>'version' as original_version, new_data::json->>'version' as new_version, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'VERSION') AND original_data IS NOT NULL AND new_data IS NOT NULL);