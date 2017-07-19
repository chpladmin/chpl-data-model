--------------------
-- fix size mismatches between pending and regular tables
--------------------

--cannot alter columns that are used in views; first drop related views
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.developers_with_attestations;
DROP VIEW IF EXISTS openchpl.certified_product_details;
DROP VIEW IF EXISTS openchpl.ehr_certification_ids_and_products;

--was 250; pending and spec say 300
ALTER TABLE openchpl.testing_lab
ALTER COLUMN name TYPE varchar(300);

--was 100; pending and spec say 250
ALTER TABLE openchpl.address
ALTER COLUMN state TYPE varchar(250);

--was 100; pending and spec say 25
--we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'Addresses with zipcode > 25 characters in length that will be truncated: ';
END; 
$$;
SELECT * FROM openchpl.address WHERE char_length(zipcode) > 25;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.address
SET zipcode = substring(zipcode from 0 for 26)
WHERE char_length(zipcode) > 25;
--shorten the  column
ALTER TABLE openchpl.address
ALTER COLUMN zipcode TYPE varchar(25);

--was 50; pending and spec say 100
ALTER TABLE openchpl.contact
ALTER COLUMN phone_number TYPE varchar(100);

-- was 200; pending and spec say 255
ALTER TABLE openchpl.qms_standard
ALTER COLUMN name TYPE varchar(255);

-- was 300; pending and spec say 500
ALTER TABLE openchpl.accessibility_standard
ALTER COLUMN name TYPE varchar(500);

-- was 100; pending and spec say 50
-- we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'Test Tools with a version > 50 characters in length that will be truncated: ';
END; 
$$;
SELECT * FROM openchpl.certification_result_test_tool WHERE char_length(version) > 50;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.certification_result_test_tool
SET version = substring(version from 0 for 51)
WHERE char_length(version) > 50;
--shorten the column
ALTER TABLE openchpl.certification_result_test_tool
ALTER COLUMN version TYPE varchar(50);

-- was 500; pending and spec say 200
-- we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'UCD Processs with a name > 200 characters in length that will be truncated: ';
END; 
$$;
SELECT * FROM openchpl.ucd_process WHERE char_length(name) > 200;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.ucd_process
SET name = substring(name from 0 for 201)
WHERE char_length(name) > 200;

ALTER TABLE openchpl.ucd_process
ALTER COLUMN name TYPE varchar(200);

-- was 16; spec says 4
-- we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'Confirmed listings with product code that will be shortened: ';
END; 
$$;
SELECT certified_product_id, product_code 
FROM openchpl.certified_product WHERE char_length(product_code) > 4;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.certified_product
SET product_code = substring(product_code from 0 for 5)
WHERE char_length(product_code) > 4;

ALTER TABLE openchpl.certified_product
ALTER COLUMN product_code TYPE varchar(4);

-- we are adding a constraint to this column, first check if any listings won't meet it
DO $$
BEGIN
	raise notice 'Confirmed listings with product code that will be changed to match ^[a-zA-Z0-9_]{4}\Z: ';
END; 
$$;
SELECT certified_product_id, product_code 
FROM openchpl.certified_product
WHERE product_code !~ $$^[a-zA-Z0-9_]{4}\Z$$;
--change those invalid product codes to underscores
UPDATE openchpl.certified_product
SET product_code = '____'
WHERE product_code !~ $$^[a-zA-Z0-9_]{4}\Z$$;

ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS product_code_regexp;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT product_code_regexp CHECK (product_code ~ $$^[a-zA-Z0-9_]{4}\Z$$);

-- was 16; spec says 4
-- we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'Confirmed listings with version code that will be shortened: ';
END; 
$$;
SELECT certified_product_id, version_code 
FROM openchpl.certified_product 
WHERE char_length(version_code) > 2;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.certified_product
SET version_code = substring(version_code from 0 for 3)
WHERE char_length(version_code) > 2;

ALTER TABLE openchpl.certified_product
ALTER COLUMN version_code TYPE varchar(2);

-- we are adding a constraint to this column, first check if any listings won't meet it
DO $$
BEGIN
	raise notice 'Confirmed listings with version code that will be changed to match ^[a-zA-Z0-9_]{2}\Z: ';
END; 
$$;
SELECT certified_product_id, version_code 
FROM openchpl.certified_product
WHERE version_code !~ $$^[a-zA-Z0-9_]{2}\Z$$;
--change those invalid version codes to underscores
UPDATE openchpl.certified_product
SET version_code = '__'
WHERE version_code !~ $$^[a-zA-Z0-9_]{2}\Z$$;

ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS version_code_regexp;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT version_code_regexp CHECK (version_code ~ $$^[a-zA-Z0-9_]{2}\Z$$);

-- was integer; spec says varchar(1)
-- report on any that aren't one char in length
DO $$
DECLARE
	ics_type varchar;
