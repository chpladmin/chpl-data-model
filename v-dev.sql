ALTER TABLE openchpl.pending_certified_product 
DROP COLUMN IF EXISTS has_qms
ADD COLUMN has_qms boolean;