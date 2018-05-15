CREATE OR REPLACE VIEW openchpl.certified_product_details AS
SELECT
    a.certified_product_id,
    a.certification_edition_id,
    a.product_version_id,
    a.certification_body_id,
    (select chpl_product_number from openchpl.get_chpl_product_number(a.certified_product_id)),
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
    vendorstatus.last_vendor_status_change,
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
    COALESCE(k.count_certifications, 0::bigint) AS count_certifications,
    COALESCE(m.count_cqms, 0::bigint) AS count_cqms,
    COALESCE(surv.count_surveillance_activities, 0::bigint) AS count_surveillance_activities,
    COALESCE(surv_open.count_open_surveillance_activities, 0::bigint) AS count_open_surveillance_activities,
    COALESCE(surv_closed.count_closed_surveillance_activities, 0::bigint) AS count_closed_surveillance_activities,
    COALESCE(nc_open.count_open_nonconformities, 0::bigint) AS count_open_nonconformities,
    COALESCE(nc_closed.count_closed_nonconformities, 0::bigint) AS count_closed_nonconformities,
    r.certification_status_id,
    r.last_certification_status_change,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code
   FROM openchpl.certified_product a
     LEFT JOIN ( 
	   SELECT cse.certification_status_id,
       		cse.certified_product_id,
            cse.event_date AS last_certification_status_change
       FROM openchpl.certification_status_event cse
         INNER JOIN ( 
		   SELECT certification_status_event.certified_product_id,
           		max(certification_status_event.event_date) AS event_date
           FROM openchpl.certification_status_event
		   WHERE deleted <> true
           GROUP BY certification_status_event.certified_product_id) cseinner 
		 ON cse.certified_product_id = cseinner.certified_product_id 
		 AND cse.event_date = cseinner.event_date 
		WHERE cse.deleted <> true) r
	   ON r.certified_product_id = a.certified_product_id
     LEFT JOIN ( SELECT certification_status.certification_status_id,
            certification_status.certification_status AS certification_status_name
           FROM openchpl.certification_status) n ON r.certification_status_id = n.certification_status_id
     LEFT JOIN ( SELECT certification_edition.certification_edition_id,
            certification_edition.year
           FROM openchpl.certification_edition) b ON a.certification_edition_id = b.certification_edition_id
     LEFT JOIN ( SELECT certification_body.certification_body_id,
            certification_body.name AS certification_body_name,
            certification_body.acb_code AS certification_body_code,
            certification_body.deleted AS acb_is_deleted
           FROM openchpl.certification_body) c ON a.certification_body_id = c.certification_body_id
     LEFT JOIN ( SELECT product_classification_type.product_classification_type_id,
            product_classification_type.name AS product_classification_name
           FROM openchpl.product_classification_type) d ON a.product_classification_type_id = d.product_classification_type_id
     LEFT JOIN ( SELECT practice_type.practice_type_id,
            practice_type.name AS practice_type_name
           FROM openchpl.practice_type) e ON a.practice_type_id = e.practice_type_id
     LEFT JOIN ( SELECT product_version.product_version_id,
            product_version.version AS product_version,
            product_version.product_id
           FROM openchpl.product_version) f ON a.product_version_id = f.product_version_id
     LEFT JOIN ( SELECT product.product_id,
            product.vendor_id,
            product.name AS product_name
           FROM openchpl.product) g ON f.product_id = g.product_id
     LEFT JOIN ( SELECT vendor.vendor_id,
            vendor.name AS vendor_name,
            vendor.vendor_code,
            vendor.website AS vendor_website,
            vendor.address_id AS vendor_address,
            vendor.contact_id AS vendor_contact,
            vendor.vendor_status_id
           FROM openchpl.vendor) h ON g.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT acb_vendor_map.vendor_id,
            acb_vendor_map.certification_body_id,
            acb_vendor_map.transparency_attestation
           FROM openchpl.acb_vendor_map) p ON h.vendor_id = p.vendor_id AND a.certification_body_id = p.certification_body_id
     LEFT JOIN ( SELECT address.address_id,
            address.street_line_1,
            address.street_line_2,
            address.city,
            address.state,
            address.zipcode,
            address.country
           FROM openchpl.address) t ON h.vendor_address = t.address_id
     LEFT JOIN ( SELECT contact.contact_id,
            contact.first_name,
            contact.last_name,
            contact.email,
            contact.phone_number,
            contact.title
           FROM openchpl.contact) u ON h.vendor_contact = u.contact_id
     LEFT JOIN ( SELECT vshistory.vendor_status_id,
            vshistory.vendor_id,
            vshistory.status_date AS last_vendor_status_change
           FROM openchpl.vendor_status_history vshistory
             JOIN ( SELECT vendor_status_history.vendor_id,
                    max(vendor_status_history.status_date) AS status_date
                   FROM openchpl.vendor_status_history
                  WHERE vendor_status_history.deleted = false
                  GROUP BY vendor_status_history.vendor_id) vsinner ON vshistory.vendor_id = vsinner.vendor_id AND vshistory.status_date = vsinner.status_date) vendorstatus ON vendorstatus.vendor_id = h.vendor_id
     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
            vendor_status.name AS vendor_status_name
           FROM openchpl.vendor_status) v ON vendorstatus.vendor_status_id = v.vendor_status_id
     LEFT JOIN ( SELECT min(certification_status_event.event_date) AS certification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE certification_status_event.certification_status_id = 1
		  AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) i ON a.certified_product_id = i.certified_product_id
     LEFT JOIN ( SELECT max(certification_status_event.event_date) AS decertification_date,
            certification_status_event.certified_product_id
           FROM openchpl.certification_status_event
          WHERE certification_status_event.certification_status_id = ANY (ARRAY[3::bigint, 4::bigint, 8::bigint])
		  AND certification_status_event.deleted <> true
          GROUP BY certification_status_event.certified_product_id) decert ON a.certified_product_id = decert.certified_product_id
     LEFT JOIN ( SELECT j.certified_product_id,
            count(*) AS count_certifications
           FROM ( SELECT certification_result.certification_result_id,
                    certification_result.certification_criterion_id,
                    certification_result.certified_product_id,
                    certification_result.success,
                    certification_result.gap,
                    certification_result.sed,
                    certification_result.g1_success,
                    certification_result.g2_success,
                    certification_result.api_documentation,
                    certification_result.privacy_security_framework,
                    certification_result.creation_date,
                    certification_result.last_modified_date,
                    certification_result.last_modified_user,
                    certification_result.deleted
                   FROM openchpl.certification_result
                  WHERE certification_result.success = true AND certification_result.deleted <> true) j
          GROUP BY j.certified_product_id) k ON a.certified_product_id = k.certified_product_id
     LEFT JOIN ( SELECT l.certified_product_id,
            count(*) AS count_cqms
           FROM (SELECT DISTINCT
    						a.certified_product_id,
    						COALESCE(b.cms_id, b.nqf_number) AS cqm_id
   					FROM openchpl.cqm_result a
     					LEFT JOIN openchpl.cqm_criterion b 
							ON a.cqm_criterion_id = b.cqm_criterion_id
					WHERE a.success = true
					AND a.deleted <> true
					AND b.deleted <> true) l
          GROUP BY l.certified_product_id
          ORDER BY l.certified_product_id) m ON a.certified_product_id = m.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true) n_1
          GROUP BY n_1.certified_product_id) surv ON a.certified_product_id = surv.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND (surveillance.end_date IS NULL OR surveillance.end_date >= now())) n_1
          GROUP BY n_1.certified_product_id) surv_open ON a.certified_product_id = surv_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_surveillance_activities
           FROM ( SELECT surveillance.id,
                    surveillance.certified_product_id,
                    surveillance.friendly_id,
                    surveillance.start_date,
                    surveillance.end_date,
                    surveillance.type_id,
                    surveillance.randomized_sites_used,
                    surveillance.creation_date,
                    surveillance.last_modified_date,
                    surveillance.last_modified_user,
                    surveillance.deleted,
                    surveillance.user_permission_id
                   FROM openchpl.surveillance
                  WHERE surveillance.deleted <> true AND surveillance.start_date <= now() AND surveillance.end_date IS NOT NULL AND surveillance.end_date <= now()) n_1
          GROUP BY n_1.certified_product_id) surv_closed ON a.certified_product_id = surv_closed.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_open_nonconformities
           FROM ( SELECT surv_1.id,
                    surv_1.certified_product_id,
                    surv_1.friendly_id,
                    surv_1.start_date,
                    surv_1.end_date,
                    surv_1.type_id,
                    surv_1.randomized_sites_used,
                    surv_1.creation_date,
                    surv_1.last_modified_date,
                    surv_1.last_modified_user,
                    surv_1.deleted,
                    surv_1.user_permission_id,
                    surv_req.id,
                    surv_req.surveillance_id,
                    surv_req.type_id,
                    surv_req.certification_criterion_id,
                    surv_req.requirement,
                    surv_req.result_id,
                    surv_req.creation_date,
                    surv_req.last_modified_date,
                    surv_req.last_modified_user,
                    surv_req.deleted,
                    surv_nc.id,
                    surv_nc.surveillance_requirement_id,
                    surv_nc.certification_criterion_id,
                    surv_nc.nonconformity_type,
                    surv_nc.nonconformity_status_id,
                    surv_nc.date_of_determination,
                    surv_nc.corrective_action_plan_approval_date,
                    surv_nc.corrective_action_start_date,
                    surv_nc.corrective_action_must_complete_date,
                    surv_nc.corrective_action_end_date,
                    surv_nc.summary,
                    surv_nc.findings,
                    surv_nc.sites_passed,
                    surv_nc.total_sites,
                    surv_nc.developer_explanation,
                    surv_nc.resolution,
                    surv_nc.creation_date,
                    surv_nc.last_modified_date,
                    surv_nc.last_modified_user,
                    surv_nc.deleted,
                    nc_status.id,
                    nc_status.name,
                    nc_status.creation_date,
                    nc_status.last_modified_date,
                    nc_status.last_modified_user,
                    nc_status.deleted
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                     JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                  WHERE surv_1.deleted <> true AND nc_status.name::text = 'Open'::text) n_1(id, certified_product_id, friendly_id, start_date, end_date, type_id, randomized_sites_used, creation_date, last_modified_date, last_modified_user, deleted, user_permission_id, id_1, surveillance_id, type_id_1, certification_criterion_id, requirement, result_id, creation_date_1, last_modified_date_1, last_modified_user_1, deleted_1, id_2, surveillance_requirement_id, certification_criterion_id_1, nonconformity_type, nonconformity_status_id, date_of_determination, corrective_action_plan_approval_date, corrective_action_start_date, corrective_action_must_complete_date, corrective_action_end_date, summary, findings, sites_passed, total_sites, developer_explanation, resolution, creation_date_2, last_modified_date_2, last_modified_user_2, deleted_2, id_3, name, creation_date_3, last_modified_date_3, last_modified_user_3, deleted_3)
          GROUP BY n_1.certified_product_id) nc_open ON a.certified_product_id = nc_open.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_nonconformities
           FROM ( SELECT surv_1.id,
                    surv_1.certified_product_id,
                    surv_1.friendly_id,
                    surv_1.start_date,
                    surv_1.end_date,
                    surv_1.type_id,
                    surv_1.randomized_sites_used,
                    surv_1.creation_date,
                    surv_1.last_modified_date,
                    surv_1.last_modified_user,
                    surv_1.deleted,
                    surv_1.user_permission_id,
                    surv_req.id,
                    surv_req.surveillance_id,
                    surv_req.type_id,
                    surv_req.certification_criterion_id,
                    surv_req.requirement,
                    surv_req.result_id,
                    surv_req.creation_date,
                    surv_req.last_modified_date,
                    surv_req.last_modified_user,
                    surv_req.deleted,
                    surv_nc.id,
                    surv_nc.surveillance_requirement_id,
                    surv_nc.certification_criterion_id,
                    surv_nc.nonconformity_type,
                    surv_nc.nonconformity_status_id,
                    surv_nc.date_of_determination,
                    surv_nc.corrective_action_plan_approval_date,
                    surv_nc.corrective_action_start_date,
                    surv_nc.corrective_action_must_complete_date,
                    surv_nc.corrective_action_end_date,
                    surv_nc.summary,
                    surv_nc.findings,
                    surv_nc.sites_passed,
                    surv_nc.total_sites,
                    surv_nc.developer_explanation,
                    surv_nc.resolution,
                    surv_nc.creation_date,
                    surv_nc.last_modified_date,
                    surv_nc.last_modified_user,
                    surv_nc.deleted,
                    nc_status.id,
                    nc_status.name,
                    nc_status.creation_date,
                    nc_status.last_modified_date,
                    nc_status.last_modified_user,
                    nc_status.deleted
                   FROM openchpl.surveillance surv_1
                     JOIN openchpl.surveillance_requirement surv_req ON surv_1.id = surv_req.surveillance_id AND surv_req.deleted <> true
                     JOIN openchpl.surveillance_nonconformity surv_nc ON surv_req.id = surv_nc.surveillance_requirement_id AND surv_nc.deleted <> true
                     JOIN openchpl.nonconformity_status nc_status ON surv_nc.nonconformity_status_id = nc_status.id
                  WHERE surv_1.deleted <> true AND nc_status.name::text = 'Closed'::text) n_1(id, certified_product_id, friendly_id, start_date, end_date, type_id, randomized_sites_used, creation_date, last_modified_date, last_modified_user, deleted, user_permission_id, id_1, surveillance_id, type_id_1, certification_criterion_id, requirement, result_id, creation_date_1, last_modified_date_1, last_modified_user_1, deleted_1, id_2, surveillance_requirement_id, certification_criterion_id_1, nonconformity_type, nonconformity_status_id, date_of_determination, corrective_action_plan_approval_date, corrective_action_start_date, corrective_action_must_complete_date, corrective_action_end_date, summary, findings, sites_passed, total_sites, developer_explanation, resolution, creation_date_2, last_modified_date_2, last_modified_user_2, deleted_2, id_3, name, creation_date_3, last_modified_date_3, last_modified_user_3, deleted_3)
          GROUP BY n_1.certified_product_id) nc_closed ON a.certified_product_id = nc_closed.certified_product_id
     LEFT JOIN ( SELECT testing_lab.testing_lab_id,
            testing_lab.name AS testing_lab_name,
            testing_lab.testing_lab_code
           FROM openchpl.testing_lab) q ON a.testing_lab_id = q.testing_lab_id;
		   
--re-run grants
\i dev/openchpl_grant-all.sql