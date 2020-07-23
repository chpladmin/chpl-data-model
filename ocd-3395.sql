ALTER TABLE openchpl.api_key
ADD COLUMN IF NOT EXISTS unrestricted boolean DEFAULT false;

DO $$
BEGIN
	IF EXISTS (SELECT * FROM information_schema.columns WHERE table_schema = 'openchpl' AND table_name = 'api_key' AND column_name = 'whitelisted') THEN
		EXECUTE 'update openchpl.api_key apikey1 set unrestricted = (select whitelisted from openchpl.api_key apikey2 where apikey1.api_key_id = apikey2.api_key_id)';
	END IF;
END
$$;

ALTER TABLE openchpl.api_key
ALTER COLUMN unrestricted SET NOT NULL;

ALTER TABLE openchpl.api_key
DROP COLUMN IF EXISTS whitelisted;