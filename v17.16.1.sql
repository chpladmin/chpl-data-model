-- Deployment file for version 17.16.1
--     as of 2019-12-20
-- ocd-3147.sql
INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added with ICS for current listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added with ICS for current listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added without ICS for current listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for current listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Certification Criteria 170.315 (b)(3) added without ICS for new listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Certification Criteria 170.315 (b)(3) added without ICS for new listing');

INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'ICS added when Certification Criteria 170.315(b)(3) is on a current listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'ICS added when Certification Criteria 170.315(b)(3) is on a current listing');

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.16.1', '2019-12-20', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
