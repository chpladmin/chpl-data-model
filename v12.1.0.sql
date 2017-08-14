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


-- remove unused 'age' column; add two columns to store user-entered values for later error messages
ALTER TABLE openchpl.pending_test_participant DROP COLUMN IF EXISTS age;
ALTER TABLE openchpl.pending_test_participant DROP COLUMN IF EXISTS user_entered_age;
ALTER TABLE openchpl.pending_test_participant DROP COLUMN IF EXISTS user_entered_education_type;

ALTER TABLE openchpl.pending_test_participant ADD COLUMN user_entered_age varchar(32);
ALTER TABLE openchpl.pending_test_participant ADD COLUMN user_entered_education_type varchar(250);

-- Note: The user calling this script must be in the same directory as v-next. 
-- recreate all the views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql

--
-- add two new report types for statistics and questionable activity
--
INSERT INTO openchpl.notification_type (name, description, requires_acb, last_modified_user)
SELECT 
   'Summary Statistics', 
   'An email with both current and historical statistics on the CHPL.',
   false, 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type 
	WHERE  name =  'Summary Statistics'
	AND description = 'An email with both current and historical statistics on the CHPL.'
);

INSERT INTO openchpl.notification_type (name, description, requires_acb, last_modified_user)
SELECT 
	'Questionable Activity', 
   'An email that is generated whenever ONC-specified user actions on the CHPL occur.', 
   false, 
   -1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type 
	WHERE  name = 'Questionable Activity'
	AND description = 'An email that is generated whenever ONC-specified user actions on the CHPL occur.'
);

--
-- add permissions for the new report types
--
INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
	SELECT
		(SELECT id FROM openchpl.notification_type WHERE name = 'Summary Statistics'),
		-2,
		-1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type_permission 
	WHERE  notification_type_id = (SELECT id FROM openchpl.notification_type WHERE name = 'Summary Statistics')
	AND permission_id = -2
);

INSERT INTO openchpl.notification_type_permission (notification_type_id, permission_id, last_modified_user)
	SELECT
		(SELECT id FROM openchpl.notification_type WHERE name = 'Questionable Activity'),
		-2,
		-1
WHERE NOT EXISTS (
    SELECT * 
	FROM openchpl.notification_type_permission 
	WHERE  notification_type_id = (SELECT id FROM openchpl.notification_type WHERE name = 'Questionable Activity')
	AND permission_id = -2
);