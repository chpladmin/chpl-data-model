---------------------------------------
-- OCD-2825
---------------------------------------
update openchpl.certification_status set deleted = true where certification_status = 'Pending';

-- remove certification status reference from pending listing table
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS certification_status_id;