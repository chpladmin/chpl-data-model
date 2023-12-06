-- add to questionable activity trigger

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Uploaded After Certification Date', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Uploaded After Certification Date'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Attested to Removed Certification Criteria', 'Listing', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Attested to Removed Certification Criteria'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Test Tool Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Test Tool Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Functionality Tested Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Functionality Tested Added'
);

INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Expired Standard Added', 'Certification Criteria', -1
WHERE
NOT EXISTS (
	SELECT name FROM openchpl.questionable_activity_trigger WHERE name = 'Expired Standard Added'
);
