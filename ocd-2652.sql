UPDATE openchpl.test_tool
SET retired = true
WHERE "name" = 'CDC''s NHSN CDA Validator';

INSERT INTO openchpl.test_tool 
("name", last_modified_user)
SELECT 'NHCS IG Release 1 Validator', -1
WHERE NOT EXISTS
  (SELECT 1 FROM openchpl.test_tool where "name" = 'NHCS IG Release 1 Validator');

INSERT INTO openchpl.test_tool 
("name", last_modified_user)
SELECT 'NHCS IG Release 1.2 Validator', -1
WHERE NOT EXISTS
  (SELECT 1 FROM openchpl.test_tool where "name" = 'NHCS IG Release 1.2 Validator');