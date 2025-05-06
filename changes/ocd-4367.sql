INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_sso_user)
SELECT 'Created ICS Listing With Withdrawn Parent', 'Listing', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Created ICS Listing With Withdrawn Parent');
