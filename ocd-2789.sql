INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'User Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'User Report');

INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'User Action Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'User Action Report');
