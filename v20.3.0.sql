-- Deployment file for version 20.3.0
--     as of 2021-08-02
-- ./changes/ocd-3622.sql
drop table if exists openchpl.pending_certification_result_optional_standard;

CREATE TABLE openchpl.pending_certification_result_optional_standard (
	pending_certification_result_optional_standard_id bigserial NOT NULL,
	pending_certification_result_id bigint not null,
	optional_standard_id bigint,
	citation text,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL,
	CONSTRAINT pending_certification_result_optional_standard_pk PRIMARY KEY (pending_certification_result_optional_standard_id),
	CONSTRAINT pending_certification_result_fk FOREIGN KEY (pending_certification_result_id)
      REFERENCES openchpl.pending_certification_result (pending_certification_result_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
      REFERENCES openchpl.optional_standard (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE TRIGGER pending_certification_result_optional_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.pending_certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER pending_certification_result_optional_standard_timestamp BEFORE UPDATE on openchpl.pending_certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
;
-- ./changes/ocd-3659.sql
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

;
-- ./changes/ocd-3708.sql
INSERT INTO openchpl.questionable_activity_trigger
(name, level, last_modified_user)
SELECT 'Real World Testing Added To Ineligible Listing', 'Listing', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.questionable_activity_trigger
    WHERE name = 'Real World Testing Added To Ineligible Listing'
);

DELETE FROM openchpl.questionable_activity_trigger
WHERE name = 'Real World Testing Added to Listing not Real World Testing Eligible';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.3.0', '2021-08-02', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
