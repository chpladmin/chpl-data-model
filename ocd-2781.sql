INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Product Activity Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'Product Activity Report');

INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Version Activity Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'Version Activity Report');
