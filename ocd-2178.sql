INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT '2014 Listing Edited', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = '2014 Listing Edited' );
