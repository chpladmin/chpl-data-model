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
