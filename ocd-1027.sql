SELECT
    cp.certified_product_id,
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||q.testing_lab_code||'.'||c.certification_body_code||'.'||h.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
    edition.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_deleted,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    g.product_name,
    h.vendor_name,
    h.vendor_code,
    i.certification_date,
    certStatus.certification_status_id,
    certStatus.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code,
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
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) certStatus
		ON certStatus.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) n on certStatus.certification_status_id = n.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on cp.certification_edition_id = edition.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on cp.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_classification_type_id, name as "product_classification_name" FROM openchpl.product_classification_type) d on cp.product_classification_type_id = d.product_classification_type_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" from openchpl.practice_type) e on cp.practice_type_id = e.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on cp.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
    LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and cp.certification_body_id = p.certification_body_id
    LEFT JOIN (SELECT address_id, street_line_1, street_line_2, city, state, zipcode, country from openchpl.address) t on h.vendor_address = t.address_id
    LEFT JOIN (SELECT contact_id, first_name, last_name, email, phone_number, title from openchpl.contact) u on h.vendor_contact = u.contact_id
	LEFT JOIN (SELECT vendor_status_id, name as "vendor_status_name" from openchpl.vendor_status) v on h.vendor_status_id = v.vendor_status_id
	LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) i on cp.certified_product_id = i.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_certifications" FROM (SELECT * FROM openchpl.certification_result WHERE success = true AND deleted <> true) j GROUP BY certified_product_id) k ON cp.certified_product_id = k.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_cqms" FROM (SELECT DISTINCT ON (cqm_id, certified_product_id) * FROM openchpl.cqm_result_details WHERE success = true AND deleted <> true) l GROUP BY certified_product_id ORDER BY certified_product_id) m ON cp.certified_product_id = m.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" FROM (SELECT * FROM openchpl.surveillance WHERE deleted <> true) n GROUP BY certified_product_id) surv ON cp.certified_product_id = surv.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND (end_date IS NULL OR end_date >= NOW())) n GROUP BY certified_product_id) surv_open
    ON cp.certified_product_id = surv_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND end_date IS NOT NULL 
		 AND end_date <= NOW()) n GROUP BY certified_product_id) surv_closed
    ON cp.certified_product_id = surv_closed.certified_product_id
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
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" FROM
	    (SELECT * FROM openchpl.surveillance surv
			JOIN openchpl.surveillance_requirement surv_req
			ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
			JOIN openchpl.surveillance_nonconformity surv_nc
			ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
			JOIN openchpl.nonconformity_status nc_status
			ON surv_nc.nonconformity_status_id = nc_status.id
		 WHERE surv.deleted <> true 
		 AND nc_status.name = 'Closed') n GROUP BY certified_product_id) nc_closed
    ON cp.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) q on cp.testing_lab_id = q.testing_lab_id
    ;