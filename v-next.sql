UPDATE openchpl.invited_user_permission 
SET user_permission_id = 2
WHERE user_permission_id = 3;

UPDATE openchpl.invited_user_permission 
SET user_permission_id = 4
WHERE user_permission_id = 5;

DELETE FROM openchpl.invited_user_permission as up
WHERE up.user_permission_id = 5;

DELETE FROM openchpl.invited_user_permission as up
WHERE up.user_permission_id = 3;

DELETE FROM openchpl.user_permission as up
WHERE up.user_permission_id = 5;

DELETE FROM openchpl.user_permission as up
WHERE up.user_permission_id = 3;

UPDATE openchpl.user_permission as up
SET name = 'ACB'
WHERE up.user_permission_id = 2;

UPDATE openchpl.user_permission as up
SET authority = 'ROLE_ACB'
WHERE up.user_permission_id = 2;

UPDATE openchpl.user_permission as up
SET name = 'ATL'
WHERE up.user_permission_id = 4;

UPDATE openchpl.user_permission as up
SET authority = 'ROLE_ATL'
WHERE up.user_permission_id = 4;
	
--
-- FIX UCD PROCESSES
--

-- delete references to ucd processes in certification results if ucd process name is blank
UPDATE openchpl.certification_result_ucd_process 
SET deleted = true
WHERE ucd_process_id IN (SELECT ucd_process_id FROM openchpl.ucd_process WHERE name = '')
AND deleted != true;

-- delete the ucd_process rows that have blank names
UPDATE openchpl.ucd_process
SET deleted = true
WHERE name = ''
AND deleted != true;

CREATE OR REPLACE FUNCTION openchpl.replaceAllUcdProcessDuplicates() RETURNS void AS $$
DECLARE
    dupName varchar(200);
BEGIN
    FOR dupName IN SELECT name FROM openchpl.ucd_process WHERE deleted = false GROUP BY name HAVING count(*) > 1
    LOOP
	-- change the references to the duplicate ucd process
	RAISE NOTICE 'Changing all certification results pointing to ucd process %', dupName;

	UPDATE openchpl.certification_result_ucd_process
	SET ucd_process_id =
		-- get the first one of the ucd processes with this same name
		-- and set all certification results to point to it
		(SELECT ucd_process_id 
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, ucd_process_id FROM openchpl.ucd_process WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row = 1)
	WHERE ucd_process_id IN (SELECT ucd_process_id FROM openchpl.ucd_process WHERE name = dupName)
	AND deleted = false;

	-- delete the duplicate ucd process(es)
	UPDATE openchpl.ucd_process
	SET deleted = true
	WHERE ucd_process_id IN
		-- get all non-first instances of this ucd process name
	       (SELECT ucd_process_id 
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, ucd_process_id FROM openchpl.ucd_process WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row > 1)
	AND deleted = false;
	
    END LOOP;
    RETURN;
END
$$ LANGUAGE 'plpgsql' ;

SELECT * FROM openchpl.replaceAllUcdProcessDuplicates();
DROP FUNCTION openchpl.replaceAllUcdProcessDuplicates();

--
-- FIX QMS STANDARDS
--

CREATE OR REPLACE FUNCTION openchpl.replaceAllQmsStandardDuplicates() RETURNS void AS $$
DECLARE
    dupName varchar(200);
BEGIN
    FOR dupName IN SELECT name FROM openchpl.qms_standard WHERE deleted = false GROUP BY name HAVING count(*) > 1
    LOOP
	-- change the references to the duplicate ucd process
	RAISE NOTICE 'Changing all certified products pointing to qms standard %', dupName;

	UPDATE openchpl.certified_product_qms_standard
	SET qms_standard_id =
		-- get the first one of the qms standards with this same name
		-- and set all certification results to point to it
		(SELECT qms_standard_id 
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, qms_standard_id FROM openchpl.qms_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row = 1)
	WHERE qms_standard_id IN (SELECT qms_standard_id FROM openchpl.qms_standard WHERE name = dupName)
	AND deleted = false;

	-- delete the duplicate qms standard(s)
	UPDATE openchpl.qms_standard
	SET deleted = true
	WHERE qms_standard_id IN
		-- get all non-first instances of this qms standard name
	       (SELECT qms_standard_id 
		FROM
			(SELECT ROW_NUMBER() OVER() AS row, qms_standard_id FROM openchpl.qms_standard WHERE name = dupName AND deleted = false) as dup_rows
		WHERE dup_rows.row > 1)
	AND deleted = false;
	
    END LOOP;
    RETURN;
END
$$ LANGUAGE 'plpgsql' ;

SELECT * FROM openchpl.replaceAllQmsStandardDuplicates();
DROP FUNCTION openchpl.replaceAllQmsStandardDuplicates();

--re-run grants
\i dev/openchpl_grant-all.sql