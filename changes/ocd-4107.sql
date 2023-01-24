-- Delete all data. Choosing DELETE over TRUNCATE so we don't start over with the ID sequence
DELETE FROM openchpl.inheritance_errors_report;

-- remove audit columns and trigger for last_modified_date
DROP TRIGGER IF EXISTS inheritance_errors_report_timestamp ON openchpl.inheritance_errors_report;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS last_modified_date;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS last_modified_user;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS deleted;

-- dropping "derived" columns
ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS url;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS chpl_product_number;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS developer;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS product;

ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS version;

-- add new certified_product_id column
ALTER TABLE openchpl.inheritance_errors_report
DROP COLUMN IF EXISTS certified_product_id;

ALTER TABLE openchpl.inheritance_errors_report
ADD COLUMN certified_product_id bigint NOT NULL; 

ALTER TABLE openchpl.inheritance_errors_report 
ADD CONSTRAINT certified_product_fk 
	FOREIGN KEY (certified_product_id) 
	REFERENCES openchpl.certified_product (certified_product_id) 
	MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;
