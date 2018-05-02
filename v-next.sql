--
-- OCD-2219 - Add 2 new test tools
--
INSERT INTO openchpl.test_tool(
	name, description, last_modified_user)
SELECT 'NCQA ONC Health IT Testing', null, -1 
	WHERE NOT EXISTS (SELECT 1 FROM openchpl.test_tool WHERE name = 'NCQA ONC Health IT Testing');

INSERT INTO openchpl.test_tool(
	name, description, last_modified_user)
SELECT 'HIMSS Immunization Integration Program', null, -1 
	WHERE NOT EXISTS (SELECT 1 FROM openchpl.test_tool WHERE name = 'HIMSS Immunization Integration Program');