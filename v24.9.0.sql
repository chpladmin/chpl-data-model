-- Deployment file for version 24.9.0
--     as of 2024-04-29
-- ./changes/ocd-4413.sql
alter table openchpl.questionable_activity_certification_result alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_developer alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_listing alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_product alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_version alter column activity_user_id drop not null;;
-- ./changes/ocd-4495.sql
alter table openchpl.user_invitation add column if not exists group_name text;
alter table openchpl.user_invitation add column if not exists organization_id bigint;

;
-- ./changes/ocd-4538.sql
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


;
-- ./changes/ocd-4552.sql
UPDATE openchpl.certification_criterion
SET certification_companion_guide_link = 'https://www.healthit.gov/test-method/patient-demographics-and-observations'
WHERE certification_criterion_id = 5;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.9.0', '2024-04-29', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
