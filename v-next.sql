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
	
CREATE OR REPLACE FUNCTION 
openchpl.SearchListings(startIndex integer, endIndex integer) 
RETURNS SETOF openchpl.certified_product_search_result
AS $$

SELECT certified_product_search_result.* 
FROM
	(SELECT * 
	FROM
		--do this join to filter by any search params that are provided
		--it will return the list of certified_product_ids that match the search params
		--so that in the all_listings query above, only the matched certified products
		--are queried
			(SELECT DISTINCT
			    cp.certified_product_id, DENSE_RANK() OVER(ORDER BY cp.certified_product_id) listing_row
			FROM openchpl.certified_product cp

			--I think we will always be using this field but 
			--if they specified all three editions we could leave it out
			INNER JOIN (SELECT certification_edition_id, year 
			FROM openchpl.certification_edition) edition 
			ON cp.certification_edition_id = edition.certification_edition_id
			AND year IN ('2014', '2015')

			--these next three always need to be in
			INNER JOIN (SELECT product_version_id, version as "product_version", product_id 
				FROM openchpl.product_version) version 
			ON cp.product_version_id = version.product_version_id
			
			INNER JOIN (SELECT product_id, vendor_id, name as "product_name" 
				FROM openchpl.product) product 
			ON version.product_id = product.product_id
			
			INNER JOIN (SELECT vendor_id, name as "vendor_name", vendor_code 
				FROM openchpl.vendor) vendor 
			ON product.vendor_id = vendor.vendor_id

			LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" 
				FROM openchpl.vendor 
				JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
				WHERE product_owner_history_map.deleted = false) prev_vendor_owners
			ON prev_vendor_owners.history_product_id = product.product_id
		
			--left join here because not all listings have a testing lab specified
			LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code 
				FROM openchpl.testing_lab) atl 
			ON cp.testing_lab_id = atl.testing_lab_id
			-- only add this if testing lab name is searched for
			--AND UPPER(testing_lab_name) LIKE '%ICSA%'

			INNER JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code"
				FROM openchpl.certification_body) acb 
			ON cp.certification_body_id = acb.certification_body_id
			--only add this if acb name is searched for			
			--AND UPPER(certification_body_name) LIKE '%ICSA LABS%'

			--only add this if certification status is being queried (i think it always is?)				
			INNER JOIN (SELECT  cse.certified_product_id as "certified_product_id", cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse,
					(SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id) maxCse
				WHERE cse.certified_product_id = maxCse.certified_product_id 
				AND cse.event_date = maxCse.event_date
				AND cse.certification_status_id IN (1,6,7)) lastCertStatusEvent
			ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
    
			-- only add this if certification date is being queried
			--INNER JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id 
			--	FROM openchpl.certification_status_event 
			--	WHERE certification_status_id = 1 
			--	GROUP BY (certified_product_id)) certStatusEvent 
			--ON cp.certified_product_id = certStatusEvent.certified_product_id
			--AND certification_date > '2016-07-01 00:00:00'
			--AND certification_date > '2016-07-01 00:00:00' AND certification_date < '2016-08-01 00:00:00'
			--AND certification_date < '2014-01-01 00:00:00'
			
			--only add this if practice type is searched for
			--INNER JOIN (SELECT practice_type_id, name as "practice_type_name" 
			--	FROM openchpl.practice_type) prac 
			--ON cp.practice_type_id = prac.practice_type_id
			--AND UPPER(practice_type_name) LIKE 'AMBULATORY'

			-- Only need to include the next three left joins if surveillance or nonconformity fields are searched
			-- They don't seem to add a lot of time, we could just always having them in the query?
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
    
			-- only add this if criteria is being queried
			--INNER JOIN (SELECT certification_criterion.number as "cert_number", certification_result.certified_product_id 
			--	FROM openchpl.certification_result 
			--	JOIN openchpl.certification_criterion 
			--	ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id 
			--	AND certification_criterion.deleted = false
			--	WHERE certification_result.success = true
			--	AND certification_result.deleted = false) certs
			--ON certs.certified_product_id = cp.certified_product_id
			--AND UPPER(certs.cert_number) LIKE '170.314 (A)(19)'

			--only add this if multiple criteria are being ORed together
			--AND UPPER(certs.cert_number) IN ('170.314 (G)(3)', '170.314 (B)(5)(A)', '170.314 (F)(3)')

			--only add this if multiple criteria are being ANDed together (listing must have all three)
			--note make sure to name the certs table differently for each join
			--INNER JOIN (SELECT certification_criterion.number as "cert_number", certification_result.certified_product_id 
			--	FROM openchpl.certification_result 
			--	JOIN openchpl.certification_criterion 
			--	ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id 
			--	AND certification_criterion.deleted = false
			--	WHERE certification_result.success = true
			--	AND certification_result.deleted = false) certs_1
			--ON certs_1.certified_product_id = cp.certified_product_id
			--AND UPPER(certs_1.cert_number) LIKE '170.314 (B)(5)(A)'
		
			 -- only add this if cqms are being queried and btw add it last so it's run over the least amount of data
			 -- (like other listings might get eliminated from consideration for the result set before the query gets to here
			--INNER JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id 
			--	FROM openchpl.cqm_result, openchpl.cqm_criterion 
			--	WHERE cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
			--	AND cqm_criterion.deleted = false
			--	AND cqm_result.success = true
			--	AND cqm_result.deleted = false) cqms
			--ON cqms.certified_product_id = cp.certified_product_id 
			--AND UPPER(cqms.cqm_number) LIKE 'CMS22'

			--only add this if multiple cqms are being ORed together
			--AND UPPER(cqms.cqm_number) IN ('CMS90', 'CMS127', 'CMS12')

			-- only add this if multiple cqms are being ANDed together
			-- make sure to reference the cqms table wit ha different name for each time this chunk is added
			--INNER JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id 
			--	FROM openchpl.cqm_result, openchpl.cqm_criterion 
			--	WHERE cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
			--	AND cqm_criterion.deleted = false
			--	AND cqm_result.success = true
			--	AND cqm_result.deleted = false) cqms_1
			--ON cqms_1.certified_product_id = cp.certified_product_id 
			--AND UPPER(cqms_1.cqm_number) LIKE 'CMS22'

			WHERE cp.deleted != true

			-- Search Term Query against vendor, product, acbCertificationId is 3.3s, 2763 rows
			--AND (UPPER(vendor_name) LIKE '%APRIMA%' OR UPPER(history_vendor_name) LIKE '%APRIMA%' OR UPPER(product_name) LIKE '%APRIMA%' OR UPPER(acb_certification_id) LIKE '%APRIMA%')

			-- Search Term Query against CHPL ID is 1.7s, 698 rows
			--AND COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) LIKE '%14.07.07.EP%'

			-- Has had surveillance
			--AND count_surveillance_activities > 0

			-- Has never had surveillance
			--AND count_surveillance_activities IS NULL

			-- Has never had a nonconformity
			--AND count_open_nonconformities IS NULL AND count_closed_nonconformities IS NULL

			-- Has an open nonconformity
			--AND count_open_nonconformities > 0

			-- Has a closed nonconformity
			--AND count_closed_nonconformities > 0
			
			ORDER BY certified_product_id
			) filtered_certified_product_ids
		WHERE listing_row >= startIndex AND listing_row <= endIndex
		) filtered_listings_with_rows
		INNER JOIN openchpl.certified_product_search_result 
		ON filtered_listings_with_rows.certified_product_id = certified_product_search_result.certified_product_id 
		
$$ LANGUAGE SQL;
	
--re-run grants
\i dev/openchpl_grant-all.sql	