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
	--certification status
	LEFT JOIN (
		SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id"
		FROM openchpl.certification_status_event cse
		INNER JOIN
			(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
			FROM openchpl.certification_status_event
			GROUP BY certified_product_id) maxCse
		ON cse.certified_product_id = maxCse.certified_product_id 
		--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
		AND extract(epoch from cse.event_date) = maxCse.event_date
	) lastCertStatusEvent
	ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
		
    LEFT JOIN openchpl.certification_status cs ON lastCertStatusEvent.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

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
    --certification status
	LEFT JOIN (
		SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id"
		FROM openchpl.certification_status_event cse
		INNER JOIN
			(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
			FROM openchpl.certification_status_event
			GROUP BY certified_product_id) maxCse
		ON cse.certified_product_id = maxCse.certified_product_id 
		--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
		AND extract(epoch from cse.event_date) = maxCse.event_date
	) lastCertStatusEvent
	ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
		
    LEFT JOIN openchpl.certification_status cs ON lastCertStatusEvent.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

-- the above views referenced this column; replace it first
ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS certification_status_id;

ALTER TABLE openchpl.certification_status_event DROP COLUMN IF EXISTS reason;
ALTER TABLE openchpl.certification_status_event ADD COLUMN reason varchar(500);

--re-run grants 
\i dev/openchpl_grant-all.sql