update openchpl.upload_template_version as utv
set deleted = true
where utv.name = 'New 2014 CHPL Upload Template v10'
or utv.name = '2015 CHPL Upload Template v10';

update openchpl.upload_template_version as utv
set available_as_of_date = '2017-11-06'
where utv.name = 'New 2014 CHPL Upload Template v11';

-- new view to use with the search
CREATE OR REPLACE VIEW 
openchpl.certified_product_search_result
AS
	SELECT all_listings_simple.*, 
			certs_for_listing.cert_number, 
			COALESCE(cqms_for_listing.cms_id, 'NQF-'||cqms_for_listing.nqf_number) as "cqm_number"	    
		FROM
		(SELECT
			cp.certified_product_id,
			COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
			lastCertStatusEvent.certification_status_name,
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
			history_vendor_name as "prev_vendor",
			certStatusEvent.certification_date,
			decert.decertification_date
		FROM openchpl.certified_product cp
		
		--certification date
		INNER JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
		
		--year
		INNER JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id

		--ACB
		INNER JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id

		-- version
		INNER JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
		--product
		INNER JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
		--developer
		INNER JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id

		--certification status
		INNER JOIN (
			SELECT certStatus.certification_status as "certification_status_name", cse.certified_product_id as "certified_product_id"
			FROM openchpl.certification_status_event cse
			INNER JOIN openchpl.certification_status certStatus ON cse.certification_status_id = certStatus.certification_status_id
			INNER JOIN
				(SELECT certified_product_id, extract(epoch from MAX(event_date)) event_date
				FROM openchpl.certification_status_event
				GROUP BY certified_product_id) maxCse
			ON cse.certified_product_id = maxCse.certified_product_id 
			--conversion to epoch/long comparison significantly faster than comparing the timestamp fields as-is
			AND extract(epoch from cse.event_date) = maxCse.event_date
		) lastCertStatusEvent
		ON lastCertStatusEvent.certified_product_id = cp.certified_product_id

		-- Practice type (2014 only)
		LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
		
		--ATL
		LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
		
		--decertification date
		LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8) group by (certified_product_id)) decert on cp.certified_product_id = decert.certified_product_id
		
		-- developer history
		LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" 
			FROM openchpl.vendor 
			JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
			WHERE product_owner_history_map.deleted = false) prev_vendor_owners
		ON prev_vendor_owners.history_product_id = product.product_id
	) all_listings_simple 
	--certs (adds so many rows to the result set it's faster to join it out here)
	LEFT OUTER JOIN
	(
		SELECT certification_criterion.number as "cert_number", certification_result.certified_product_id 
		FROM openchpl.certification_result, openchpl.certification_criterion 
		WHERE certification_criterion.certification_criterion_id = certification_result.certification_criterion_id 
		AND certification_criterion.deleted = false
		AND certification_result.success = true
		AND certification_result.deleted = false
	) certs_for_listing	
	ON certs_for_listing.certified_product_id = all_listings_simple.certified_product_id
	--cqms (adds so many rows to the result set it's faster to join it out here)
	LEFT OUTER JOIN
	(
		SELECT cms_id, nqf_number, certified_product_id 
		FROM openchpl.cqm_result, openchpl.cqm_criterion 
		WHERE cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
		AND cqm_criterion.deleted = false
		AND cqm_result.success = true
		AND cqm_result.deleted = false
	) cqms_for_listing	
	ON cqms_for_listing.certified_product_id = all_listings_simple.certified_product_id;
	
--re-run grants
\i dev/openchpl_grant-all.sql	