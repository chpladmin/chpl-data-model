-- change ICS code: was varchar(1); spec says varchar(2)

--cannot alter columns that are used in views; first drop related views
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.developers_with_attestations;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;

--drop existing constraint
ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS ics_code_regexp;

--change column definition
ALTER TABLE openchpl.certified_product
ALTER COLUMN ics_code TYPE varchar(2);

--change those invalid ics codes to have a prepended 0
UPDATE openchpl.certified_product
SET ics_code = '0'||ics_code
WHERE ics_code ~ $$^[0-9]{1}\Z$$;

ALTER TABLE openchpl.certified_product ADD CONSTRAINT ics_code_regexp CHECK (ics_code ~ $$^[0-9]{2}\Z$$);

-- Note: The user calling this script must be in the same directory as v-next. 
-- recreate all the views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql