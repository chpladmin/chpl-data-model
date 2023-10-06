UPDATE openchpl.certified_product
SET svap_notice_url = NULL
WHERE svap_notice_url = '';

UPDATE openchpl.certified_product
SET report_file_location = NULL
WHERE report_file_location = '';

UPDATE openchpl.certified_product
SET mandatory_disclosures = NULL
WHERE mandatory_disclosures = '';

UPDATE openchpl.certified_product
SET sed_report_file_location = NULL
WHERE sed_report_file_location = '';

UPDATE openchpl.certified_product
SET sed_intended_user_description = NULL
WHERE sed_intended_user_description = '';

-- RWT Plans URL, RWT Results URL, ACB Certification ID have no empty ('') VALUES
