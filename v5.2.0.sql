--create new table
CREATE TABLE IF NOT EXISTS openchpl.vendor_status(
	vendor_status_id bigserial not null,
	name varchar(100) not null,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT vendor_status_pk PRIMARY KEY (vendor_status_id),
	CONSTRAINT vendor_status_unique_key UNIQUE (name)
);

GRANT ALL ON TABLE openchpl.vendor_status TO openchpl;

--insert data if it's not already there
INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Active', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Active'
    );

INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Suspended by ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Suspended by ONC'
    );

INSERT INTO openchpl.vendor_status
    (name, last_modified_user)
SELECT 'Under certification ban by ONC', -1
WHERE
    NOT EXISTS (
        SELECT name FROM openchpl.vendor_status WHERE name = 'Under certification ban by ONC'
    );

--drop the views using this column so we are allowed to drop the column
DROP VIEW IF EXISTS openchpl.certified_product_details;
	
--drop and add the column
ALTER TABLE openchpl.vendor
DROP COLUMN IF EXISTS vendor_status_id;
ALTER TABLE openchpl.vendor
ADD COLUMN vendor_status_id bigint DEFAULT 1; 

--drop and add the constraints
ALTER TABLE openchpl.vendor DROP CONSTRAINT IF EXISTS vendor_status_fk;
ALTER TABLE openchpl.vendor
ADD CONSTRAINT vendor_status_fk FOREIGN KEY (vendor_status_id)
      REFERENCES openchpl.vendor_status (vendor_status_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT;
	  
-- add audit triggers
DROP TRIGGER IF EXISTS vendor_status_audit on openchpl.vendor_status;
CREATE TRIGGER vendor_status_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS vendor_status_timestamp on openchpl.vendor_status;
CREATE TRIGGER vendor_status_timestamp BEFORE UPDATE on openchpl.vendor_status FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--update the certified_product_details view to include vendor status info
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
	
GRANT ALL ON TABLE openchpl.certified_product_details TO openchpl;-- Add ONC Staff role to user_permission table to support API ROLE_ONC_STAFF
INSERT INTO openchpl.user_permission(user_permission_id, "name", description, authority, last_modified_user)
    SELECT 7, 'ONC_STAFF' ,'This permission gives a user access to the CMS Download file and report navigation section. It denies editing of Users/Products/CPs/ACBs/etc. No user invitation ability.', 'ROLE_ONC_STAFF' , -1
	WHERE NOT EXISTS 
	(SELECT user_permission_id 
	FROM openchpl.user_permission 
	WHERE user_permission_id = 7);
	UPDATE openchpl.test_tool
SET name = 'HL7 v2 Immunization Information System (IIS) Reporting Validation Tool'
WHERE name = 'HL7 v2 Immunization Information System (IIS) Reporting Validation';
