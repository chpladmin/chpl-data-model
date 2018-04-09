--
--OCD-1897 Cleanup
--  * removing old ATL column from certified_product table
alter table openchpl.certified_product
drop column if exists testing_lab_id;
