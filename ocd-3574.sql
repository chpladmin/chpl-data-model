-- Add 1 new CQM

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT
 null,
 'CMS529',
 'Core Clinical Data Elements for the Hybrid Hospital-Wide Readmission (HWR) Measure with Claims and Electronic Health Record Data',
 'This logic is intended to extract electronic clinical data. This is not an electronic clinical quality measure and this logic will not produce measure results. Instead, it will produce a file containing the data that CMS will link with administrative claims to risk adjust the Hybrid HWR outcome measure. It is designed to extract the first resulted set of vital signs and basic laboratory results obtained from encounters for adult Medicare Fee-For-Service patients admitted to acute care short stay hospitals.',
 'Admissions and Readmissions to Hospitals',
 '2879',
 -1,
 cqm_version_id,
 2,
 false
FROM openchpl.cqm_version WHERE version = 'v1'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v1' WHERE cc.cms_id = 'CMS529');