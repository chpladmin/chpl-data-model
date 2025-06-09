INSERT INTO openchpl.change_request_listing_url_type (name, last_modified_sso_user)
SELECT 'RWT Plans URL', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_listing_url_type WHERE name = 'RWT Plans URL');

INSERT INTO openchpl.change_request_listing_url_type (name, last_modified_sso_user)
SELECT 'RWT Results URL', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (SELECT * FROM openchpl.change_request_listing_url_type WHERE name = 'RWT Results URL');
