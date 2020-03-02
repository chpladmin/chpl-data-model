ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS self_developer;
ALTER TABLE openchpl.pending_certified_product ADD COLUMN self_developer bool;
