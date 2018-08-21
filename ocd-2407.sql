ALTER TABLE openchpl.vendor_status_history DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.vendor_status_history ADD COLUMN reason text;