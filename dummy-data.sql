UPDATE openchpl.svap SET deleted = true;
UPDATE openchpl.svap_criteria_map SET deleted = true;
UPDATE openchpl.certification_result_svap SET deleted = true;

INSERT INTO openchpl.svap
(regulatory_text_citation, approved_standard_version, last_modified_user)
VALUES
('170.205(h)(3); 170.205(k)(3)', 'CMS Implementation Guide for Quality Reporting Document Architecture: Category I and Category III; Hospital Quality Reporting, Eligible Clinicians and Eligible Professionals Programs; Implementation Guide for 2021', -1);

INSERT INTO openchpl.svap
(regulatory_text_citation, approved_standard_version, last_modified_user)
VALUES
('170.204(a)(1)', 'Web Content Accessibility Guidelines (WCAG) 2.1, June 05, 2018 (Level A Conformance)', -1);

INSERT INTO openchpl.svap
(regulatory_text_citation, approved_standard_version, last_modified_user)
VALUES
('170.204(a)(2)', 'Web Content Accessibility Guidelines (WCAG) 2.1, June 05, 2018 (Level AA Conformance)', -1);

INSERT INTO openchpl.svap
(regulatory_text_citation, approved_standard_version, last_modified_user)
VALUES
('170.205(s)(1)', 'HL7 CDA® R2 Implementation Guide: National Health Care Surveys (NHCS), R1 STU Release 3 - US Realm', -1);

INSERT INTO openchpl.svap
(regulatory_text_citation, approved_standard_version, replaced, last_modified_user)
VALUES
('170.205(x)(x)', 'This is the text that would be the approved standard version. TEST.', true, -1);



INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 172, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.205(h)(3); 170.205(k)(3)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 172
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.205(h)(3); 170.205(k)(3)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 178, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.204(a)(1)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 178
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.204(a)(1)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 178, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.204(a)(2)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 178
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.204(a)(2)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 49, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.205(s)(1)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 49
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.205(s)(1)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 8, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.205(x)(x)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 8
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.205(x)(x)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 8, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.205(a)(2)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 8
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.205(a)(2)' AND deleted = false));

INSERT INTO openchpl.svap_criteria_map
(svap_id, criteria_id, last_modified_user)
SELECT id, 178, -1 FROM openchpl.svap
WHERE regulatory_text_citation = '170.205(x)(x)'
AND DELETED = false
AND NOT EXISTS (
    SELECT *
    FROM openchpl.svap_criteria_map scm
    WHERE criteria_id = 178
    AND svap_id in (SELECT id FROM openchpl.svap WHERE regulatory_text_citation = '170.205(x)(x)' AND deleted = false));
