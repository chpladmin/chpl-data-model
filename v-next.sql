--------------------
-- fix size mismatches between pending and regular tables
--------------------

--cannot alter columns that are used in views; first drop related views
DROP VIEW IF EXISTS openchpl.certified_product_search;
DROP VIEW IF EXISTS openchpl.developers_with_attestations;
DROP VIEW IF EXISTS openchpl.certified_product_details;

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
SELECT * FROM openchpl.address where char_length(zipcode) > 25;
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
SELECT * FROM openchpl.certification_result_test_tool where char_length(version) > 50;
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
SELECT * FROM openchpl.ucd_process where char_length(name) > 200;
--truncate the records that were too long so the alter table can complete
UPDATE openchpl.ucd_process
SET name = substring(name from 0 for 201)
WHERE char_length(name) > 200;

ALTER TABLE openchpl.ucd_process
ALTER COLUMN name TYPE varchar(200);

-- Note: The user calling this script must be in the same directory as v-next. 
-- recreate all the views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql