-- Deployment file for version 27.3.3
--     as of 2025-08-18
-- ./changes/ocd-4805.sql
ALTER TABLE openchpl.change_request_listing_url DROP COLUMN IF EXISTS change_request_listing_url_type_id;
ALTER TABLE openchpl.change_request_listing_url ADD COLUMN IF NOT EXISTS check_date date;

DROP TABLE IF EXISTS openchpl.change_request_listing_url_type;

UPDATE openchpl.change_request_type
SET name = 'Service Base URL List Change Request'
WHERE name = 'Listing URL Change Request';

INSERT INTO openchpl.change_request_type (name, last_modified_sso_user)
SELECT 'RWT Plans URL Change Request', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_type WHERE name = 'RWT Plans URL Change Request');

INSERT INTO openchpl.change_request_type (name, last_modified_sso_user)
SELECT 'RWT Results URL Change Request', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_type WHERE name = 'RWT Results URL Change Request');

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('27.3.3', '2025-08-18', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
