SELECT certification_status from openchpl.certification_status;

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Suspended by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Suspended by ONC'
        );

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Terminated by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Terminated by ONC'
        );

SELECT certification_status from openchpl.certification_status;

CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS
SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.vendor v
    LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

    GRANT ALL ON TABLE openchpl.developer_certification_statuses TO openchpl;

CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS
SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.product p
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

    GRANT ALL ON TABLE openchpl.product_certification_statuses TO openchpl;
