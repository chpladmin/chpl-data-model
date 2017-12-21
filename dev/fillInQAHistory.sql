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
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

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
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

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
	all_listing_activity.listing_id, null as "before_data", cqm_results_added_activity.cqm_results_added as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

INNER JOIN 

(SELECT activity_id, activity_date, string_agg(cmsId,';') as cqm_results_added
FROM
	-- pull back each cqm result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, value::json->>'cmsId' as cmsId, value::json->>'success' as success
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'cqmResults')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00'

	EXCEPT ALL

	-- pull back each cqm result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, value::json->>'cmsId' as cmsId, value::json->>'success' as success
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'cqmResults')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00'
	) diff
WHERE success::boolean = true
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cqm_results_added_activity
ON all_listing_activity.activity_id = cqm_results_added_activity.activity_id
)
;

/* 4 - CQM Removed */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'CQM Removed') as trigger_id, 
	all_listing_activity.listing_id, cqm_results_removed_activity.cqm_results_removed as "before_data", null as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

INNER JOIN 

(SELECT activity_id, activity_date, string_agg(cmsId,';') as cqm_results_removed
FROM
	-- pull back each cqm result number and success value from the new data as columns
	(SELECT activity.activity_id, activity.activity_date, value::json->>'cmsId' as cmsId, value::json->>'success' as success
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'cqmResults')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00'

	EXCEPT ALL

	-- pull back each cqm result number and success value from the original data as columns
	SELECT activity.activity_id, activity.activity_date, value::json->>'cmsId' as cmsId, value::json->>'success' as success
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'cqmResults')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00'
	) diff
WHERE success::boolean = false -- switch to success = false for criteria removed
AND diff IS NOT NULL
GROUP BY activity_id, activity_date, success
ORDER BY diff.activity_id) cqm_results_removed_activity
ON all_listing_activity.activity_id = cqm_results_removed_activity.activity_id
)
;

/* TODO: 5 - Measure Successfully Tested for 170.314 (g)(1) Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(1) Edited') as trigger_id, 
	--old activity does not have certification result id, so if that field is null look it up by listing id and cert result number
	COALESCE(g1_success_edited_activity.certification_result_id::bigint, 
		(SELECT certification_result_id::bigint 
		FROM openchpl.certification_result 
		INNER JOIN openchpl.certification_criterion ON certification_result.certification_criterion_id = certification_criterion.certification_criterion_id
		WHERE certified_product_id = all_listing_activity.listing_id
		AND certification_criterion.number = g1_success_edited_activity.certification_result_number)) as certification_result_id,
	g1_success_edited_activity.g1_success_old as "before_data", 
	g1_success_edited_activity.g1_success_new as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

INNER JOIN 

(SELECT activity_id, activity_date, certification_result_number, certification_result_id, g1_success_old, g1_success_new
FROM
	(
	SELECT origRecord.activity_id, origRecord.activity_date, origRecord.certification_result_number, origRecord.certification_result_id, origRecord.g1_success_old, newRecord.g1_success_new 
	FROM

	(SELECT activity.activity_id, activity.activity_date, old_value::json->>'number' as certification_result_number, old_value::json->>'id' as certification_result_id, old_value::json->>'g1Success' as g1_success_old
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'certificationResults') as old_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') origRecord
	JOIN
	(SELECT activity.activity_id, activity.activity_date, new_value::json->>'number' as certification_result_number, new_value::json->>'id' as certification_result_id, new_value::json->>'g1Success' as g1_success_new
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'certificationResults') as new_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') newRecord
	ON origRecord.activity_id = newRecord.activity_id 
	AND origRecord.certification_result_number = newRecord.certification_result_number 
	WHERE g1_success_old != g1_success_new
	) diff
ORDER BY diff.activity_id) g1_success_edited_activity
ON all_listing_activity.activity_id = g1_success_edited_activity.activity_id
)
;

/* TODO: 6 - Measure Successfully Tested for 170.314 (g)(2) Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measure Successfully Tested for 170.314 (g)(1) Edited') as trigger_id, 
	--old activity does not have certification result id, so if that field is null look it up by listing id and cert result number
	COALESCE(g2_success_edited_activity.certification_result_id::bigint, 
		(SELECT certification_result_id::bigint 
		FROM openchpl.certification_result 
		INNER JOIN openchpl.certification_criterion ON certification_result.certification_criterion_id = certification_criterion.certification_criterion_id
		WHERE certified_product_id = all_listing_activity.listing_id
		AND certification_criterion.number = g2_success_edited_activity.certification_result_number)) as certification_result_id,
	g2_success_edited_activity.g2_success_old as "before_data", 
	g2_success_edited_activity.g2_success_new as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

INNER JOIN 

(SELECT activity_id, activity_date, certification_result_number, certification_result_id, g2_success_old, g2_success_new
FROM
	(
	SELECT origRecord.activity_id, origRecord.activity_date, origRecord.certification_result_number, origRecord.certification_result_id, origRecord.g2_success_old, newRecord.g2_success_new 
	FROM

	(SELECT activity.activity_id, activity.activity_date, old_value::json->>'number' as certification_result_number, old_value::json->>'id' as certification_result_id, old_value::json->>'g2Success' as g2_success_old
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'certificationResults') as old_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') origRecord
	JOIN
	(SELECT activity.activity_id, activity.activity_date, new_value::json->>'number' as certification_result_number, new_value::json->>'id' as certification_result_id, new_value::json->>'g2Success' as g2_success_new
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'certificationResults') as new_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') newRecord
	ON origRecord.activity_id = newRecord.activity_id 
	AND origRecord.certification_result_number = newRecord.certification_result_number 
	WHERE g2_success_old != g2_success_new
	) diff
ORDER BY diff.activity_id) g2_success_edited_activity
ON all_listing_activity.activity_id = g2_success_edited_activity.activity_id
)
;

/* TODO: 7 - Measure Successfully Tested for 170.315 (g)(1) Added */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
VALUES (7, 452707, null, '170.315 (b)(3):EC Individual (TIN/NPI)', '2017-09-10 14:52:30.569', 5, 5, '2017-09-10 14:52:30.569', '2017-09-10 14:52:30.569');

/* TODO: 10 - Measure Successfully Tested for 170.315 (g)(2) Removed */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
VALUES (8, 446650, '170.315 (a)(1):EH/CAH;170.315 (a)(10):EH/CAH;170.315 (a)(13):EH/CAH;170.315 (a)(2):EH/CAH;170.315 (a)(3):RT8 EH/CAH,RT7 EH/CAH;170.315 (b)(2):EH/CAH;170.315 (b)(3):EH/CAH;170.315 (e)(1):RT2a EH/CAH,RT4a EH/CAH;170.315 (e)(2):EH/CAH;170.315 (e)(3):EH/CAH', null, '2017-08-22 17:25:17.046', -2, -2, '2017-08-22 17:25:17.046', '2017-08-22 17:25:17.046');

/* TODO: 11 - GAP Status Edited */
INSERT INTO openchpl.questionable_activity_certification_result (questionable_activity_trigger_id, certification_result_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT 	
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'GAP Status Edited') as trigger_id, 
	--old activity does not have certification result id, so if that field is null look it up by listing id and cert result number
	COALESCE(gap_edited_activity.certification_result_id::bigint, 1) as certification_result_id,
	gap_edited_activity.gap_old as "before_data", 
	gap_edited_activity.gap_new as "after_data", 
	creation_date, activity_user_id, last_modified_user, creation_date, creation_date
FROM
(
--get all activity of the relevant concept and pull out the fields necessary for inserting questionable activity
(SELECT activity.activity_id, activity.creation_date, last_modified_user as activity_user_id, activity.last_modified_date, activity.last_modified_user, (new_data::json->>'id')::bigint as listing_id 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND original_data IS NOT NULL 
AND new_data IS NOT NULL
AND activity_date < '2017-11-07 00:00:00') all_listing_activity

INNER JOIN 

(SELECT activity_id, activity_date, certification_result_number, certification_result_id, gap_old, gap_new
FROM
	(
	SELECT origRecord.activity_id, origRecord.activity_date, origRecord.certification_result_number, origRecord.certification_result_id, origRecord.gap_old, newRecord.gap_new 
	FROM

	(SELECT activity.activity_id, activity.activity_date, old_value::json->>'number' as certification_result_number, old_value::json->>'id' as certification_result_id, old_value::json->>'gap' as gap_old
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'certificationResults') as old_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') origRecord
	JOIN
	(SELECT activity.activity_id, activity.activity_date, new_value::json->>'number' as certification_result_number, new_value::json->>'id' as certification_result_id, new_value::json->>'gap' as gap_new
	FROM
	openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'certificationResults') as new_value
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
	AND activity_date < '2017-11-07 00:00:00') newRecord
	ON origRecord.activity_id = newRecord.activity_id 
	AND origRecord.certification_result_number = newRecord.certification_result_number 
	WHERE gap_old != gap_new
	) diff
ORDER BY diff.activity_id) gap_edited_activity
ON all_listing_activity.activity_id = gap_edited_activity.activity_id
)
;

