--
--NOTE: MAKE SURE TO CHANGE ENTITY REFERENCES TO _TEMP TABLES IN THE API
--

-- Manually delete tables that were needed for the previous v-next data migration. They could not be deleted before
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
--re-run grants
\i dev/openchpl_grant-all.sql