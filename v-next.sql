-------------------------------------------------------------------------------------
-- OCD-1039 Add indexes to improve performance
-------------------------------------------------------------------------------------
DO $$
BEGIN

IF to_regclass('openchpl.ix_certified_product') IS NULL THEN
    CREATE INDEX ix_certified_product ON openchpl.certified_product (certified_product_id, certification_edition_id, product_version_id, 
       testing_lab_id, certification_body_id, acb_certification_id, practice_type_id, product_classification_type_id, 
       certification_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_product') IS NULL THEN
    CREATE INDEX ix_product ON openchpl.product (product_id, vendor_id, deleted);
END IF;

IF to_regclass('openchpl.ix_vendor') IS NULL THEN
    CREATE INDEX ix_vendor ON openchpl.vendor (vendor_id, address_id, contact_id, vendor_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_criterion') IS NULL THEN
    CREATE INDEX ix_certification_criterion ON openchpl.certification_criterion (certification_criterion_id, certification_edition_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_event') IS NULL THEN
    CREATE INDEX ix_certification_event ON openchpl.certification_event (certification_event_id, certified_product_id, event_type_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result') IS NULL THEN
    CREATE INDEX ix_certification_result ON openchpl.certification_result (certification_result_id, certification_criterion_id, certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_additional_software') IS NULL THEN
    CREATE INDEX ix_certification_result_additional_software ON openchpl.certification_result_additional_software (certification_result_additional_software_id, certification_result_id, 
    certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_data') IS NULL THEN
    CREATE INDEX ix_certification_result_test_data ON openchpl.certification_result_test_data (certification_result_test_data_id, certification_result_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_functionality') IS NULL THEN
    CREATE INDEX ix_certification_result_test_functionality ON openchpl.certification_result_test_functionality (certification_result_test_functionality_id, certification_result_id, 
       test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_procedure') IS NULL THEN
    CREATE INDEX ix_certification_result_test_procedure ON openchpl.certification_result_test_procedure (certification_result_test_procedure_id, certification_result_id, test_procedure_id, 
    deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_standard') IS NULL THEN
    CREATE INDEX ix_certification_result_test_standard ON openchpl.certification_result_test_standard (certification_result_test_standard_id, certification_result_id, 
       test_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_task') IS NULL THEN
    CREATE INDEX ix_certification_result_test_task ON openchpl.certification_result_test_task (certification_result_test_task_id, certification_result_id, test_task_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_task_participant') IS NULL THEN
    CREATE INDEX ix_certification_result_test_task_participant ON openchpl.certification_result_test_task_participant (certification_result_test_task_participant_id, 
    certification_result_test_task_id, test_participant_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_test_tool') IS NULL THEN
    CREATE INDEX ix_certification_result_test_tool ON openchpl.certification_result_test_tool (certification_result_test_tool_id, certification_result_id, test_tool_id, 
 deleted);
END IF;

IF to_regclass('openchpl.ix_certification_result_ucd_process') IS NULL THEN
    CREATE INDEX ix_certification_result_ucd_process ON openchpl.certification_result_ucd_process (certification_result_ucd_process_id, certification_result_id, 
       ucd_process_id, deleted);
END IF;

IF to_regclass('openchpl.ix_certified_product_qms_standard') IS NULL THEN
END IF;
    CREATE INDEX ix_certified_product_qms_standard ON openchpl.certified_product_qms_standard (certified_product_qms_standard_id, certified_product_id, qms_standard_id, deleted);

IF to_regclass('openchpl.ix_contact') IS NULL THEN
    CREATE INDEX ix_contact ON openchpl.contact (contact_id, deleted);
END IF;

IF to_regclass('openchpl.ix_cqm_criterion') IS NULL THEN
    CREATE INDEX ix_cqm_criterion ON openchpl.cqm_criterion (cqm_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_cqm_result') IS NULL THEN
    CREATE INDEX ix_cqm_result ON openchpl.cqm_result (cqm_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_ehr_certification_id') IS NULL THEN
    CREATE INDEX ix_ehr_certification_id ON openchpl.ehr_certification_id (ehr_certification_id_id, certification_id, practice_type_id);
END IF;

IF to_regclass('openchpl.ix_ehr_certification_id_product_map') IS NULL THEN
    CREATE INDEX ix_ehr_certification_id_product_map ON openchpl.ehr_certification_id_product_map (ehr_certification_id_product_map_id, ehr_certification_id_id, certified_product_id);
END IF;

IF to_regclass('openchpl.ix_global_user_permission_map') IS NULL THEN
    CREATE INDEX ix_global_user_permission_map ON openchpl.global_user_permission_map (user_id, user_permission_id_user_permission, deleted, global_user_permission_id);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result') IS NULL THEN
    CREATE INDEX ix_pending_certification_result ON openchpl.pending_certification_result (pending_certification_result_id, certification_criterion_id, 
       pending_certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_additional_software') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_additional_software ON openchpl.pending_certification_result_additional_software (pending_certification_result_additional_software_id, pending_certification_result_id, certified_product_id, certified_product_chpl_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_data') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_data ON openchpl.pending_certification_result_test_data (pending_certification_result_test_data_id, pending_certification_result_id, 
       deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_functionality') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_functionality ON openchpl.pending_certification_result_test_functionality (pending_certification_result_test_functionality_id, pending_certification_result_id, test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_procedure') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_procedure ON openchpl.pending_certification_result_test_procedure (pending_certification_result_test_procedure_id, pending_certification_result_id, 
       test_procedure_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_standard') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_standard ON openchpl.pending_certification_result_test_standard (pending_certification_result_test_standard_id, pending_certification_result_id, 
       test_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_task') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_task ON openchpl.pending_certification_result_test_task (pending_certification_result_test_task_id, pending_certification_result_id, 
       pending_test_task_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_task_participant') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_task_participant ON openchpl.pending_certification_result_test_task_participant (pending_certification_result_test_task_participant_id, pending_certification_result_test_task_id, pending_test_participant_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_test_tool') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_test_tool ON openchpl.pending_certification_result_test_tool (pending_certification_result_test_tool_id, pending_certification_result_id, 
       test_tool_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certification_result_ucd_process') IS NULL THEN
    CREATE INDEX ix_pending_certification_result_ucd_process ON openchpl.pending_certification_result_ucd_process (pending_certification_result_ucd_process_id, pending_certification_result_id, 
       ucd_process_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product') IS NULL THEN
    CREATE INDEX ix_pending_certified_product ON openchpl.pending_certified_product (pending_certified_product_id, unique_id, acb_certification_id, practice_type_id, vendor_id, vendor_address_id, vendor_contact_id, product_id, product_version_id, certification_edition_id, certification_body_id, product_classification_id, testing_lab_id, deleted, certification_status_id);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product_accessibility_standard') IS NULL THEN
    CREATE INDEX ix_pending_certified_product_accessibility_standard ON openchpl.pending_certified_product_accessibility_standard (pending_certified_product_accessibility_standard_id, pending_certified_product_id, accessibility_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_certified_product_qms_standard') IS NULL THEN
    CREATE INDEX ix_pending_certified_product_qms_standard ON openchpl.pending_certified_product_qms_standard (pending_certified_product_qms_standard_id, pending_certified_product_id, 
       qms_standard_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_cqm_certification_criteria') IS NULL THEN
    CREATE INDEX ix_pending_cqm_certification_criteria ON openchpl.pending_cqm_certification_criteria (pending_cqm_certification_criteria_id, pending_cqm_criterion_id, 
       certification_criterion_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_cqm_criterion') IS NULL THEN
    CREATE INDEX ix_pending_cqm_criterion ON openchpl.pending_cqm_criterion (pending_cqm_criterion_id, cqm_criterion_id, pending_certified_product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_pending_test_participant') IS NULL THEN
    CREATE INDEX ix_pending_test_participant ON openchpl.pending_test_participant (pending_test_participant_id, test_participant_unique_id, education_type_id, deleted, 
       test_participant_age_id);
END IF;

IF to_regclass('openchpl.ix_pending_test_task') IS NULL THEN
    CREATE INDEX ix_pending_test_task ON openchpl.pending_test_task (pending_test_task_id, test_task_unique_id, deleted);
END IF;

IF to_regclass('openchpl.ix_product_version') IS NULL THEN
    CREATE INDEX ix_product_version ON openchpl.product_version (product_version_id, product_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance') IS NULL THEN
    CREATE INDEX ix_surveillance ON openchpl.surveillance (id, certified_product_id, friendly_id, type_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_nonconformity') IS NULL THEN
    CREATE INDEX ix_surveillance_nonconformity ON openchpl.surveillance_nonconformity (id, surveillance_requirement_id, certification_criterion_id, nonconformity_type, nonconformity_status_id, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_requirement') IS NULL THEN
    CREATE INDEX ix_surveillance_requirement ON openchpl.surveillance_requirement (id, surveillance_id, type_id, certification_criterion_id, requirement, result_id, creation_date, last_modified_date, last_modified_user, deleted);
END IF;

IF to_regclass('openchpl.ix_surveillance_requirement_type') IS NULL THEN
    CREATE INDEX ix_surveillance_requirement_type ON openchpl.surveillance_requirement_type (id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_functionality') IS NULL THEN
    CREATE INDEX ix_test_functionality ON openchpl.test_functionality (test_functionality_id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_participant') IS NULL THEN
    CREATE INDEX ix_test_participant ON openchpl.test_participant (test_participant_id, education_type_id, deleted, test_participant_age_id);
END IF;

IF to_regclass('openchpl.ix_test_procedure') IS NULL THEN
    CREATE INDEX ix_test_procedure ON openchpl.test_procedure (test_procedure_id, deleted);
END IF;

IF to_regclass('openchpl.ix_test_standard') IS NULL THEN
    CREATE INDEX ix_test_standard ON openchpl.test_standard (test_standard_id, deleted);
END IF;

END$$;

-------------------------------------------------------------------------------------
-- OCD-1135 add new certification status
-------------------------------------------------------------------------------------

insert into openchpl.certification_status (certification_status, last_modified_user)
select
        'Withdrawn by Developer Under Surveillance/Review', -1
where not exists (
        select * from openchpl.certification_status where certification_status = 'Withdrawn by Developer Under Surveillance/Review'
);

-------------------------------------------------------------------------------------
-- VIEW CHANGES dependent on all above
-------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW openchpl.certified_product_details AS

SELECT
    a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.testing_lab_id,
    a.certification_body_id,
    a.chpl_product_number,
    a.report_file_location,
    a.sed_report_file_location,
    a.sed_intended_user_description,
    a.sed_testing_end,
    a.acb_certification_id,
    a.practice_type_id,
    a.product_classification_type_id,
    a.other_acb,
	a.creation_date,
    a.deleted,
    a.product_code,
    a.version_code,
    a.ics_code,
    a.additional_software_code,
    a.certified_date_code,
    a.transparency_attestation_url,
    a.ics,
    a.sed,
    a.qms,
    a.accessibility_certified,
    a.product_additional_software,
    a.last_modified_date,
    a.meaningful_use_users,	
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    c.acb_is_deleted,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
	v.vendor_status_id,
	v.vendor_status_name,
    t.address_id,
    t.street_line_1,
    t.street_line_2,
    t.city,
    t.state,
    t.zipcode,
    t.country,
    u.contact_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.title,
    i.certification_date,
	decert.decertification_date,
    COALESCE(k.count_certifications, 0) as "count_certifications",
    COALESCE(m.count_cqms, 0) as "count_cqms",
	COALESCE(surv.count_surveillance_activities, 0) as "count_surveillance_activities",
    COALESCE(surv_open.count_open_surveillance_activities, 0) as "count_open_surveillance_activities",
	COALESCE(surv_closed.count_closed_surveillance_activities, 0) as "count_closed_surveillance_activities",
    COALESCE(nc_open.count_open_nonconformities, 0) as "count_open_nonconformities",
	COALESCE(nc_closed.count_closed_nonconformities, 0) as "count_closed_nonconformities",
	r.certification_status_id,
	r.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code

FROM openchpl.certified_product a
	LEFT JOIN (SELECT cse.certification_status_id as "certification_status_id", cse.certified_product_id as "certified_product_id",
				cse.event_date as "last_certification_status_change"
				FROM openchpl.certification_status_event cse
				INNER JOIN (
					SELECT certified_product_id, MAX(event_date) event_date
					FROM openchpl.certification_status_event
					GROUP BY certified_product_id
				) cseInner 
				ON cse.certified_product_id = cseInner.certified_product_id AND cse.event_date = cseInner.event_date) r
		ON r.certified_product_id = a.certified_product_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) n on r.certification_status_id = n.certification_status_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code", deleted as "acb_is_deleted" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_classification_type_id, name as "product_classification_name" FROM openchpl.product_classification_type) d on a.product_classification_type_id = d.product_classification_type_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" from openchpl.practice_type) e on a.practice_type_id = e.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact", vendor_status_id from openchpl.vendor) h on g.vendor_id = h.vendor_id
    LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and a.certification_body_id = p.certification_body_id
    LEFT JOIN (SELECT address_id, street_line_1, street_line_2, city, state, zipcode, country from openchpl.address) t on h.vendor_address = t.address_id
    LEFT JOIN (SELECT contact_id, first_name, last_name, email, phone_number, title from openchpl.contact) u on h.vendor_contact = u.contact_id
	LEFT JOIN (SELECT vendor_status_id, name as "vendor_status_name" from openchpl.vendor_status) v on h.vendor_status_id = v.vendor_status_id
	LEFT JOIN (SELECT MIN(event_date) as "certification_date", certified_product_id from openchpl.certification_status_event where certification_status_id = 1 group by (certified_product_id)) i on a.certified_product_id = i.certified_product_id
	LEFT JOIN (SELECT MAX(event_date) as "decertification_date", certified_product_id from openchpl.certification_status_event where certification_status_id IN (3, 4, 8, 9) group by (certified_product_id)) decert on a.certified_product_id = decert.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_certifications" FROM (SELECT * FROM openchpl.certification_result WHERE success = true AND deleted <> true) j GROUP BY certified_product_id) k ON a.certified_product_id = k.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_cqms" FROM (SELECT DISTINCT ON (cqm_id, certified_product_id) * FROM openchpl.cqm_result_details WHERE success = true AND deleted <> true) l GROUP BY certified_product_id ORDER BY certified_product_id) m ON a.certified_product_id = m.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_surveillance_activities" FROM (SELECT * FROM openchpl.surveillance WHERE deleted <> true) n GROUP BY certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_open_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND (end_date IS NULL OR end_date >= NOW())) n GROUP BY certified_product_id) surv_open
    ON a.certified_product_id = surv_open.certified_product_id
	LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_surveillance_activities" FROM
	    (SELECT * FROM openchpl.surveillance 
		 WHERE openchpl.surveillance.deleted <> true 
		 AND start_date <= NOW() 
		 AND end_date IS NOT NULL 
		 AND end_date <= NOW()) n GROUP BY certified_product_id) surv_closed
    ON a.certified_product_id = surv_closed.certified_product_id
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
    ON a.certified_product_id = nc_open.certified_product_id
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
    ON a.certified_product_id = nc_closed.certified_product_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) q on a.testing_lab_id = q.testing_lab_id
    ;

GRANT ALL ON TABLE openchpl.certified_product_details TO openchpl;

-------------------------------------------------------------------------------------
-- OCD-1097 Re-retire "Transport Test[ing] Tool"
-------------------------------------------------------------------------------------

UPDATE openchpl.test_tool
SET retired = TRUE
WHERE name IN ('Transport Testing Tool', 'Transport Test Tool');
