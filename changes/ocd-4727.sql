ALTER TABLE openchpl.activity
ADD COLUMN IF NOT EXISTS activity_object_uuid uuid DEFAULT NULL;

ALTER TABLE openchpl.activity
ALTER COLUMN activity_object_id DROP NOT NULL;
