DO $$
BEGIN
	IF EXISTS (SELECT * FROM information_schema.columns WHERE table_schema = 'openchpl' AND table_name = 'api_key' AND column_name = 'whitelisted') THEN
		EXECUTE 'ALTER TABLE openchpl.api_key RENAME COLUMN whitelisted TO unrestricted;';
	END IF;
END
$$;
