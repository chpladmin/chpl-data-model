-- View: openchpl.acb_developer_transparency_mappings

-- DROP VIEW openchpl.acb_developer_transparency_mappings;

CREATE OR REPLACE VIEW openchpl.acb_developer_transparency_mappings AS
 SELECT row_number() OVER () AS id,
    certification_body.certification_body_id,
    certification_body."name" AS acb_name,
    acb_vendor_map.transparency_attestation,
    vendor."name" AS developer_name,
    vendor.vendor_id
   FROM openchpl.vendor
     LEFT JOIN openchpl.acb_vendor_map ON acb_vendor_map.vendor_id = vendor.vendor_id
     LEFT JOIN openchpl.certification_body ON acb_vendor_map.certification_body_id = certification_body.certification_body_id
  WHERE (certification_body.deleted = false OR certification_body.deleted IS NULL) AND vendor.deleted = false;

--ALTER TABLE openchpl.acb_developer_transparency_mappings OWNER TO openchpl;

GRANT ALL ON TABLE openchpl.acb_developer_transparency_mappings TO openchpl;
