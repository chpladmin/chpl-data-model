-- Clear all receiving tables. Note: cascade on surveillance also impacts surveillance_requirement, surveillance_nonconformity, and surveillance_nonconformity_document
TRUNCATE openchpl.surveillance CASCADE;

-- Build temp staging tables for each destination table
DROP TABLE IF EXISTS surveillance;
CREATE TEMP TABLE surveillance AS
	SELECT C.corrective_action_plan_id AS id, C.certified_product_id, C.surveillance_start AS start_date, C.surveillance_end AS end_date, 
	CASE WHEN CR.num_sites_total IS NOT NULL THEN 2 ELSE 1 END AS type_id, CR.num_sites_total AS randomized_sites_used,
	C.creation_date, C.last_modified_date, C.last_modified_user, C.deleted
	FROM openchpl.corrective_action_plan C
	LEFT JOIN (SELECT DISTINCT corrective_action_plan_id, MAX(num_sites_total) AS num_sites_total FROM openchpl.corrective_action_plan_certification_result GROUP BY corrective_action_plan_id) CR 
	ON C.corrective_action_plan_id = CR.corrective_action_plan_id;

DROP TABLE IF EXISTS surveillance_requirement;
CREATE TEMP TABLE surveillance_requirement AS
	SELECT ROW_NUMBER() OVER() AS surveillance_requirement_id, s.id AS surveillance_id, s.type_id, CR.certification_criterion_id, 
	CASE WHEN CR.certification_criterion_id IS NULL THEN '170.523(k)(2)' ELSE NULL END AS requirement,
	CASE WHEN s.end_date IS NULL THEN 1 ELSE 2 END AS result_id, CASE WHEN CR.creation_date IS NOT NULL THEN CR.creation_date ELSE now() END AS creation_date, 
	CASE WHEN CR.last_modified_date IS NOT NULL THEN CR.last_modified_date ELSE now() END AS last_modified_date, 
	CASE WHEN CR.last_modified_user IS NOT NULL THEN CR.last_modified_user ELSE -2 END AS last_modified_user, 
	CASE WHEN CR.deleted IS NOT NULL THEN CR.deleted ELSE false END AS deleted
	FROM surveillance s
	LEFT JOIN (SELECT corrective_action_plan_id, certification_criterion_id, creation_date, last_modified_date, last_modified_user, deleted
	FROM openchpl.corrective_action_plan_certification_result) CR ON CR.corrective_action_plan_id = s.id;

DROP TABLE IF EXISTS surveillance_nonconformity;
CREATE TEMP TABLE surveillance_nonconformity AS
	SELECT ROW_NUMBER() OVER() AS surveillance_nonconformity_id, r.surveillance_requirement_id, r.certification_criterion_id, 
	CASE WHEN r.type_id = 1 THEN CC.number
	WHEN r.type_id = 2 THEN '170.523 (k)(2)'
	END AS nonconformity_type, 
	CASE WHEN c.surveillance_end IS NULL THEN 1 ELSE 2 END AS nonconformity_status_id, c.noncompliance_determination_date AS date_of_determination, 
	c.approval_date AS corrective_action_plan_approval_date, c.surveillance_start AS corrective_action_start_date, 
	c.completion_date_required AS corrective_action_must_complete_date, c.completion_date_actual AS corrective_action_end_date, 
	c.summary, 'N/A' AS findings, CR.num_sites_passed AS sites_passed, CR.num_sites_total AS total_sites, c.developer_explanation, 
	c.resolution, c.creation_date, c.last_modified_date, c.last_modified_user, c.deleted, c.corrective_action_plan_id
	FROM openchpl.corrective_action_plan c
	LEFT JOIN surveillance_requirement r ON c.corrective_action_plan_id = r.surveillance_id
	LEFT JOIN (SELECT num_sites_passed, num_sites_total, corrective_action_plan_id FROM openchpl.corrective_action_plan_certification_result) CR 
	ON c.corrective_action_plan_id= CR.corrective_action_plan_id
	LEFT JOIN openchpl.certification_criterion CC ON r.certification_criterion_id = CC.certification_criterion_id;

