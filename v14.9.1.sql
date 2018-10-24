CREATE OR REPLACE VIEW openchpl.certified_product_summary AS
 SELECT cp.certified_product_id,
    cp.certification_edition_id,
    cp.product_version_id,
    cp.testing_lab_id,
    cp.certification_body_id,
    cp.chpl_product_number,
    cp.report_file_location,
    cp.sed_report_file_location,
    cp.sed_intended_user_description,
    cp.sed_testing_end,
    cp.acb_certification_id,
    cp.practice_type_id,
    cp.product_classification_type_id,
    cp.product_additional_software,
    cp.other_acb,
    cp.transparency_attestation_url,
    cp.ics,
    cp.sed,
    cp.qms,
    cp.accessibility_certified,
    cp.product_code,
    cp.version_code,
    cp.ics_code,
    cp.additional_software_code,
    cp.certified_date_code,
    cp.creation_date,
    cp.last_modified_date,
    cp.last_modified_user,
    cp.deleted,
    cp.pending_certified_product_id,
	muuResult.meaningful_use_users,
    ce.year,
    p.name AS product_name,
    v.name AS vendor_name,
    v.vendor_code,
    cs.certification_status,
    cb.acb_code,
    cb.name AS certification_body_name,
    cb.website AS certification_body_website
   FROM openchpl.certified_product cp
     JOIN openchpl.certification_edition ce ON cp.certification_edition_id = ce.certification_edition_id
     JOIN ( SELECT cse.certification_status_id,
            cse.certified_product_id,
            cse.event_date AS last_certification_status_change
           FROM openchpl.certification_status_event cse
             JOIN ( SELECT certification_status_event.certified_product_id,
                    max(certification_status_event.event_date) AS event_date
                   FROM openchpl.certification_status_event
                  WHERE certification_status_event.deleted <> true
                  GROUP BY certification_status_event.certified_product_id) cseinner ON cse.certified_product_id = cseinner.certified_product_id AND cse.event_date = cseinner.event_date
          WHERE cse.deleted <> true) max_cse ON max_cse.certified_product_id = cp.certified_product_id
     JOIN openchpl.certification_status cs ON cs.certification_status_id = max_cse.certification_status_id
     JOIN openchpl.product_version pv ON cp.product_version_id = pv.product_version_id
     JOIN openchpl.product p ON pv.product_id = p.product_id
     JOIN openchpl.vendor v ON p.vendor_id = v.vendor_id
     JOIN openchpl.certification_body cb ON cp.certification_body_id = cb.certification_body_id
	 LEFT OUTER JOIN ( SELECT muu.meaningful_use_users,
            muu.certified_product_id,
            muu.meaningful_use_users_date AS meaningful_use_users_date
           FROM openchpl.meaningful_use_user muu
             JOIN ( SELECT meaningful_use_user.certified_product_id,
                    max(meaningful_use_user.meaningful_use_users_date) AS meaningful_use_users_date
                   FROM openchpl.meaningful_use_user
                  WHERE meaningful_use_user.deleted <> true
                  GROUP BY meaningful_use_user.certified_product_id) muuInner ON muu.certified_product_id = muuInner.certified_product_id AND muu.meaningful_use_users_date = muuInner.meaningful_use_users_date
          WHERE muu.deleted <> true) muuResult ON muuResult.certified_product_id = cp.certified_product_id;