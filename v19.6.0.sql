-- Deployment file for version 19.6.0
--     as of 2020-08-18
-- ocd-3395.sql
DO $$
BEGIN
	IF EXISTS (SELECT * FROM information_schema.columns WHERE table_schema = 'openchpl' AND table_name = 'api_key' AND column_name = 'whitelisted') THEN
		EXECUTE 'ALTER TABLE openchpl.api_key RENAME COLUMN whitelisted TO unrestricted;';
	END IF;
END
$$;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.6.0', '2020-08-18', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
