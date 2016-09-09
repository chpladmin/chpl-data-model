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

ALTER TABLE openchpl.developer_certification_statuses
  OWNER TO openchpl;
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

ALTER TABLE openchpl.product_certification_statuses
  OWNER TO openchpl;
GRANT ALL ON TABLE openchpl.product_certification_statuses TO openchpl;