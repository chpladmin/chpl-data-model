-- add to questionable activity trigger

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Attested to Removed Certification Criteria', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Attested to Removed Certification Criteria'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Removed Test Tool Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Removed Test Tool Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Removed Functionality Tested Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Removed Functionality Tested Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Removed Standard Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Removed Standard Added'
);
