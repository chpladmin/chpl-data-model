INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Product Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'Product Report');

INSERT INTO openchpl.filter_type (name, last_modified_user)
SELECT 'Version Report', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.filter_type
	 WHERE name = 'Version Report');
