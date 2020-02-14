INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Export Documentation', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Export Documentation');

INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Documentation URL', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Documentation URL');

INSERT INTO openchpl.url_type
(name, last_modified_user)
SELECT 'Use Cases', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.url_type
    WHERE name = 'Use Cases');
