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

