-- View: openchpl.certified_product_details

 DROP VIEW openchpl.certified_product_details;

CREATE OR REPLACE VIEW openchpl.certified_product_details AS
 SELECT a.certified_product_id,
    a.certification_edition_id,
    a.creation_date,
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
    a.certification_status_id,
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
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
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
    COALESCE(k.count_certifications, 0::bigint) AS count_certifications,
    COALESCE(m.count_cqms, 0::bigint) AS count_cqms,
    COALESCE(o.count_corrective_action_plans, 0::bigint) AS count_corrective_action_plans,
    COALESCE(r.count_current_corrective_action_plans, 0::bigint) AS count_current_corrective_action_plans,
    COALESCE(s.count_closed_corrective_action_plans, 0::bigint) AS count_closed_corrective_action_plans,
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code
   FROM openchpl.certified_product a
     LEFT JOIN ( SELECT certification_edition.certification_edition_id,
            certification_edition.year
           FROM openchpl.certification_edition) b ON a.certification_edition_id = b.certification_edition_id
     LEFT JOIN ( SELECT certification_body.certification_body_id,
            certification_body.name AS certification_body_name,
            certification_body.acb_code AS certification_body_code
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
            vendor.contact_id AS vendor_contact
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
     LEFT JOIN ( SELECT certification_status.certification_status_id,
            certification_status.certification_status AS certification_status_name
           FROM openchpl.certification_status) n ON a.certification_status_id = n.certification_status_id
     LEFT JOIN ( SELECT DISTINCT ON (certification_event.certified_product_id) certification_event.certified_product_id,
            certification_event.event_date AS certification_date
           FROM openchpl.certification_event
          WHERE certification_event.event_type_id = 1) i ON a.certified_product_id = i.certified_product_id
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
           FROM ( SELECT DISTINCT ON (cqm_result_details.cqm_id, cqm_result_details.certified_product_id) cqm_result_details.cqm_result_id,
                    cqm_result_details.certified_product_id,
                    cqm_result_details.success,
                    cqm_result_details.cqm_criterion_id,
                    cqm_result_details.deleted,
                    cqm_result_details.number,
                    cqm_result_details.cms_id,
                    cqm_result_details.title,
                    cqm_result_details.description,
                    cqm_result_details.cqm_domain,
                    cqm_result_details.nqf_number,
                    cqm_result_details.cqm_criterion_type_id,
                    cqm_result_details.cqm_version_id,
                    cqm_result_details.version,
                    cqm_result_details.cqm_id
                   FROM openchpl.cqm_result_details
                  WHERE cqm_result_details.success = true AND cqm_result_details.deleted <> true) l
          GROUP BY l.certified_product_id
          ORDER BY l.certified_product_id) m ON a.certified_product_id = m.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_corrective_action_plans
           FROM ( SELECT corrective_action_plan.corrective_action_plan_id,
                    corrective_action_plan.certified_product_id,
                    corrective_action_plan.surveillance_start,
                    corrective_action_plan.surveillance_result,
                    corrective_action_plan.surveillance_end,
                    corrective_action_plan.noncompliance_determination_date,
                    corrective_action_plan.approval_date,
                    corrective_action_plan.start_date,
                    corrective_action_plan.completion_date_required,
                    corrective_action_plan.completion_date_actual,
                    corrective_action_plan.summary,
                    corrective_action_plan.developer_explanation,
                    corrective_action_plan.resolution,
                    corrective_action_plan.creation_date,
                    corrective_action_plan.last_modified_date,
                    corrective_action_plan.last_modified_user,
                    corrective_action_plan.deleted
                   FROM openchpl.corrective_action_plan
                  WHERE corrective_action_plan.deleted <> true) n_1
          GROUP BY n_1.certified_product_id) o ON a.certified_product_id = o.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_current_corrective_action_plans
           FROM ( SELECT corrective_action_plan.corrective_action_plan_id,
                    corrective_action_plan.certified_product_id,
                    corrective_action_plan.surveillance_start,
                    corrective_action_plan.surveillance_result,
                    corrective_action_plan.surveillance_end,
                    corrective_action_plan.noncompliance_determination_date,
                    corrective_action_plan.approval_date,
                    corrective_action_plan.start_date,
                    corrective_action_plan.completion_date_required,
                    corrective_action_plan.completion_date_actual,
                    corrective_action_plan.summary,
                    corrective_action_plan.developer_explanation,
                    corrective_action_plan.resolution,
                    corrective_action_plan.creation_date,
                    corrective_action_plan.last_modified_date,
                    corrective_action_plan.last_modified_user,
                    corrective_action_plan.deleted
                   FROM openchpl.corrective_action_plan
                  WHERE corrective_action_plan.deleted <> true AND corrective_action_plan.surveillance_start <= now() AND (corrective_action_plan.surveillance_end IS NULL OR corrective_action_plan.surveillance_end >= now())) n_1
          GROUP BY n_1.certified_product_id) r ON a.certified_product_id = r.certified_product_id
     LEFT JOIN ( SELECT n_1.certified_product_id,
            count(*) AS count_closed_corrective_action_plans
           FROM ( SELECT corrective_action_plan.corrective_action_plan_id,
                    corrective_action_plan.certified_product_id,
                    corrective_action_plan.surveillance_start,
                    corrective_action_plan.surveillance_result,
                    corrective_action_plan.surveillance_end,
                    corrective_action_plan.noncompliance_determination_date,
                    corrective_action_plan.approval_date,
                    corrective_action_plan.start_date,
                    corrective_action_plan.completion_date_required,
                    corrective_action_plan.completion_date_actual,
                    corrective_action_plan.summary,
                    corrective_action_plan.developer_explanation,
                    corrective_action_plan.resolution,
                    corrective_action_plan.creation_date,
                    corrective_action_plan.last_modified_date,
                    corrective_action_plan.last_modified_user,
                    corrective_action_plan.deleted
                   FROM openchpl.corrective_action_plan
                  WHERE corrective_action_plan.deleted <> true AND corrective_action_plan.surveillance_end IS NOT NULL AND corrective_action_plan.surveillance_end <= now()) n_1
          GROUP BY n_1.certified_product_id) s ON a.certified_product_id = s.certified_product_id
     LEFT JOIN ( SELECT testing_lab.testing_lab_id,
            testing_lab.name AS testing_lab_name,
            testing_lab.testing_lab_code
           FROM openchpl.testing_lab) q ON a.testing_lab_id = q.testing_lab_id;

