ALTER TABLE openchpl.certified_product_upload DROP COLUMN IF EXISTS status;
DROP TYPE IF EXISTS openchpl.certified_product_upload_status;
CREATE TYPE openchpl.certified_product_upload_status as enum ('Processing', 'Successful', 'Failed');
ALTER TABLE openchpl.certified_product_upload ADD COLUMN status openchpl.certified_product_upload_status;