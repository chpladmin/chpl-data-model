-- Deployment file for version 25.3.0
--     as of 2024-10-14
-- ./changes/ocd-4690.sql
-- remove unused table
DROP TABLE IF EXISTS openchpl.optional_functionality_met;

-- remove areas where there is > 1 contiguous space internal to a string
UPDATE openchpl.address SET street_line_1 = trim(regexp_replace(street_line_1, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_additional_software SET name = trim(regexp_replace(name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_additional_software SET version = trim(regexp_replace(version, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_test_data SET version = trim(regexp_replace(version, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_test_data SET alteration = trim(regexp_replace(alteration, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_test_tool SET version = trim(regexp_replace(version, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certification_result_ucd_process SET ucd_process_details = trim(regexp_replace(ucd_process_details, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certified_product SET sed_intended_user_description = trim(regexp_replace(sed_intended_user_description, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certified_product SET product_additional_software = trim(regexp_replace(product_additional_software, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certified_product_qms_standard SET modification = trim(regexp_replace(modification, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.certified_product_qms_standard SET applicable_criteria = trim(regexp_replace(applicable_criteria, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.contact SET phone_number = trim(regexp_replace(phone_number, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.contact SET title = trim(regexp_replace(title, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.contact SET full_name = trim(regexp_replace(full_name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.contact SET friendly_name = trim(regexp_replace(friendly_name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.functionality_tested SET name = trim(regexp_replace(name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.functionality_tested SET value = trim(regexp_replace(value, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.measure SET measure_name = trim(regexp_replace(measure_name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.product SET name = trim(regexp_replace(name, '\s+', ' ', 'g')) WHERE deleted = false;
UPDATE openchpl.targeted_user SET name = trim(regexp_replace(name, '\s+', ' ', 'g')) WHERE deleted = false;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.3.0', '2024-10-14', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
