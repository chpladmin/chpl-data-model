CREATE OR REPLACE VIEW openchpl.certified_product_search AS

SELECT
    cp.certified_product_id,
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
    edition.certification_edition_id,
    edition.year,
    atl.testing_lab_name,
    acb.certification_body_name,
    prac.practice_type_name,
    version.product_version,
    product.product_name,
    vendor.vendor_name,
    certStatusEvent.certification_date,
    certStatus.certification_status_name,
    CASE WHEN surv.count_surveillance_activities=0 THEN false WHEN surv.count_surveillance_activities IS NULL THEN false ELSE true END as "has_had_surveillance",
    CASE WHEN surv_open.count_open_surveillance_activities = 0 THEN false WHEN surv_open.count_open_surveillance_activities IS NULL THEN false ELSE true END as "has_open_surveillance",
    CASE WHEN nc_open.count_open_nonconformities = 0 THEN false WHEN nc_open.count_open_nonconformities IS NULL THEN false ELSE true END as "has_open_nonconformities"
FROM openchpl.certified_product cp
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
			cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) certStatusEvents
		ON certStatusEvents.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) certStatus on certStatusEvents.certification_status_id = certStatus.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
    LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" FROM (SELECT * FROM openchpl.surveillance WHERE deleted <> true) n GROUP BY certified_product_id) surv ON cp.certified_product_id = surv.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND (end_date IS NULL OR end_date >= NOW())) n GROUP BY certified_product_id) surv_open
    ON cp.certified_product_id = surv_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Open') n GROUP BY certified_product_id) nc_open
    ON cp.certified_product_id = nc_open.certified_product_id
    ;

ANALYZE;