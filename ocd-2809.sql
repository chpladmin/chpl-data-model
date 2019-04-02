ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS error_count;
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS warning_count;

ALTER TABLE openchpl.pending_certified_product ADD COLUMN error_count int;
ALTER TABLE openchpl.pending_certified_product ADD COLUMN warning_count int;