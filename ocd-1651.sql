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
ALTER TABLE openchpl.certification_result_test_tool
ALTER COLUMN version TYPE varchar(50);

-- was 500; pending and spec say 200
ALTER TABLE openchpl.ucd_process
ALTER COLUMN name TYPE varchar(200);

-- Note: The user calling this script must be in the same directory as v-next. 
-- recreate all the views
\i dev/openchpl_views.sql
--re-run grants
\i dev/openchpl_grant-all.sql