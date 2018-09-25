-- OCD-2377 -  Cleanup of unused API keys
ALTER TABLE openchpl.api_key DROP COLUMN IF EXISTS last_used_date;
ALTER TABLE openchpl.api_key ADD COLUMN last_used_date timestamp without time zone DEFAULT now();
ALTER TABLE openchpl.api_key DROP COLUMN IF EXISTS delete_warning_sent_date;
ALTER TABLE openchpl.api_key ADD COLUMN delete_warning_sent_date timestamp without time zone;

CREATE OR REPLACE FUNCTION openchpl.reset_api_key_delete_warning_sent_date_func()
RETURNS TRIGGER 
AS $$
BEGIN
	IF NEW.last_used_date <> OLD.last_used_date THEN
		NEW.delete_warning_sent_date = NULL;
	END IF;
	RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS reset_api_key_delete_warning_sent_date on openchpl.api_key;
CREATE TRIGGER reset_api_key_delete_warning_sent_date BEFORE UPDATE on openchpl.api_key FOR EACH ROW EXECUTE PROCEDURE openchpl.reset_api_key_delete_warning_sent_date_func();

--re-run grants
\i dev/openchpl_grant-all.sql