DROP TABLE IF EXISTS surveillance_nonconformity_document;
CREATE TEMP TABLE surveillance_nonconformity_document AS
	SELECT ROW_NUMBER() OVER() AS id, SN.surveillance_nonconformity_id, D.filename, D.filetype, D.filedata, 
	D.creation_date, D.last_modified_date, D.last_modified_user, D.deleted
	FROM openchpl.corrective_action_plan_documentation D
	LEFT JOIN surveillance_nonconformity SN ON D.corrective_action_plan_id = SN.corrective_action_plan_id;

-- Insert from each temp staging table into the destination table
INSERT INTO openchpl.surveillance 
	(id, certified_product_id, start_date, end_date, type_id, randomized_sites_used, 
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT id, certified_product_id, start_date, end_date, type_id, randomized_sites_used, 
	creation_date, last_modified_date, last_modified_user, deleted
	FROM surveillance;

INSERT INTO openchpl.surveillance_requirement
	(id, surveillance_id, type_id, certification_criterion_id, requirement, 
	result_id, creation_date, last_modified_date, last_modified_user, 
	deleted)
	SELECT 
	surveillance_requirement_id, surveillance_id, type_id, certification_criterion_id, 
	requirement, result_id, creation_date, last_modified_date, last_modified_user, 
	deleted
	FROM surveillance_requirement;

INSERT INTO openchpl.surveillance_nonconformity 
	(id, surveillance_requirement_id, certification_criterion_id, 
	nonconformity_type, nonconformity_status_id, date_of_determination, 
	corrective_action_plan_approval_date, corrective_action_start_date, 
	corrective_action_must_complete_date, corrective_action_end_date, 
	summary, findings, sites_passed, total_sites, developer_explanation, 
	resolution, creation_date, last_modified_date, last_modified_user, 
	deleted)
	SELECT
	surveillance_nonconformity_id, surveillance_requirement_id, certification_criterion_id, 
	nonconformity_type, nonconformity_status_id, date_of_determination, 
	corrective_action_plan_approval_date, corrective_action_start_date, 
	corrective_action_must_complete_date, corrective_action_end_date, 
	summary, findings, sites_passed, total_sites, developer_explanation, 
	resolution, creation_date, last_modified_date, last_modified_user,
	deleted
	FROM surveillance_nonconformity;

INSERT INTO openchpl.surveillance_nonconformity_document 
	(id, surveillance_nonconformity_id, filename, filetype, filedata, 
	creation_date, last_modified_date, last_modified_user, deleted)
	SELECT
	id, surveillance_nonconformity_id, filename, filetype, filedata, 
	creation_date, last_modified_date, last_modified_user, deleted
	FROM surveillance_nonconformity_document;

-- Update sequence numbers
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance', 'id'), (SELECT MAX(id) FROM openchpl.surveillance)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_requirement', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_requirement)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_nonconformity', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_nonconformity)+1);
SELECT pg_catalog.setval(pg_get_serial_sequence('openchpl.surveillance_nonconformity_document', 'id'), (SELECT MAX(id) FROM openchpl.surveillance_nonconformity_document)+1);

-- Add function to allow printing text to screen
CREATE OR REPLACE FUNCTION print_notice(msg text) 
  RETURNS INTEGER AS 
$$ 
DECLARE 
BEGIN 
    RAISE NOTICE USING MESSAGE = msg;
    RETURN null;
END; 
$$ 
LANGUAGE 'plpgsql' IMMUTABLE; 

-- Output certified Product ID for any CAP that is defined as "general " so Jennifer can look at them
-- Note: "general" would be whenever a CAP does not have an associated certification_criterion; 
-- in other words, "general" is whenever there is no corrective_action_plan_id in the corrective_action_plan_certification_result table.
SELECT print_notice('Please send the following "general" Certified Product IDs to Jennifer for review:');

DROP FUNCTION IF EXISTS print_notice(text);

SELECT C.certified_product_id
FROM openchpl.corrective_action_plan C
LEFT JOIN openchpl.corrective_action_plan_certification_result CR ON C.corrective_action_plan_id = CR.corrective_action_plan_id
WHERE C.corrective_action_plan_id IS NOT NULL AND CR.corrective_action_plan_id IS NULL;

