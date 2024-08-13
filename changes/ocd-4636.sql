ALTER TABLE openchpl.test_task
ADD COLUMN IF NOT EXISTS friendly_id text;

ALTER TABLE openchpl.test_participant
ADD COLUMN IF NOT EXISTS friendly_id text;