BEGIN
	raise notice 'Confirmed listings with ics code that will be shortened: ';
	
	SELECT * INTO ics_type FROM 
		(SELECT data_type from information_schema.columns
		WHERE table_schema = 'openchpl'
		AND table_name = 'certified_product'
		AND column_name = 'ics_code') subquery;
	
	IF ics_type = 'integer' THEN
		EXECUTE 'SELECT certified_product_id, ics_code FROM openchpl.certified_product WHERE ics_code < 0 OR ics_code > 9';
		--truncate the records that were too big so the alter table can complete
		EXECUTE 'UPDATE openchpl.certified_product SET ics_code = 0 WHERE ics_code < 0 OR ics_code > 9';
	END IF;
END; 
$$;

ALTER TABLE openchpl.certified_product
ALTER COLUMN ics_code TYPE varchar(1);

-- we are adding a constraint to this column, first check if any listings won't meet it
DO $$
BEGIN
	raise notice 'Confirmed listings with ics code that will be changed to match ^[0-9]{1}\Z: ';
END; 
$$;
SELECT certified_product_id, ics_code 
FROM openchpl.certified_product
WHERE ics_code !~ $$^[0-9]{1}\Z$$;
--change those invalid ics codes to 0s
UPDATE openchpl.certified_product
SET ics_code = '0'
WHERE ics_code !~ $$^[0-9]{1}\Z$$;

ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS ics_code_regexp;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT ics_code_regexp CHECK (ics_code ~ $$^[0-9]{1}\Z$$);


-- was 16; spec says varchar(1)
-- report on any that aren't one char in length
DO $$
BEGIN
	raise notice 'Confirmed listings with additional software code that will be shortened: ';
END; 
$$;
SELECT certified_product_id, additional_software_code 
FROM openchpl.certified_product 
WHERE char_length(additional_software_code) > 1;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.certified_product
SET additional_software_code = substring(additional_software_code from 0 for 2)
WHERE char_length(additional_software_code) > 1;

ALTER TABLE openchpl.certified_product
ALTER COLUMN additional_software_code TYPE varchar(1);

-- we are adding a constraint to this column, first check if any listings won't meet it
DO $$
BEGIN
	raise notice 'Confirmed listings with additional software code that will be changed to match ^0|1\Z: ';
END; 
$$;
SELECT certified_product_id, additional_software_code 
FROM openchpl.certified_product
WHERE additional_software_code !~ $$^0|1\Z$$;
--change those invalid additional software codes to 0s
UPDATE openchpl.certified_product updatedCp
SET additional_software_code = 
	(
		SELECT 
			CASE 
			WHEN count(addSoft) > 0 THEN '1'
			WHEN count(addSoft) = 0 THEN '0'
			END
		FROM openchpl.certified_product selectedCp
		JOIN openchpl.certification_result cert ON cert.certified_product_id = selectedCp.certified_product_id
		JOIN openchpl.certification_result_additional_software addSoft ON addSoft.certification_result_id = cert.certification_result_id
		WHERE selectedCp.certified_product_id = updatedCp.certified_product_id
	)
WHERE updatedCp.additional_software_code !~ $$^0|1\Z$$;

ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS additional_software_code_regexp;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT additional_software_code_regexp CHECK (additional_software_code ~ $$^0|1\Z$$);


-- was 16; spec says 4
-- we are shortening this column, first find any records that are too long and report on them
DO $$
BEGIN
	raise notice 'Confirmed listings with certified date code that will be shortened: ';
END; 
$$;
SELECT certified_product_id, certified_date_code 
FROM openchpl.certified_product 
WHERE char_length(certified_date_code) > 6;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.certified_product
SET certified_date_code = substring(certified_date_code from 0 for 7)
WHERE char_length(certified_date_code) > 6;

ALTER TABLE openchpl.certified_product
ALTER COLUMN certified_date_code TYPE varchar(6);

-- we are adding a constraint to this column, first check if any listings won't meet it
DO $$
BEGIN
	raise notice 'Confirmed listings with certified date code that will be changed to match ^[0-9]{6}\Z: ';
END; 
$$;
SELECT certified_product_id, certified_date_code 
FROM openchpl.certified_product
WHERE certified_date_code !~ $$^[0-9]{6}\Z$$;
--change those invalid certrified date codes to 0s
UPDATE openchpl.certified_product
SET certified_date_code = '000000'
WHERE certified_date_code !~ $$^[0-9]{6}\Z$$;

ALTER TABLE openchpl.certified_product DROP CONSTRAINT IF EXISTS certified_date_code_regexp;
ALTER TABLE openchpl.certified_product ADD CONSTRAINT certified_date_code_regexp CHECK (certified_date_code ~ $$^[0-9]{6}\Z$$);
	
-- Note: The user calling this script must be in the same directory as v-next. 
-- recreate all the views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql