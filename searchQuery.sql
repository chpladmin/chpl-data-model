SELECT filtered_listings_with_rows.* 
FROM
	(SELECT *, DENSE_RANK() OVER(ORDER BY all_listings.certified_product_id) listing_row 
	FROM
		--do this join to filter by any search params that are provided
		--it will return the list of certified_product_ids that match the search params
		--so that in the all_listings query above, only the matched certified products
		--are queried
		(SELECT DISTINCT certified_product_id
		FROM
			(SELECT
			    cp.certified_product_id
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

			--TODO: this part is kind of slow
			--only add this if certification status is being queried (i think it always is?)				
			--INNER JOIN (SELECT certStatus.certification_status as "certification_status_name", cse.certified_product_id as "certified_product_id",
			--		cse.event_date as "last_certification_status_change"
			--	FROM openchpl.certification_status_event cse,
			--		openchpl.certification_status certStatus,
			--		(SELECT certified_product_id, MAX(event_date) event_date
			--		FROM openchpl.certification_status_event
			--		GROUP BY certified_product_id) maxCse
			--	WHERE cse.certified_product_id = maxCse.certified_product_id 
			--	AND cse.event_date = maxCse.event_date
			--	AND cse.certification_status_id = certStatus.certification_status_id
			--	AND UPPER(certStatus.certification_status) LIKE 'ACTIVE') lastCertStatusEvent
			--ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
    
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
			--AND (UPPER(vendor_name) LIKE '%EPIC%' OR UPPER(product_name) LIKE '%EPIC%' OR UPPER(acb_certification_id) LIKE '%EPIC%')

			-- Search Term Query against CHPL ID is 1.7s, 698 rows
			--AND COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) LIKE '%14.07.07.EP%'

			
			ORDER BY certified_product_id
			) filtered_listings
		) filtered_certified_product_ids
		INNER JOIN
		(SELECT
		    cp.certified_product_id,
		    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
		    --lastCertStatusEvent.certification_status_name,
		    certs.cert_number,
		    COALESCE(cqms.cms_id, 'NQF-'||cqms.nqf_number) as "cqm_number",
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
		    certStatusEvent.certification_date
		FROM openchpl.certified_product cp
		--certification date
		INNER JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
		--year
		INNER JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) edition on cp.certification_edition_id = edition.certification_edition_id
		--ATL
		LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
		--ACB
		INNER JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) acb on cp.certification_body_id = acb.certification_body_id
		-- Practice type (2014 only)
		LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" FROM openchpl.practice_type) prac on cp.practice_type_id = prac.practice_type_id
		-- version
		INNER JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) version on cp.product_version_id = version.product_version_id
		--product
		INNER JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) product ON version.product_id = product.product_id
		--developer
		INNER JOIN (SELECT vendor_id, name as "vendor_name", vendor_code FROM openchpl.vendor) vendor on product.vendor_id = vendor.vendor_id
		--certification status
		--INNER JOIN (
		--	SELECT certStatus.certification_status as "certification_status_name", cse.certified_product_id as "certified_product_id"
		--	FROM openchpl.certification_status_event cse,
		--		openchpl.certification_status certStatus,
		--		(SELECT certified_product_id, MAX(event_date) event_date
		--		FROM openchpl.certification_status_event
		--		GROUP BY certified_product_id) maxCse
		--	WHERE cse.certified_product_id = maxCse.certified_product_id 
		--	AND cse.event_date = maxCse.event_date
		--	AND cse.certification_status_id = certStatus.certification_status_id) lastCertStatusEvent
		--ON lastCertStatusEvent.certified_product_id = cp.certified_product_id
		--criteria
		INNER JOIN (SELECT certification_criterion.number as "cert_number", certification_result.certified_product_id 
			FROM openchpl.certification_result 
			JOIN openchpl.certification_criterion 
			ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id 
			AND certification_criterion.deleted = false
			WHERE certification_result.success = true
			AND certification_result.deleted = false) certs
		ON certs.certified_product_id = cp.certified_product_id
		--cqms
		INNER JOIN (SELECT cms_id, nqf_number, certified_product_id 
			FROM openchpl.cqm_result 
			JOIN openchpl.cqm_criterion 
			ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
			AND cqm_criterion.deleted = false
			WHERE cqm_result.success = true
			AND cqm_result.deleted = false) cqms
		ON cqms.certified_product_id = cp.certified_product_id		    
		) all_listings 
	ON filtered_certified_product_ids.certified_product_id = all_listings.certified_product_id) filtered_listings_with_rows 
		
WHERE
listing_row > 0 AND listing_row <= 100;

--TODO: i increased the memory to try to improve query speed
--TODO: i added indexes somewhere else but forget where... some success and deleted fields for cert result and cqm result?

--ALTER TABLE openchpl.certification_status_event DROP CONSTRAINT IF EXISTS certified_product_fk;
--ALTER TABLE openchpl.certification_status_event
--ADD CONSTRAINT certified_product_fk FOREIGN KEY (certified_product_id)
--      REFERENCES openchpl.certified_product (certified_product_id) MATCH FULL
--      ON UPDATE CASCADE ON DELETE RESTRICT;

--VACUUM ANALYZE;