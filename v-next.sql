DROP TABLE IF EXISTS openchpl.test_task_participant_map;

CREATE TABLE openchpl.test_task_participant_map (
	id bigserial NOT NULL,
	test_task_id bigint NOT NULL,
	test_participant_id bigint NOT NULL,
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool DEFAULT false,
	CONSTRAINT test_task_participant_map_pk PRIMARY KEY (id),
	CONSTRAINT test_task_fk FOREIGN KEY (test_task_id) 
		REFERENCES openchpl.test_task (test_task_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT test_participant_fk FOREIGN KEY (test_participant_id) 
		REFERENCES openchpl.test_participant (test_participant_id) 
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TRIGGER test_task_participant_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_task_participant_map_timestamp BEFORE UPDATE on openchpl.test_task_participant_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--fill in test task ids from certification_result_test_task_participant table
INSERT INTO openchpl.test_task_participant_map (id, test_task_id, test_participant_id, last_modified_date, creation_date, last_modified_user, deleted)
	SELECT nextval('openchpl.test_task_participant_map_id_seq'), test_task.test_task_id, certification_result_test_task_participant.test_participant_id, 
	certification_result_test_task_participant.last_modified_date, certification_result_test_task_participant.creation_date,
	certification_result_test_task_participant.last_modified_user, certification_result_test_task_participant.deleted
	FROM openchpl.certification_result_test_task_participant
	INNER JOIN openchpl.certification_result_test_task ON certification_result_test_task.certification_result_test_task_id = certification_result_test_task_participant.certification_result_test_task_id
	INNER JOIN openchpl.test_task ON test_task.test_task_id = certification_result_test_task.test_task_id
	INNER JOIN openchpl.test_participant ON test_participant.test_participant_id = certification_result_test_task_participant.test_participant_id;

-- drop constraints on that table for now so that other data isn't affected
ALTER TABLE openchpl.certification_result_test_task_participant DROP CONSTRAINT IF EXISTS certification_result_test_task_fk;
ALTER TABLE openchpl.certification_result_test_task_participant DROP CONSTRAINT IF EXISTS test_participant_fk;

--re-run grants
\i dev/openchpl_grant-all.sql

--TODO: 
--COPY BELOW INTO v-next.sql for the NEXT release to drop the table and associated triggers
--DROP TABLE IF EXISTS openchpl.certification_result_test_task_participant;