/* 12 - Surveillance Removed */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Surveillance Removed'), listing_id, before_data, after_data, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN new_data::json->>'surveillance' = '[]' AND original_data::json->>'surveillance' != '[]' THEN original_data::json->>'id' END as before_data, CASE WHEN new_data::json->>'surveillance' = '[]' AND original_data::json->>'surveillance' != '[]' THEN original_data::json->>'id' END as after_data, creation_date, last_modified_user as activity_user_id, last_modified_user
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND activity_date < '2017-11-07 00:00:00') as surv
WHERE before_data IS NOT NULL AND after_data IS NOT NULL);

/* 13 - 2011 Listing Edited */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = '2011 Listing Edited'), (new_data::json->>'id')::bigint as listing_id, original_data, new_data, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT') 
AND activity_date < '2017-11-07 00:00:00'
AND original_data IS NOT NULL AND new_data IS NOT NULL AND (original_data::json->'certificationEdition'->>'name')::bigint = 2011;

/* 14 - Certification status edited */
INSERT INTO openchpl.questionable_activity_listing (questionable_activity_trigger_id, listing_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Status Edited'), listing_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as listing_id, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN original_data::json->'certificationStatus'->>'name' END as original, CASE WHEN (original_data::json->'certificationStatus'->>'name')::text != (new_data::json->'certificationStatus'->>'name')::text THEN new_data::json->'certificationStatus'->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'CERTIFIED_PRODUCT')
AND activity_date < '2017-11-07 00:00:00') as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 15 - Developer Name Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Name Edited'), developer_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as developer_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
AND activity_date < '2017-11-07 00:00:00') as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 16 - Developer Status Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status Edited'), 
	developer_status_new_activity.developer_id, 
	developer_status_old_activity.old_status, 
	developer_status_new_activity.new_status, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, developer_id, status_name as new_status
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')) diff) developer_status_new_activity
ON developer_status_new_activity.activity_id = activity.activity_id
JOIN
(SELECT activity_id, developer_id, status_name as old_status
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')) diff) developer_status_old_activity
ON developer_status_old_activity.activity_id = activity.activity_id
WHERE developer_status_new_activity IS NOT NULL AND developer_status_old_activity IS NOT NULL;

/* 17 - Developer Status History Edited */
INSERT INTO openchpl.questionable_activity_developer (questionable_activity_trigger_id, developer_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Developer Status History Edited'), 
	developer_status_new_activity.developer_id, 
	developer_status_old_activity.old_status, 
	developer_status_new_activity.new_status, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, developer_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as new_status
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')) diff) developer_status_new_activity
ON developer_status_new_activity.activity_id = activity.activity_id
JOIN
(SELECT activity_id, developer_id, status_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as old_status
FROM
	((SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, (value::json->>'id')::bigint as id, (value::json->'status'->>'id')::bigint as status_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00')) diff) developer_status_old_activity
ON developer_status_old_activity.activity_id = activity.activity_id
WHERE developer_status_new_activity IS NOT NULL AND developer_status_old_activity IS NOT NULL;

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
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'statusEvents') < json_array_length(new_data::json->'statusEvents'))

	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00'
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
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'statusEvents') > json_array_length(new_data::json->'statusEvents'))
	
	EXCEPT ALL

	(SELECT activity_id, (value::json->>'developerId')::bigint as developer_id, value::json->'status'->>'statusName' as status_name, value::json->>'statusDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'statusEvents')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'DEVELOPER')
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'statusEvents') > json_array_length(new_data::json->'statusEvents'))) diff) developer_status_removed_activity
ON developer_status_removed_activity.activity_id = activity.activity_id
WHERE developer_status_removed_activity IS NOT NULL;

