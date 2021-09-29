INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Promoting Interoperability Updated by ONC-ACB', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Promoting Interoperability Updated by ONC-ACB'
);