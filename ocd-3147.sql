INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added with ICS for current listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added without ICS for current listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for current listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added without ICS for new listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for new listing');


