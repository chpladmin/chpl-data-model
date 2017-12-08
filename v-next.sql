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

-- Rename tables and constraints that had "_temp" in the name anything from here that has '_temp' in the name.
BEGIN;

DROP TRIGGER IF EXISTS test_procedure_temp_audit ON openchpl.test_procedure_temp;
DROP TRIGGER IF EXISTS test_procedure_temp_timestamp ON openchpl.test_procedure_temp;
DROP TRIGGER IF EXISTS test_procedure_criteria_map_temp_audit ON openchpl.test_procedure_criteria_map_temp;
DROP TRIGGER IF EXISTS test_procedure_criteria_map_temp_timestamp ON openchpl.test_procedure_criteria_map_temp;
DROP TRIGGER IF EXISTS certification_result_test_procedure_temp_audit ON openchpl.certification_result_test_procedure_temp;
DROP TRIGGER IF EXISTS certification_result_test_procedure_temp_timestamp ON openchpl.certification_result_test_procedure_temp;
DROP TRIGGER IF EXISTS pending_certification_result_test_procedure_temp_audit ON openchpl.pending_certification_result_test_procedure_temp;
DROP TRIGGER IF EXISTS pending_certification_result_test_procedure_temp_timestamp ON openchpl.pending_certification_result_test_procedure_temp;

ALTER INDEX IF EXISTS openchpl.test_procedure_temp_pk RENAME TO test_procedure_pk;
ALTER TABLE IF EXISTS openchpl.test_procedure_temp RENAME TO test_procedure;

ALTER INDEX IF EXISTS openchpl.test_procedure_criteria_map_temp_pk RENAME TO test_procedure_criteria_map_pk;
ALTER TABLE IF EXISTS openchpl.test_procedure_criteria_map_temp DROP CONSTRAINT IF EXISTS test_procedure_temp_fk;
ALTER TABLE IF EXISTS openchpl.test_procedure_criteria_map_temp DROP CONSTRAINT IF EXISTS test_procedure_fk;
ALTER TABLE IF EXISTS openchpl.test_procedure_criteria_map_temp ADD CONSTRAINT 
	test_procedure_fk FOREIGN KEY (test_procedure_id) 
	REFERENCES openchpl.test_procedure (id) 
	MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE IF EXISTS openchpl.test_procedure_criteria_map_temp RENAME TO test_procedure_criteria_map;


ALTER INDEX IF EXISTS openchpl.certification_result_test_procedure_temp_pk RENAME TO certification_result_test_procedure_pk;
ALTER TABLE IF EXISTS openchpl.certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS test_procedure_temp_fk;
ALTER TABLE IF EXISTS openchpl.certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS test_procedure_fk;
ALTER TABLE IF EXISTS openchpl.certification_result_test_procedure_temp ADD CONSTRAINT 
	test_procedure_fk FOREIGN KEY (test_procedure_id) 
	REFERENCES openchpl.test_procedure (id) 
	MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE IF EXISTS openchpl.certification_result_test_procedure_temp RENAME TO certification_result_test_procedure;

ALTER INDEX IF EXISTS openchpl.pending_certification_result_test_procedure_temp_pk RENAME TO pending_certification_result_test_procedure_pk;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS pending_certification_result_temp_fk;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS pending_certification_result_fk;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp ADD CONSTRAINT
	pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
    REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH FULL
    ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS test_procedure_temp_fk;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp DROP CONSTRAINT IF EXISTS test_procedure_fk;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp ADD CONSTRAINT
	test_procedure_fk FOREIGN KEY (test_procedure_id)
	REFERENCES openchpl.test_procedure (id) MATCH FULL
	ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE IF EXISTS openchpl.pending_certification_result_test_procedure_temp RENAME TO pending_certification_result_test_procedure;

DROP TRIGGER IF EXISTS test_procedure_audit ON openchpl.test_procedure;
DROP TRIGGER IF EXISTS test_procedure_timestamp ON openchpl.test_procedure;
DROP TRIGGER IF EXISTS test_procedure_criteria_map_audit ON openchpl.test_procedure_criteria_map;
DROP TRIGGER IF EXISTS test_procedure_criteria_map_timestamp ON openchpl.test_procedure_criteria_map;
DROP TRIGGER IF EXISTS certification_result_test_procedure_audit ON openchpl.certification_result_test_procedure;
DROP TRIGGER IF EXISTS certification_result_test_procedure_timestamp ON openchpl.certification_result_test_procedure;
DROP TRIGGER IF EXISTS pending_certification_result_test_procedure_audit ON openchpl.pending_certification_result_test_procedure;
DROP TRIGGER IF EXISTS pending_certification_result_test_procedure_timestamp ON openchpl.pending_certification_result_test_procedure;

CREATE TRIGGER test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_timestamp BEFORE UPDATE on openchpl.test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();	
CREATE TRIGGER test_procedure_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_procedure_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_procedure_criteria_map_timestamp BEFORE UPDATE on openchpl.test_procedure_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER certification_result_test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_test_procedure_timestamp BEFORE UPDATE on openchpl.certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER pending_certification_result_test_procedure_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_test_procedure_timestamp BEFORE UPDATE on openchpl.pending_certification_result_test_procedure FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

COMMIT;

--
-- Fix up test procedure and test data tables with "_temp" in the names
--

-- Manually delete tables that were needed for the previous test procedure data migration. They could not be deleted before
-- so that we could run the migration of data from these tables multiple times.	
CREATE OR REPLACE FUNCTION openchpl.cleanupPendingTestProcedureTemp() RETURNS void AS $$
BEGIN
	--if pending_certification_result_test_procedure_temp still exists then drop pending_certification_result_test_procedure
    PERFORM * FROM openchpl.pending_certification_result_test_procedure_temp;
	DROP TABLE IF EXISTS openchpl.pending_certification_result_test_procedure;
    EXCEPTION
        WHEN UNDEFINED_TABLE THEN
		RAISE NOTICE 'pending_certification_result_test_procedure_temp has already been removed. Not removing pending_certification_result_test_procedure';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION openchpl.cleanupCertTestProcedureTemp() RETURNS void AS $$
BEGIN			
	--if certification_result_test_procedure_temp still exists then drop certification_result_test_procedure
	PERFORM * FROM openchpl.certification_result_test_procedure_temp;
	DROP TABLE IF EXISTS openchpl.certification_result_test_procedure;
    EXCEPTION
        WHEN UNDEFINED_TABLE THEN
		RAISE NOTICE 'certification_result_test_procedure_temp has already been removed. Not removing certification_result_test_procedure';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION openchpl.cleanupTestProcedureTemp() RETURNS void AS $$
BEGIN				
	--if test_procedure_temp still exists then drop test_procedure
	PERFORM * FROM openchpl.test_procedure_temp;
	DROP TABLE IF EXISTS openchpl.test_procedure;
    EXCEPTION
        WHEN UNDEFINED_TABLE THEN
		RAISE NOTICE 'test_procedure_temp has already been removed. Not removing test_procedure';
END;
$$ LANGUAGE plpgsql;

SELECT openchpl.cleanupPendingTestProcedureTemp();
SELECT openchpl.cleanupCertTestProcedureTemp();
SELECT openchpl.cleanupTestProcedureTemp();
DROP FUNCTION IF EXISTS openchpl.cleanupPendingTestProcedureTemp();
DROP FUNCTION IF EXISTS openchpl.cleanupCertTestProcedureTemp();
DROP FUNCTION IF EXISTS openchpl.cleanupTestProcedureTemp();

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
