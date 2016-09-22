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

GRANT ALL ON TABLE openchpl.ehr_certification_ids_and_products TO openchpl;