/* 20 - Product name change */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Name Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN original_data::json->>'name' END as original, CASE WHEN (original_data::json->>'name')::text != (new_data::json->>'name')::text THEN new_data::json->>'name' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
AND activity_date < '2017-11-07 00:00:00') as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 21 - Product owner change */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner Edited'), product_id, original, new, creation_date, activity_user_id, last_modified_user, creation_date, creation_date FROM 
(SELECT (new_data::json->>'id')::bigint as product_id, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN original_data::json->>'developerName' END as original, CASE WHEN (original_data::json->>'developerId')::text != (new_data::json->>'developerId')::text THEN new_data::json->>'developerName' END as new, creation_date, last_modified_user as activity_user_id, last_modified_user 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
AND activity_date < '2017-11-07 00:00:00') as changed_name
WHERE original IS NOT NULL AND new IS NOT NULL);

/* 22 - Product owner history edited */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Edited'), 
	product_owner_added_activity.product_id, 
	product_owner_removed_activity.removed, 
	product_owner_added_activity.added, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(transfer_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (new_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, value::json->>'transferDate' as transfer_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (original_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, value::json->>'transferDate' as transfer_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00')) diff) product_owner_added_activity
ON product_owner_added_activity.activity_id = activity.activity_id
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(transfer_date::bigint/1000), 'YYYY-MM-DD') || ')' as removed
FROM
	((SELECT activity_id, (original_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, value::json->>'transferDate' as transfer_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00')

	EXCEPT ALL

	(SELECT activity_id, (new_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, value::json->>'transferDate' as transfer_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00')) diff) product_owner_removed_activity
ON product_owner_removed_activity.activity_id = activity.activity_id
WHERE product_owner_removed_activity IS NOT NULL AND product_owner_added_activity IS NOT NULL;

/* 23 - Product Owner History Added */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Added'), 
	product_owner_added_activity.product_id, 
	null, 
	product_owner_added_activity.added, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as added
FROM
	((SELECT activity_id, (new_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'ownerHistory') < json_array_length(new_data::json->'ownerHistory'))

	EXCEPT ALL

	(SELECT activity_id, (original_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'ownerHistory') < json_array_length(new_data::json->'ownerHistory'))) diff) product_owner_added_activity
ON product_owner_added_activity.activity_id = activity.activity_id
WHERE product_owner_added_activity IS NOT NULL;

/* 24 - Product Owner History Removed */
INSERT INTO openchpl.questionable_activity_product (questionable_activity_trigger_id, product_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date)
SELECT
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Product Owner History Removed'), 
	product_owner_removed_activity.product_id,
	product_owner_removed_activity.removed, 
	null, 
	activity.creation_date, 
	activity.last_modified_user, 
	activity.last_modified_user, 
	activity.creation_date, 
	activity.creation_date
FROM openchpl.activity
JOIN
(SELECT activity_id, product_id, developer_name || ' (' || to_char(to_timestamp(status_date::bigint/1000), 'YYYY-MM-DD') || ')' as removed
FROM
	((SELECT activity_id, (original_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.original_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'ownerHistory') > json_array_length(new_data::json->'ownerHistory'))

	EXCEPT ALL

	(SELECT activity_id, (new_data::json->>'id')::bigint as product_id, value::json->'developer'->>'name' as developer_name, new_data::json->>'lastModifiedDate' as status_date
	FROM openchpl.activity,
	json_array_elements(openchpl.activity.new_data::json->'ownerHistory')
	WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'PRODUCT')
	AND activity_date < '2017-11-07 00:00:00'
	AND json_array_length(original_data::json->'ownerHistory') > json_array_length(new_data::json->'ownerHistory'))) diff) product_owner_removed_activity
ON product_owner_removed_activity.activity_id = activity.activity_id
WHERE product_owner_removed_activity IS NOT NULL;;

/* 25 - Version name change */
INSERT INTO openchpl.questionable_activity_version (questionable_activity_trigger_id, version_id, before_data, after_data, activity_date, activity_user_id, last_modified_user, creation_date, last_modified_date) 
(SELECT (SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Version Name Edited'), (new_data::json->>'id')::bigint as version_id, original_data::json->>'version' as original_version, new_data::json->>'version' as new_version, creation_date, last_modified_user, last_modified_user, creation_date, creation_date 
FROM openchpl.activity 
WHERE activity_object_concept_id = (SELECT activity_concept_id FROM openchpl.activity_concept WHERE concept = 'VERSION')
AND activity_date < '2017-11-07 00:00:00' 
AND original_data IS NOT NULL AND new_data IS NOT NULL);