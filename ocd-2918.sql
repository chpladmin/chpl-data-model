INSERT INTO openchpl.job_type (name, description, success_message, last_modified_user)
SELECT 'Export Quarterly Report', 'Creating an excel file based on quarterly report data.', 'Quarterly Report generation is complete', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.job_type
	 WHERE name = 'Export Quarterly Report');

INSERT INTO openchpl.job_type (name, description, success_message, last_modified_user)
SELECT 'Export Annual Report', 'Creating an excel file based on annual report data.', 'Annual Report generation is complete.', -1
WHERE NOT EXISTS 
	(SELECT *
	 FROM openchpl.job_type
	 WHERE name = 'Export Annual Report');