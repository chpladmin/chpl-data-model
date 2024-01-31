DROP VIEW IF EXISTS openchpl.product_certification_statuses;
DROP VIEW IF EXISTS openchpl.developer_certification_statuses;
DROP VIEW IF EXISTS openchpl.certified_product_search_result;

CREATE INDEX IF NOT EXISTS cse_certified_product_id_idx ON openchpl.certification_status_event (certified_product_id);
