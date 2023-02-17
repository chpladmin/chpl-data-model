CREATE INDEX IF NOT EXISTS test_task_id_idx ON openchpl.test_task_participant_map (test_task_id);
CREATE INDEX IF NOT EXISTS test_task_participant_id_idx ON openchpl.test_task_participant_map (test_participant_id);
CREATE INDEX IF NOT EXISTS test_task_participant_id_and_deleted_idx ON openchpl.test_task_participant_map (test_participant_id, deleted);

DROP TRIGGER IF EXISTS test_task_participant_map_soft_delete on openchpl.test_task_participant_map;