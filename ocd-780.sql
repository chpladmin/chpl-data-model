CREATE OR REPLACE FUNCTION test_procedure_update() RETURNS VOID AS
$$
DECLARE
	reused_tp_id openchpl.test_procedure.test_procedure_id%TYPE;
	curr_tp openchpl.test_procedure%ROWTYPE;
	certresult_tp openchpl.certification_result_test_procedure%ROWTYPE;
	next_tp_id BIGINT;
BEGIN
	--find the test procedures that have been referenced by multiple certification_results
	FOR reused_tp_id IN SELECT test_procedure_id FROM openchpl.certification_result_test_procedure group by test_procedure_id having count(test_procedure_id) > 1 
	
	LOOP
		-- look up the test procedure referenced because we'll have to clone it
		select * INTO STRICT curr_tp from openchpl.test_procedure where test_procedure_id = reused_tp_id;
		IF NOT FOUND THEN
			RAISE EXCEPTION 'test procedure with id % not found', reused_tp_id;
		END IF;
		
		-- find all of the certification results that use the current test procedure
		FOR certresult_tp IN SELECT certification_result_test_procedure_id from openchpl.certification_result_test_procedure WHERE test_procedure_id=reused_tp_id
		
		LOOP
			select nextval('openchpl.test_procedure_test_procedure_id_seq') as NEXT_TP INTO STRICT next_tp_id;
			
			-- clone the test_procedure TP
			insert into openchpl.test_procedure (test_procedure_id, version, creation_date, last_modified_date, last_modified_user, deleted)
			values (next_tp_id, curr_tp.version, curr_tp.creation_date, 
					curr_tp.last_modified_date, curr_tp.last_modified_user, curr_tp.deleted);
			
			--assign the ID from the cloned test_procedure to the certification_result
			update openchpl.certification_result_test_procedure 
			set test_procedure_id = next_tp_id
			where certification_result_test_procedure_id = certresult_tp.certification_result_test_procedure_id;		
		
		END LOOP;
	END LOOP;
END;
$$
LANGUAGE plpgsql;

SELECT test_procedure_update();
-- test with product 7706 on DEV and 7733 on STG