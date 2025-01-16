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
AND ucd_process_details = '';