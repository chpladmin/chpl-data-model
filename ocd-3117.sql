INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Complaints', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.filter_type
    WHERE name = 'Complaints' );
