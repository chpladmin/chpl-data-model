INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Real World Testing Added To Ineligible Listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Real World Testing Added To Ineligible Listing'
);

DELETE FROM openchpl.questionable_activity_trigger
WHERE name = 'Real World Testing Added to Listing not Real World Testing Eligible';