--ALTER TABLE openchpl.certified_product_details
--  OWNER TO postgres;
--GRANT ALL ON TABLE openchpl.certified_product_details TO postgres;
GRANT ALL ON TABLE openchpl.certified_product_details TO openchpl;
update openchpl.certification_status
set certification_status = 'Withdrawn by ONC-ACB'
where certification_status = 'Terminated';

update openchpl.certification_status
set certification_status = 'Withdrawn by Developer'
where certification_status = 'Withdrawn';

update openchpl.certification_status
set certification_status = 'Suspended by ONC-ACB'
where certification_status = 'Suspended';

DROP VIEW openchpl.developer_certification_statuses;
CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS
SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb
FROM openchpl.vendor v
    LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

GRANT ALL ON TABLE openchpl.developer_certification_statuses TO openchpl;

DROP VIEW openchpl.product_certification_statuses;
CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS
SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb
FROM openchpl.product p
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

    GRANT ALL ON TABLE openchpl.product_certification_statuses TO openchpl;

DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;
CREATE OR REPLACE VIEW openchpl.ehr_certification_ids_and_products AS
SELECT
	row_number() OVER () AS id,
	ehr.ehr_certification_id_id as ehr_certification_id,
	ehr.certification_id as ehr_certification_id_text,
	ehr.creation_date as ehr_certification_id_creation_date,
	cp.certified_product_id,
	cp.chpl_product_number,
	ed.year,
	atl.testing_lab_code,
	acb.certification_body_code,
	v.vendor_code,
	cp.product_code,
    cp.version_code,
    cp.ics_code,
    cp.additional_software_code,
    cp.certified_date_code
FROM openchpl.ehr_certification_id ehr
    LEFT JOIN openchpl.ehr_certification_id_product_map prodMap
		ON ehr.ehr_certification_id_id = prodMap.ehr_certification_id_id
	LEFT JOIN openchpl.certified_product cp
		ON prodMap.certified_product_id = cp.certified_product_id
    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) ed on cp.certification_edition_id = ed.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code" FROM openchpl.certification_body) acb
		ON cp.certification_body_id = acb.certification_body_id
	LEFT JOIN (SELECT testing_lab_id, testing_lab_code from openchpl.testing_lab) atl on cp.testing_lab_id = atl.testing_lab_id
	LEFT JOIN (SELECT product_version_id, product_id from openchpl.product_version) pv on cp.product_version_id = pv.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id FROM openchpl.product) prod ON pv.product_id = prod.product_id
	LEFT JOIN (SELECT vendor_id, vendor_code from openchpl.vendor) v ON prod.vendor_id = v.vendor_id
;

GRANT ALL ON TABLE openchpl.ehr_certification_ids_and_products TO openchpl;select certified_product_id, product_code, version_code, ics_code from openchpl.certified_product
where certified_product.product_code !~ '^\w*$'
    or certified_product.version_code !~ '^\w*$'
    or certified_product.ics_code !~ '^\d*$';
