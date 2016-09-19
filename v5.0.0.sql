CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS 
 SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn'::text) AS withdrawn,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated'::text) AS terminated,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended'::text) AS suspended
   FROM openchpl.vendor v
     LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
     LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
     LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
     LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
  GROUP BY v.vendor_id;

--ALTER TABLE openchpl.developer_certification_statuses
--  OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.developer_certification_statuses TO openchpl;

CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS 
 SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn'::text) AS withdrawn,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated'::text) AS terminated,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended'::text) AS suspended
   FROM openchpl.product p
     LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
     LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
     LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
  GROUP BY p.product_id;

--ALTER TABLE openchpl.product_certification_statuses
--  OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.product_certification_statuses TO openchpl;
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
