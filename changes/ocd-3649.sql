ALTER TABLE openchpl.pending_certified_product
DROP COLUMN IF EXISTS processing;

ALTER TABLE openchpl.pending_certified_product
ADD COLUMN processing boolean NOT NULL default false;
