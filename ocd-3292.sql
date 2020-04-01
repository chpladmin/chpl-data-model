INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria added for new listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria added for new listing');
    
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria added for existing listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria added for existing listing');

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Old version of Certification Criteria changed to ICS', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Old version of Certification Criteria changed to ICS');
