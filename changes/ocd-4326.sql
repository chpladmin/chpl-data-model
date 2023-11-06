-- add to questionable activity trigger

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Attested to Removed Certification Criteria', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Attested to Removed Certification Criteria'
);

