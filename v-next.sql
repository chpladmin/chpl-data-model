--
-- OCD-2219 - Add 2 new test tools
--
INSERT INTO openchpl.test_tool(
	name, description, creation_date, last_modified_user, deleted, retired)
	VALUES ('NCQA ONC Health IT Testing', null, current_timestamp, -1, false, false);

INSERT INTO openchpl.test_tool(
	name, description, creation_date, last_modified_user, deleted, retired)
	VALUES ('HIMSS Immunization Integration Program', null, current_timestamp, -1, false, false);