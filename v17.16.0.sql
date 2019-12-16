-- Deployment file for version 17.16.0
--     as of 2019-12-16
-- ocd-3186.sql

-- This will delete all duplicate status records based on listing, status and date
update openchpl.certification_status_event a
set deleted = true
from openchpl.certification_status_event b
where a.certification_status_event_id > b.certification_status_event_id
and a.certified_product_id = b.certified_product_id
and a.certification_status_id = b.certification_status_id
and a.event_date = b.event_date
and a.deleted = false
and b.deleted = false;
;
-- ocd-3212.sql
update openchpl.test_tool
set retired = false
where name = 'CDC''s NHSN CDA Validator';

update openchpl.test_tool
set retired = true
where name = 'HL7 CDA National Health Care Surveys Validator';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.16.0', '2019-12-16', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
