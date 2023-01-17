ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS certified_product_id;

ALTER TABLE openchpl.inheritance_errors_report
ADD COLUMN certified_product_id bigint;

-- fill in the data based on the existing 'url' field
UPDATE openchpl.inheritance_errors_report
SET certified_product_id = split_part(url, '/', 6)::bigint;

ALTER TABLE openchpl.inheritance_errors_report
ALTER COLUMN certified_product_id SET NOT NULL;

ALTER TABLE openchpl.inheritance_errors_report 
ADD CONSTRAINT certified_product_fk 
	FOREIGN KEY (certified_product_id) 
	REFERENCES openchpl.certified_product (certified_product_id) 
	MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;

-- TODO in a future PR
--ALTER TABLE openchpl.inheritance_errors_report
--DROP COLUMN IF EXISTS url;
