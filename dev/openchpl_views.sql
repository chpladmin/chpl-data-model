CREATE OR REPLACE VIEW openchpl.certification_result_details AS

SELECT
    a.certification_result_id,
    a.certified_product_id,
    a.certification_criterion_id,
    a.success,
    a.deleted,
    a.gap,
    a.sed,
    a.g1_success,
    a.g2_success,
    a.api_documentation,
    a.privacy_security_framework,
    b.number,
    b.title,
    COALESCE(d.count_additional_software, 0) as "count_additional_software"
FROM openchpl.certification_result a

    LEFT JOIN (SELECT certification_criterion_id, number, title FROM openchpl.certification_criterion) b
	ON a.certification_criterion_id = b.certification_criterion_id
    LEFT JOIN (SELECT certification_result_id, count(*) as "count_additional_software"
	FROM
		(SELECT * FROM openchpl.certification_result_additional_software WHERE deleted <> true) c GROUP BY certification_result_id) d
	ON a.certification_result_id = d.certification_result_id;

-- ALTER VIEW openchpl.certification_result_details OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.cqm_result_details AS

SELECT
    a.cqm_result_id,
    a.certified_product_id,
    a.success,
    a.cqm_criterion_id,
    a.deleted,
    b.number,
    b.cms_id,
    b.title,
    b.description,
    b.cqm_domain,
    b.nqf_number,
    b.cqm_criterion_type_id,
    c.cqm_version_id,
    c.version,
    COALESCE(b.cms_id, b.nqf_number) as cqm_id
FROM openchpl.cqm_result a
    LEFT JOIN openchpl.cqm_criterion b ON a.cqm_criterion_id = b.cqm_criterion_id
    LEFT JOIN openchpl.cqm_version c ON b.cqm_version_id = c.cqm_version_id;

-- ALTER VIEW openchpl.cqm_result_details OWNER TO openchpl;

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

-- ALTER VIEW openchpl.certified_product_details OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.developer_certification_statuses AS
SELECT v.vendor_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.vendor v
    LEFT JOIN openchpl.product p ON v.vendor_id = p.vendor_id
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY v.vendor_id;

--ALTER TABLE openchpl.developer_certification_statuses OWNER TO openchpl;

CREATE OR REPLACE VIEW openchpl.product_certification_statuses AS
SELECT p.product_id,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Active'::text) AS active,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Retired'::text) AS retired,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by Developer'::text) AS withdrawn_by_developer,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Withdrawn by ONC-ACB'::text) AS withdrawn_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC-ACB'::text) AS suspended_by_acb,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Suspended by ONC'::text) AS suspended_by_onc,
    count(cp.certified_product_id) FILTER (WHERE cs.certification_status::text = 'Terminated by ONC'::text) AS terminated_by_onc
FROM openchpl.product p
    LEFT JOIN openchpl.product_version pv ON p.product_id = pv.product_id
    LEFT JOIN openchpl.certified_product cp ON pv.product_version_id = cp.product_version_id
    LEFT JOIN openchpl.certification_status cs ON cp.certification_status_id = cs.certification_status_id
GROUP BY p.product_id;

--ALTER TABLE openchpl.product_certification_statuses OWNER TO openchpl;

-- View: openchpl.acb_developer_transparency_mappings

-- DROP VIEW openchpl.acb_developer_transparency_mappings;

CREATE OR REPLACE VIEW openchpl.acb_developer_transparency_mappings AS
SELECT row_number() OVER () AS id,
    certification_body.certification_body_id,
    certification_body."name" AS acb_name,
    acb_vendor_map.transparency_attestation,
    vendor."name" AS developer_name,
    vendor.vendor_id
FROM openchpl.vendor
    LEFT JOIN openchpl.acb_vendor_map ON acb_vendor_map.vendor_id = vendor.vendor_id
    LEFT JOIN openchpl.certification_body ON acb_vendor_map.certification_body_id = certification_body.certification_body_id
WHERE (certification_body.deleted = false OR certification_body.deleted IS NULL) AND vendor.deleted = false;

--ALTER TABLE openchpl.acb_developer_transparency_mappings OWNER TO openchpl;

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

CREATE OR REPLACE VIEW openchpl.product_active_owner_history_map AS
SELECT  id,
	product_id,
	vendor_id,
	transfer_date,
	creation_date,
	last_modified_date,
	last_modified_user,
	deleted
FROM openchpl.product_owner_history_map
WHERE deleted = false;
