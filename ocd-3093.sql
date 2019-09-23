CREATE OR REPLACE VIEW openchpl.developer_certification_body_map
AS SELECT DISTINCT cp.certification_body_id, dev.vendor_id
   FROM openchpl.certified_product cp
     JOIN openchpl.product_version prod_ver ON cp.product_version_id = prod_ver.product_version_id
     JOIN openchpl.product prod ON prod_ver.product_id = prod.product_id
     JOIN openchpl.vendor dev ON prod.vendor_id = dev.vendor_id;
