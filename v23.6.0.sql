-- Deployment file for version 23.6.0
--     as of 2023-05-15
-- ./changes/ocd-4197.sql
-- These questionable activity trigger types are no longer being checked.
-- Delete all of their existing data as data cleanup.

-- removes 4270 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria Added');

-- removed 0 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measures Successfully Tested for 170.315 (g)(1) Added');

-- removes 0 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Measures Successfully Tested for 170.315 (g)(2) Added');

-- removes 115 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing');

-- removes 3 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for new listing');

-- removes 115 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing');

-- removes 0 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'ICS added when Certification Criteria 170.315(b)(3) is on a current listing');

-- removes 411 activities
UPDATE openchpl.questionable_activity_listing
SET deleted = true
WHERE questionable_activity_trigger_id = 
	(SELECT id FROM openchpl.questionable_activity_trigger WHERE name = 'G1/G2 Added');
	

-- Remove the trigger types listed above
UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Certification Criteria Added';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Measures Successfully Tested for 170.315 (g)(1) Added';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Measures Successfully Tested for 170.315 (g)(2) Added';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for new listing';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'ICS added when Certification Criteria 170.315(b)(3) is on a current listing';

UPDATE openchpl.questionable_activity_trigger 
SET deleted = true
WHERE name = 'G1/G2 Added';


-- There is no questionable activity for this trigger type and it already was not being checked
UPDATE openchpl.questionable_activity_trigger
SET deleted = TRUE
WHERE name = 'Measures Successfully Tested for 170.315 (g)(1) Removed';

UPDATE openchpl.questionable_activity_trigger
SET deleted = TRUE
WHERE name = 'Measures Successfully Tested for 170.315 (g)(2) Removed';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.6.0', '2023-05-15', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
