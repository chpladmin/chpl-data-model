INSERT INTO openchpl.activity_concept (concept, last_modified_user)
SELECT 'SVAP', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.activity_concept 
	WHERE concept = 'SVAP'
);

INSERT INTO openchpl.activity_concept (concept, last_modified_user)
SELECT 'FUNCTIONALITY_TESTED', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.activity_concept 
	WHERE concept = 'FUNCTIONALITY_TESTED'
);

INSERT INTO openchpl.activity_concept (concept, last_modified_user)
SELECT 'STANDARD', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.activity_concept 
	WHERE concept = 'STANDARD'
);

-- "Normalize" the string fields in the three attributes where we want to record activity.
-- Sometimes the string fields are NULL and sometimes they are "".
-- To avoid recording false activity, we need to settle on an empty field always being one or the other. I chose NULL.

UPDATE openchpl.functionality_tested
SET name = NULL
WHERE name = '';

UPDATE openchpl.functionality_tested
SET additional_information = NULL
WHERE additional_information = '';

UPDATE openchpl.standard
SET additional_information = NULL
WHERE additional_information = '';

UPDATE openchpl.standard
SET group_name = NULL
WHERE group_name = '';


