ALTER TABLE openchpl.certification_status_event DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.certification_status_event ADD COLUMN reason varchar(500);