DROP VIEW IF EXISTS openchpl.certified_product_details;
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
    a.certification_status_id,
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
    b.year,
    c.certification_body_name,
    c.certification_body_code,
    d.product_classification_name,
    e.practice_type_name,
    f.product_version,
    f.product_id,
    g.product_name,
    g.vendor_id,
    h.vendor_name,
    h.vendor_code,
    h.vendor_website,
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
    COALESCE(k.count_certifications, 0) as "count_certifications",
    COALESCE(m.count_cqms, 0) as "count_cqms",
    COALESCE(o.count_corrective_action_plans, 0) as "count_corrective_action_plans",
    COALESCE(r.count_current_corrective_action_plans, 0) as "count_current_corrective_action_plans",
    COALESCE(s.count_closed_corrective_action_plans, 0) as "count_closed_corrective_action_plans",
    n.certification_status_name,
    p.transparency_attestation,
    q.testing_lab_name,
    q.testing_lab_code

FROM openchpl.certified_product a

    LEFT JOIN (SELECT certification_edition_id, year FROM openchpl.certification_edition) b on a.certification_edition_id = b.certification_edition_id
    LEFT JOIN (SELECT certification_body_id, name as "certification_body_name", acb_code as "certification_body_code" FROM openchpl.certification_body) c on a.certification_body_id = c.certification_body_id
    LEFT JOIN (SELECT product_classification_type_id, name as "product_classification_name" FROM openchpl.product_classification_type) d on a.product_classification_type_id = d.product_classification_type_id
    LEFT JOIN (SELECT practice_type_id, name as "practice_type_name" from openchpl.practice_type) e on a.practice_type_id = e.practice_type_id
    LEFT JOIN (SELECT product_version_id, version as "product_version", product_id from openchpl.product_version) f on a.product_version_id = f.product_version_id
    LEFT JOIN (SELECT product_id, vendor_id, name as "product_name" FROM openchpl.product) g ON f.product_id = g.product_id
    LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website", address_id as "vendor_address", contact_id as "vendor_contact" from openchpl.vendor) h on g.vendor_id = h.vendor_id
    LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and a.certification_body_id = p.certification_body_id
    LEFT JOIN (SELECT address_id, street_line_1, street_line_2, city, state, zipcode, country from openchpl.address) t on h.vendor_address = t.address_id
    LEFT JOIN (SELECT contact_id, first_name, last_name, email, phone_number, title from openchpl.contact) u on h.vendor_contact = u.contact_id
    LEFT JOIN (SELECT certification_status_id, certification_status as "certification_status_name" FROM openchpl.certification_status) n on a.certification_status_id = n.certification_status_id
    LEFT JOIN (SELECT DISTINCT ON (certified_product_id) certified_product_id, event_date as "certification_date" FROM openchpl.certification_event WHERE event_type_id = 1) i on a.certified_product_id = i.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_certifications" FROM (SELECT * FROM openchpl.certification_result WHERE success = true AND deleted <> true) j GROUP BY certified_product_id) k ON a.certified_product_id = k.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_cqms" FROM (SELECT DISTINCT ON (cqm_id, certified_product_id) * FROM openchpl.cqm_result_details WHERE success = true AND deleted <> true) l GROUP BY certified_product_id ORDER BY certified_product_id) m ON a.certified_product_id = m.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_corrective_action_plans" FROM (SELECT * FROM openchpl.corrective_action_plan WHERE deleted <> true) n GROUP BY certified_product_id) o ON a.certified_product_id = o.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_current_corrective_action_plans" FROM
	    (SELECT * FROM openchpl.corrective_action_plan WHERE deleted <> true AND surveillance_start <= NOW() AND (surveillance_end IS NULL OR surveillance_end >= NOW())) n GROUP BY certified_product_id) r
    ON a.certified_product_id = r.certified_product_id
    LEFT JOIN (SELECT certified_product_id, count(*) as "count_closed_corrective_action_plans" FROM
	    (SELECT * FROM openchpl.corrective_action_plan WHERE deleted <> true AND surveillance_end IS NOT NULL AND surveillance_end <= NOW()) n
	GROUP BY certified_product_id) s
    ON a.certified_product_id = s.certified_product_id
    LEFT JOIN (SELECT testing_lab_id, name as "testing_lab_name", testing_lab_code from openchpl.testing_lab) q on a.testing_lab_id = q.testing_lab_id
    ;
GRANT ALL ON TABLE openchpl.certified_product_details TO openchpl;

ALTER TABLE openchpl.certified_product DROP COLUMN IF EXISTS terms_of_use_url;
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS terms_of_use_url;ALTER TABLE openchpl.test_tool add column retired boolean NOT NULL DEFAULT false;
UPDATE openchpl.test_tool set retired = true where name = 'Transport Testing Tool';
UPDATE openchpl.test_tool set retired = true where name = 'Transport Test Tool';
