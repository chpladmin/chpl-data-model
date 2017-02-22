DROP VIEW IF EXISTS openchpl.certified_product_search;
CREATE OR REPLACE VIEW openchpl.certified_product_search AS

SELECT
    cp.certified_product_id,
    string_agg(DISTINCT cert_number::text, '☺') as "certs",
    string_agg(DISTINCT cqm_number::text, '☺') as "cqms",
    COALESCE(cp.chpl_product_number, substring(edition.year from 3 for 2)||'.'||atl.testing_lab_code||'.'||acb.certification_body_code||'.'||vendor.vendor_code||'.'||cp.product_code||'.'||cp.version_code||'.'||cp.ics_code||'.'||cp.additional_software_code||'.'||cp.certified_date_code) as "chpl_product_number",
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
    surveillance.open_surv_exists as "has_open_surveillance",
    surveillance.closed_surv_exists as "has_closed_surveillance",
    nonconformities.open_nonconformity_exists as "has_open_nonconformities",
    nonconformities.closed_nonconformity_exists as "has_closed_nonconformities"
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
    LEFT JOIN (SELECT name as "history_vendor_name", product_owner_history_map.product_id as "history_product_id" FROM openchpl.vendor 
			JOIN openchpl.product_owner_history_map ON vendor.vendor_id = product_owner_history_map.vendor_id
			WHERE product_owner_history_map.deleted = false) owners
    ON owners.history_product_id = product.product_id
    LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) certStatusEvent on cp.certified_product_id = certStatusEvent.certified_product_id
    LEFT JOIN (SELECT certified_product_id, 
			EXISTS(SELECT 1 FROM openchpl.surveillance 
				 WHERE openchpl.surveillance.deleted <> true 
				 AND start_date <= NOW() 
				 AND (end_date IS NULL OR end_date >= NOW())
				 AND openchpl.certified_product.certified_product_id = openchpl.surveillance.certified_product_id) as "open_surv_exists",
			EXISTS(SELECT 1 FROM openchpl.surveillance 
				 WHERE openchpl.surveillance.deleted <> true 
				 AND (end_date IS NOT NULL AND end_date <= NOW())
				 AND openchpl.certified_product.certified_product_id = openchpl.surveillance.certified_product_id) as "closed_surv_exists"			 
		FROM openchpl.certified_product) surveillance
    ON cp.certified_product_id = surveillance.certified_product_id
    LEFT JOIN (SELECT certified_product_id, 
			EXISTS(SELECT 1 FROM openchpl.surveillance surv
					JOIN openchpl.surveillance_requirement surv_req
					ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
					JOIN openchpl.surveillance_nonconformity surv_nc
					ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
					JOIN openchpl.nonconformity_status nc_status
					ON surv_nc.nonconformity_status_id = nc_status.id
				WHERE surv.deleted <> true 
				AND nc_status.name = 'Open'
				AND openchpl.certified_product.certified_product_id = surv.certified_product_id) as "open_nonconformity_exists",
			EXISTS(SELECT 1 FROM openchpl.surveillance surv
					JOIN openchpl.surveillance_requirement surv_req
					ON surv.id = surv_req.surveillance_id AND surv_req.deleted <> true
					JOIN openchpl.surveillance_nonconformity surv_nc
					ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
					JOIN openchpl.nonconformity_status nc_status
					ON surv_nc.nonconformity_status_id = nc_status.id
				WHERE surv.deleted <> true 
				AND nc_status.name = 'Closed'
				AND openchpl.certified_product.certified_product_id = surv.certified_product_id) as "closed_nonconformity_exists"
		FROM openchpl.certified_product ) nonconformities
    ON cp.certified_product_id = nonconformities.certified_product_id
    LEFT JOIN (SELECT number as "cert_number", certified_product_id FROM openchpl.certification_criterion 
		JOIN openchpl.certification_result ON certification_criterion.certification_criterion_id = certification_result.certification_criterion_id
		WHERE certification_result.success = true AND certification_result.deleted = false AND certification_criterion.deleted = false) certs
	ON certs.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT COALESCE(cms_id, 'NQF-'||nqf_number) as "cqm_number", certified_product_id FROM openchpl.cqm_criterion 
		JOIN openchpl.cqm_result 
		ON cqm_criterion.cqm_criterion_id = cqm_result.cqm_criterion_id
		WHERE cqm_result.success = true AND cqm_result.deleted = false AND cqm_criterion.deleted = false) cqms
	ON cqms.certified_product_id = cp.certified_product_id
	
WHERE cp.deleted != true
GROUP BY cp.certified_product_id, cp.acb_certification_id, edition.year, atl.testing_lab_code, acb.certification_body_code, vendor.vendor_code, cp.product_code, cp.version_code,cp.ics_code, cp.additional_software_code, cp.certified_date_code,
atl.testing_lab_name, acb.certification_body_name,prac.practice_type_name,version.product_version,product.product_name,vendor.vendor_name,certStatusEvent.certification_date,certStatus.certification_status_name,
surveillance.open_surv_exists, surveillance.closed_surv_exists, nonconformities.open_nonconformity_exists, nonconformities.closed_nonconformity_exists
;

GRANT ALL on openchpl.certified_product_search to openchpl;

ANALYZE;

-------------------------------------------------------------------------------------
-- OCD-1249 Add column to surveillance for "role" of creator
-------------------------------------------------------------------------------------
DO $$ 
    BEGIN
        BEGIN
            ALTER TABLE openchpl.surveillance ADD COLUMN user_permission_id INTEGER NOT NULL DEFAULT 3;
			RAISE NOTICE 'Added column user_permission_id to openchpl.surveillance';
        EXCEPTION
            WHEN duplicate_column THEN RAISE NOTICE 'column user_permission_id already exists in openchpl.surveillance';
        END;
		
		BEGIN
            ALTER TABLE openchpl.pending_surveillance ADD COLUMN user_permission_id INTEGER NOT NULL DEFAULT 3;
			RAISE NOTICE 'Added column user_permission_id to openchpl.pending_surveillance';
        EXCEPTION
            WHEN duplicate_column THEN RAISE NOTICE 'column user_permission_id already exists in openchpl.pending_surveillance';
        END;

        BEGIN
            ALTER TABLE openchpl.surveillance
		ADD CONSTRAINT user_permission_id_fk
		FOREIGN KEY (user_permission_id)
		REFERENCES openchpl.user_permission
		MATCH FULL
		ON DELETE CASCADE
		ON UPDATE CASCADE;
		RAISE NOTICE 'Added FK constraint user_permission_id_fk to openchpl.surveillance';
        EXCEPTION
            WHEN duplicate_object THEN RAISE NOTICE 'Table constraint openchpl.user_permission_id_fk already exists for openchpl.surveillance';
        END;
		
		BEGIN
            ALTER TABLE openchpl.pending_surveillance
		ADD CONSTRAINT user_permission_id_fk
		FOREIGN KEY (user_permission_id)
		REFERENCES openchpl.user_permission
		MATCH FULL
		ON DELETE CASCADE
		ON UPDATE CASCADE;
		RAISE NOTICE 'Added FK constraint user_permission_id_fk to openchpl.pending_surveillance';
        EXCEPTION
            WHEN duplicate_object THEN RAISE NOTICE 'Table constraint openchpl.user_permission_id_fk already exists for openchpl.pending_surveillance';
        END;
    END;
$$
