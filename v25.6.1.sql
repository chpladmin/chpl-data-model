-- Deployment file for version 25.6.1
--     as of 2025-01-21
-- ./changes/ocd-2037.sql
update openchpl.report_metadata
set height = '2500px'
where report_key = 'CriteriaAttributes';
;
-- ./changes/ocd-4785.sql
update openchpl.url_uptime_monitor_test uumt
set deleted = true 
where uumt.passed = false 
and uumt.url_uptime_monitor_id = (
	select uum.id
	from openchpl.url_uptime_monitor uum
	where uum.url = 'https://fhir.eclinicalworks.com/ecwopendev/external/practiceList?pageId=1');
;
-- ./changes/ocd-4793.sql
UPDATE openchpl.certified_product_qms_standard
SET modification = null
WHERE deleted = false
AND modification = '';

UPDATE openchpl.certified_product_qms_standard
SET applicable_criteria = null
WHERE deleted = false
AND applicable_criteria = '';

UPDATE openchpl.certification_result
SET api_documentation = null
WHERE deleted = false
AND api_documentation = '';

UPDATE openchpl.certification_result
SET documentation_url = null
WHERE deleted = false
AND documentation_url = '';

UPDATE openchpl.certification_result
SET export_documentation = null
WHERE deleted = false
AND export_documentation = '';

UPDATE openchpl.certification_result
SET privacy_security_framework = null
WHERE deleted = false
AND privacy_security_framework = '';

UPDATE openchpl.certification_result
SET risk_management_summary_information = null
WHERE deleted = false
AND risk_management_summary_information = '';

UPDATE openchpl.certification_result
SET service_base_url_list = null
WHERE deleted = false
AND service_base_url_list = '';

UPDATE openchpl.certification_result
SET use_cases = null
WHERE deleted = false
AND use_cases = '';

UPDATE openchpl.certification_result_conformance_method
SET version = null
WHERE deleted = false
AND version = '';

UPDATE openchpl.certification_result_additional_software
SET grouping = null
WHERE deleted = false
AND grouping = '';

UPDATE openchpl.certification_result_additional_software
SET justification = null
WHERE deleted = false
AND justification = '';

UPDATE openchpl.certification_result_additional_software
SET version = null
WHERE deleted = false
AND version = '';

UPDATE openchpl.certification_result_additional_software
SET name = null
WHERE deleted = false
AND name = '';

UPDATE openchpl.certification_result_test_data
SET version = null
WHERE deleted = false
AND version = '';

UPDATE openchpl.certification_result_test_data
SET alteration = null
WHERE deleted = false
AND alteration = '';

UPDATE openchpl.certification_result_test_tool
SET version = null
WHERE deleted = false
AND version = '';

UPDATE openchpl.certification_result_ucd_process
SET ucd_process_details = null
WHERE deleted = false
AND ucd_process_details = '';;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('25.6.1', '2025-01-21', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
