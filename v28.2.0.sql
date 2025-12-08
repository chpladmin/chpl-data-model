-- Deployment file for version 28.2.0
--     as of 2025-12-08
-- ./changes/ocd-5042.sql
--
-- standards
--
ALTER TABLE openchpl.standard ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.standard
SET extension_end_day = '2026-02-28', last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402', last_modified_user = NULL
WHERE required_day = '2025-12-31';

--
-- code sets
--
ALTER TABLE openchpl.code_set ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.code_set
SET extension_end_day = '2026-02-28', last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402', last_modified_user = NULL
WHERE required_day = '2025-12-31';

--
-- functionality tested
--
ALTER TABLE openchpl.functionality_tested DROP COLUMN IF EXISTS name;
ALTER TABLE openchpl.functionality_tested DROP COLUMN IF EXISTS number;
ALTER TABLE openchpl.functionality_tested ADD COLUMN IF NOT EXISTS extension_end_day date NULL;

UPDATE openchpl.functionality_tested
SET extension_end_day = '2026-02-28', last_modified_sso_user = '6498c4f8-b0f1-70b5-55de-d84faae73402', last_modified_user = NULL
WHERE required_day = '2025-12-31';

--
-- Code sets were not previously editable, so we need to add an activity type for them
--
INSERT INTO openchpl.activity_concept (concept, last_modified_sso_user)
SELECT 'CODE_SET', 
		'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.activity_concept WHERE concept = 'CODE_SET'
);;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('28.2.0', '2025-12-08', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
