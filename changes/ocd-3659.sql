-- drop some views that reference the meaningful use tables
DROP VIEW IF EXISTS openchpl.certified_product_search_result CASCADE;
DROP VIEW IF EXISTS openchpl.certified_product_summary CASCADE;
DROP VIEW IF EXISTS openchpl.certified_product_details CASCADE;
DROP VIEW IF EXISTS openchpl.certified_product_search CASCADE;

-- rename table
ALTER TABLE IF EXISTS openchpl.meaningful_use_user
	RENAME TO promoting_interoperability_user;

-- rename the columns with the new names we want (no rename 'if not exists' option)
DO $$
BEGIN
  IF EXISTS(SELECT *
    FROM information_schema.columns
    WHERE table_schema = 'openchpl' 
	AND table_name = 'promoting_interoperability_user' 
	AND column_name = 'meaningful_use_users')
  THEN
      ALTER TABLE "openchpl"."promoting_interoperability_user" RENAME COLUMN "meaningful_use_users" TO "user_count";
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS(SELECT *
    FROM information_schema.columns
    WHERE table_schema = 'openchpl' 
	AND table_name = 'promoting_interoperability_user' 
	AND column_name = 'meaningful_use_users_date')
  THEN
      ALTER TABLE "openchpl"."promoting_interoperability_user" RENAME COLUMN "meaningful_use_users_date" TO "user_count_date";
  END IF;
END $$;

-- make date instead of timestamp
ALTER TABLE IF EXISTS openchpl.promoting_interoperability_user
	ALTER COLUMN user_count_date TYPE date;
	
-- drop constraint with old name, add constraint with new name
ALTER TABLE IF EXISTS openchpl.promoting_interoperability_user
	DROP CONSTRAINT IF EXISTS meaningful_use_user_pk;
ALTER TABLE IF EXISTS openchpl.promoting_interoperability_user
	DROP CONSTRAINT IF EXISTS promoting_interoperability_user_pk;	
ALTER TABLE IF EXISTS openchpl.promoting_interoperability_user
	ADD CONSTRAINT promoting_interoperability_user_pk PRIMARY KEY (id);
	
-- update audit trigger names
DROP TRIGGER IF EXISTS meaningful_use_user_audit on openchpl.promoting_interoperability_user;
DROP TRIGGER IF EXISTS meaningful_use_user_timestamp on openchpl.promoting_interoperability_user;
DROP TRIGGER IF EXISTS promoting_interoperability_user_audit on openchpl.promoting_interoperability_user;
DROP TRIGGER IF EXISTS promoting_interoperability_user_timestamp on openchpl.promoting_interoperability_user;
CREATE TRIGGER promoting_interoperability_user_audit AFTER INSERT OR UPDATE OR DELETE ON openchpl.promoting_interoperability_user FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER promoting_interoperability_user_timestamp BEFORE UPDATE ON openchpl.promoting_interoperability_user FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

