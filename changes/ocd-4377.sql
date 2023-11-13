CREATE OR REPLACE FUNCTION "openchpl".column_exists (ptable text, pcolumn text, pschema text DEFAULT 'public')
    RETURNS boolean
    LANGUAGE sql
    STABLE STRICT
    AS $BODY$
    -- does the requested table.column exist in schema?
    SELECT
        EXISTS (
            SELECT
                NULL
            FROM
                information_schema.columns
            WHERE
                table_name = ptable
                AND column_name = pcolumn
                AND table_schema = pschema);
$BODY$;


CREATE OR REPLACE FUNCTION openchpl.last_modified_user_constraint() RETURNS trigger LANGUAGE plpgsql
AS $function$
BEGIN
	IF NEW.last_modified_user IS NULL AND NEW.last_modified_sso_user IS NULL THEN
		RAISE EXCEPTION 'Column last_modified_user or last_modified_sso_user requires a value.';
	ELSIF  NEW.last_modified_user IS NOT NULL AND NEW.last_modified_sso_user IS NOT NULL THEN
		RAISE EXCEPTION 'Only one of the columns [last_modified_user , last_modified_sso_user] can have a value.';
	END IF;
	RETURN NEW;
END;
$function$;


DO $$
DECLARE
    row record;
    cmd text;
    table_name text;
BEGIN
	FOR row IN SELECT schemaname, tablename FROM pg_tables WHERE schemaname = 'openchpl' ORDER BY tablename LOOP

        	cmd := format('ALTER TABLE %I.%I ADD COLUMN IF NOT EXISTS last_modified_sso_user uuid;', row.schemaname, row.tablename);
	        RAISE NOTICE '%', cmd;
	        EXECUTE cmd;

		IF openchpl.column_exists (row.tablename, 'last_modified_user', row.schemaname) THEN
			cmd :=  format('ALTER TABLE %I.%I ALTER COLUMN last_modified_user DROP NOT NULL;', row.schemaname, row.tablename);
			RAISE NOTICE '%', cmd;
			EXECUTE cmd;
		END IF;

		cmd := format('DROP TRIGGER IF EXISTS %s_last_modified_user_constraint on %I.%I;', row.tablename, row.schemaname, row.tablename);
		RAISE NOTICE '%', cmd;
		EXECUTE cmd;

		cmd := format('CREATE CONSTRAINT TRIGGER %s_last_modified_user_constraint AFTER INSERT OR UPDATE ON %I.%I DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();', row.tablename, row.schemaname, row.tablename);
		RAISE NOTICE '%', cmd;
        	EXECUTE cmd;
    	END LOOP;
END
$$ LANGUAGE plpgsql;


DROP FUNCTION openchpl.column_exists;
