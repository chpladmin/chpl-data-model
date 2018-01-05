INSERT INTO openchpl.job_type (name, description, success_message, last_modified_user, deleted)
SELECT 'Surveillance Upload', 'Uploading a file with many surveillance items.', 'Surveillance upload is complete', -1, FALSE
WHERE NOT EXISTS (
	SELECT * FROM openchpl.job_type WHERE name = 'Surveillance Upload'
);