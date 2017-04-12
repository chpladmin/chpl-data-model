ALTER TABLE openchpl.product DROP CONSTRAINT IF EXISTS contact_fk;
ALTER TABLE openchpl.product DROP COLUMN IF EXISTS contact_id;

ALTER TABLE openchpl.product ADD COLUMN contact_id bigint;
ALTER TABLE openchpl.product ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

