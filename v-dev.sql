-- OCD-2392 - add whitelisting to api keys

ALTER TABLE openchpl.api_key DROP COLUMN IF EXISTS whitelisted;
ALTER TABLE openchpl.api_key ADD COLUMN whitelisted boolean DEFAULT false;
UPDATE openchpl.api_key SET whitelisted = true WHERE api_key_id = 1;

