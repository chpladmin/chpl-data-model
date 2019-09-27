CREATE OR REPLACE VIEW openchpl.developer_certification_body_map
AS SELECT DISTINCT cp.certification_body_id, dev.vendor_id
   FROM openchpl.certified_product cp
     JOIN openchpl.product_version prod_ver ON cp.product_version_id = prod_ver.product_version_id
     JOIN openchpl.product prod ON prod_ver.product_id = prod.product_id
     JOIN openchpl.vendor dev ON prod.vendor_id = dev.vendor_id;

--Need to clear out existing data 
DELETE FROM openchpl.change_request_status;
DELETE FROM openchpl.change_request_website;
DELETE FROM openchpl.change_request;

ALTER TABLE openchpl.change_request_status
ADD COLUMN user_permission_id BIGINT NOT NULL;

ALTER TABLE openchpl.change_request_status
DROP CONSTRAINT IF EXISTS user_permission_fk;

ALTER TABLE openchpl.change_request_status
ADD CONSTRAINT user_permission_fk FOREIGN KEY (user_permission_id)
	    REFERENCES openchpl.user_permission (user_permission_id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT;