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
a.certification_status_id,
a.deleted,
a.product_code,
a.version_code,
a.ics_code,
a.additional_software_code,
a.certified_date_code,
a.visible_on_chpl,
a.terms_of_use_url,
a.api_documentation_url,
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

LEFT JOIN (SELECT vendor_id, name as "vendor_name", vendor_code, website as "vendor_website" from openchpl.vendor) h on g.vendor_id = h.vendor_id

LEFT JOIN (SELECT vendor_id, certification_body_id, transparency_attestation from openchpl.acb_vendor_map) p on h.vendor_id = p.vendor_id and a.certification_body_id = p.certification_body_id

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
