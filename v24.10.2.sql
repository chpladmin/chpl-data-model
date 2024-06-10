-- Deployment file for version 24.10.2
--     as of 2024-06-10
-- ./changes/ocd-4584.sql
-- Add some indexes so deleting 50,000 things isn't horribly slow
CREATE INDEX IF NOT EXISTS qacr_activity_id_index ON openchpl.questionable_activity_certification_result (activity_id);
CREATE INDEX IF NOT EXISTS qad_activity_id_index ON openchpl.questionable_activity_developer (activity_id);
CREATE INDEX IF NOT EXISTS qap_activity_id_index ON openchpl.questionable_activity_product (activity_id);
CREATE INDEX IF NOT EXISTS qav_activity_id_index ON openchpl.questionable_activity_version (activity_id);
CREATE INDEX IF NOT EXISTS qal_activity_id_index ON openchpl.questionable_activity_listing (activity_id);
CREATE INDEX IF NOT EXISTS concept_index ON openchpl.activity (activity_object_concept_id);

-- Get rid of all CERTIFICATION_ID activity 

DELETE FROM openchpl.activity
WHERE activity_object_concept_id = 13;

DELETE FROM openchpl.activity_concept
WHERE concept = 'CERTIFICATION_ID';

-- Have never used these in the history of the CHPL, might as well clean them up

DELETE FROM openchpl.activity_concept
WHERE concept = 'CERTIFICATION';

DELETE FROM openchpl.activity_concept
WHERE concept = 'CQM';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.10.2', '2024-06-10', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
