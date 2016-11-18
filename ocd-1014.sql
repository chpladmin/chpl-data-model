CREATE OR REPLACE FUNCTION add_column(schema_name TEXT, table_name TEXT, 
column_name TEXT, data_type TEXT)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
  _tmp text;
BEGIN

  EXECUTE format('SELECT COLUMN_NAME FROM information_schema.columns WHERE 
    table_schema=%L
    AND table_name=%L
    AND column_name=%L', schema_name, table_name, column_name)
  INTO _tmp;

  IF _tmp IS NOT NULL THEN
    RAISE NOTICE 'Column % already exists in %.%', column_name, schema_name, table_name;
    RETURN FALSE;
  END IF;

  EXECUTE format('ALTER TABLE %I.%I ADD COLUMN %I %s;', schema_name, table_name, column_name, data_type);

  RAISE NOTICE 'Column % added to %.%', column_name, schema_name, table_name;

  RETURN TRUE;
END;
$BODY$
LANGUAGE 'plpgsql';

SELECT add_column('openchpl', 'certified_product', 'meaningful_use_users', 'BIGINT');

DROP FUNCTION IF EXISTS add_column(text, text, text, text);

DROP VIEW IF EXISTS openchpl.certified_product_details;
CREATE OR REPLACE VIEW openchpl.certified_product_details AS 
	SELECT a.certified_product_id,
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
	     LEFT JOIN ( SELECT vendor_status.vendor_status_id,
		    vendor_status.name AS vendor_status_name
		   FROM openchpl.vendor_status) v ON h.vendor_status_id = v.vendor_status_id
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
			    corrective_action_plan.creation_date,
			    corrective_action_plan.last_modified_date,
			    corrective_action_plan.last_modified_user,
			    corrective_action_plan.deleted,
			    corrective_action_plan.summary,
			    corrective_action_plan.developer_explanation,
			    corrective_action_plan.resolution
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
			    corrective_action_plan.creation_date,
			    corrective_action_plan.last_modified_date,
			    corrective_action_plan.last_modified_user,
			    corrective_action_plan.deleted,
			    corrective_action_plan.summary,
			    corrective_action_plan.developer_explanation,
			    corrective_action_plan.resolution
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
			    corrective_action_plan.creation_date,
			    corrective_action_plan.last_modified_date,
			    corrective_action_plan.last_modified_user,
			    corrective_action_plan.deleted,
			    corrective_action_plan.summary,
			    corrective_action_plan.developer_explanation,
			    corrective_action_plan.resolution
			   FROM openchpl.corrective_action_plan
			  WHERE corrective_action_plan.deleted <> true AND corrective_action_plan.surveillance_end IS NOT NULL AND corrective_action_plan.surveillance_end <= now()) n_1
		  GROUP BY n_1.certified_product_id) s ON a.certified_product_id = s.certified_product_id
	     LEFT JOIN ( SELECT testing_lab.testing_lab_id,
		    testing_lab.name AS testing_lab_name,
		    testing_lab.testing_lab_code
		   FROM openchpl.testing_lab) q ON a.testing_lab_id = q.testing_lab_id;

