DROP VIEW IF EXISTS openchpl.certified_product_search;
CREATE OR REPLACE VIEW openchpl.certified_product_search AS
SELECT
    cp.certified_product_id,
    string_agg(DISTINCT substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code||'☹'||child.certified_product_id::text, '☺') as "child",
    string_agg(DISTINCT substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code||'☹'||parent.certified_product_id::text, '☺') as "parent",
    string_agg(DISTINCT certs.cert_number::text, '☺') as "certs",
    string_agg(DISTINCT cqms.cqm_number::text, '☺') as "cqms",
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
	cp.meaningful_use_users,
	cp.transparency_attestation_url,
    edition.year,
    atl.testing_lab_name,
    acb.certification_body_name,
    cp.acb_certification_id,
    prac.practice_type_name,
    version.product_version,
    product.product_name,
    vendor.vendor_name,
    string_agg(DISTINCT history_vendor_name::text, '☺') as "owner_history",
    certStatusEvent.certification_date,
    certStatus.certification_status_name,
	decert.decertification_date,
	string_agg(DISTINCT certs_with_api_documentation.cert_number::text||'☹'||certs_with_api_documentation.api_documentation, '☺') as "api_documentation",
    COALESCE(survs.count_surveillance_activities, 0) as "surveillance_count",
    COALESCE(nc_open.count_open_nonconformities, 0) as "open_nonconformity_count",
    COALESCE(nc_closed.count_closed_nonconformities, 0) as "closed_nonconformity_count"
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
    LEFT JOIN (SELECT certified_product_id, chpl_product_number, child_listing_id, parent_listing_id FROM (SELECT certified_product_id, child_listing_id, parent_listing_id, chpl_product_number FROM openchpl.listing_to_listing_map INNER JOIN openchpl.certified_product on listing_to_listing_map.child_listing_id = certified_product.certified_product_id) children) child ON cp.certified_product_id = child.parent_listing_id
    LEFT JOIN (SELECT certified_product_id, chpl_product_number, child_listing_id, parent_listing_id FROM (SELECT certified_product_id, child_listing_id, parent_listing_id, chpl_product_number FROM openchpl.listing_to_listing_map INNER JOIN openchpl.certified_product on listing_to_listing_map.parent_listing_id = certified_product.certified_product_id) parents) parent ON cp.certified_product_id = parent.child_listing_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
    LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" FROM openchpl.vendor 
			JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
			WHERE product_owner_history_map.deleted = false) owners
    ON owners.history_product_id = product.product_id
    LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" 
		FROM openchpl.surveillance 
		WHERE openchpl.surveillance.deleted <> true  
		GROUP BY certified_product_id) survs
    ON cp.certified_product_id = survs.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Open'  
		GROUP BY certified_product_id) nc_open
    ON cp.certified_product_id = nc_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_nonconformities" 
		FROM openchpl.surveillance surv
		JOIN openchpl.surveillance_requirement surv_req ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
		JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
		JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
		WHERE surv.deleted <> true 
		AND nc_status.name = 'Closed'  
		GROUP BY certified_product_id) nc_closed
    ON cp.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT number as "cert_number", certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true AND certification_result.deleted = false AND certification_criterion.deleted = false) certs
	ON certs.certified_product_id = cp.certified_product_id
	LEFT JOIN (SELECT number as "cert_number", api_documentation, certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true 
		AND certification_result.api_documentation IS NOT NULL 
		AND certification_result.deleted = false 
		AND certification_criterion.deleted = false) certs_with_api_documentation
	ON certs_with_api_documentation.certified_product_id = cp.certified_product_id 
    LEFT JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id FROM openchpl.cqm_criterion 
		JOIN openchpl.cqm_result 
		ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
		WHERE cqm_result.success = true AND cqm_result.deleted = false AND cqm_criterion.deleted = false) cqms
	ON cqms.certified_product_id = cp.certified_product_id
	
WHERE cp.deleted != true
GROUP BY cp.certified_product_id, cp.acb_certification_id, edition.year, atl.testing_lab_code, acb.certification_body_code, vendor.vendor_code, cp.product_code, cp.version_code,cp.ics_code, cp.additional_software_code, cp.certified_date_code, cp.transparency_attestation_url,
atl.testing_lab_name, acb.certification_body_name,prac.practice_type_name,version.product_version,product.product_name,vendor.vendor_name,certStatusEvent.certification_date,certStatus.certification_status_name, decert.decertification_date,
survs.count_surveillance_activities, nc_open.count_open_nonconformities, nc_closed.count_closed_nonconformities
;

-- OCD-1765
DROP TABLE IF EXISTS openchpl.acb_contact_map;
DROP TABLE IF EXISTS openchpl.atl_contact_map;
DROP TABLE IF EXISTS openchpl.test_task_result;
DROP TABLE IF EXISTS openchpl.experience_type;
DROP TABLE IF EXISTS openchpl.newer_standards_met;
DROP TABLE IF EXISTS openchpl.standards_met;
DROP TABLE IF EXISTS openchpl.test_event_details;
DROP TABLE IF EXISTS openchpl.test_result_summary_version;
DROP TABLE IF EXISTS openchpl.utilized_test_tool;
DROP TABLE IF EXISTS openchpl.certification_result_test_task_participant;

--re-run grants 
\i dev/openchpl_grant-all.sql
