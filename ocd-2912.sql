INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Third  Party Organization', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Third  Party Organization');

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Government Entity', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Government Entity');

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Patient', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Patient');
 
 INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Anonymous', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Anonymous');

INSERT INTO openchpl.complaint_type (name, last_modified_user)
SELECT 'Other - [Please Describe]', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.complaint_type
	 WHERE name = 'Other - [Please Describe]');