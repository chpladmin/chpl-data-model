DROP TABLE IF EXISTS openchpl.listing_to_listing_map;

CREATE TABLE openchpl.listing_to_listing_map(
	listing_to_listing_map_id bigserial NOT NULL,
	parent_listing_id bigint NOT NULL,
	child_listing_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT listing_to_listing_map_pk PRIMARY KEY (listing_to_listing_map_id),
	CONSTRAINT parent_listing_fk FOREIGN KEY (parent_listing_id)
		REFERENCES openchpl.certified_product(certified_product_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT child_listing_fk FOREIGN KEY (child_listing_id)
		REFERENCES openchpl.certified_product(certified_product_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TRIGGER listing_to_listing_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.listing_to_listing_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER listing_to_listing_map_timestamp BEFORE UPDATE on openchpl.listing_to_listing_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- drop views that depend on ics_code column
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;

-- make ICS CODE an integer to enforce that we only use numbers here

--this first alter is needed so the script can run mutliple times (so the second alter works on subsequent runs)
ALTER TABLE openchpl.certified_product
ALTER COLUMN ics_code TYPE varchar(16);

ALTER TABLE openchpl.certified_product
ALTER COLUMN ics_code TYPE integer
USING 
	CASE 
		WHEN ics_code IS NULL THEN NULL
		WHEN ics_code='null' THEN NULL
		WHEN ics_code = '' THEN NULL
		ELSE ics_code::integer
	END;

--
-- add two new report types for missing ICS
--
INSERT INTO openchpl.notification_type (name, description, requires_acb, last_modified_user)
SELECT 
   'ONC-ACB Weekly Missing ICS', 
   'A weekly email of listings certified by a specific ONC-ACB that are marked as having ICS but do not specify a parent.', 
   true, 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type 
	WHERE  name = 'ONC-ACB Weekly Missing ICS' 
	AND description = 'A weekly email of listings certified by a specific ONC-ACB that are marked as having ICS but do not specify a parent.'
);

INSERT INTO openchpl.notification_type (name, description, requires_acb, last_modified_user)
SELECT 
  'ONC Weekly Missing ICS', 
   'A weekly email of all listings that are marked as having ICS but do not specify a parent.', 
   true, 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type 
	WHERE  name = 'ONC Weekly Missing ICS' 
	AND description = 'A weekly email of all listings that are marked as having ICS but do not specify a parent.'
);

-- Note: The user calling this script must be in the same directory as v-next. 
--re-run view creation 
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql
