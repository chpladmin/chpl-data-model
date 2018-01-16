ALTER TABLE openchpl.pending_certified_product
DROP COLUMN IF EXISTS has_qms;

ALTER TABLE openchpl.pending_certified_product
ADD COLUMN has_qms boolean;