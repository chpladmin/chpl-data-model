-- add newly deprecated announcement endpoint
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/announcements/{announcementId}',
	NULL,
	'This endpoint is deprecated and will be removed in a future release.',
	'2022-10-15',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/announcements/{announcementId}');

insert into openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
select 'GET', '/announcements', -1 where not exists (select * from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation like '/announcements');
insert into openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
select 'POST', '/announcements', -1 where not exists (select * from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation like '/announcements');
insert into openchpl.deprecated_response_field_api (http_method, api_operation, last_modified_user)
select 'PUT', '/announcements/{announcementId}', -1 where not exists (select * from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation like '/announcements/{announcementId}');

-- add newly deprecated announcement response fields
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation like '/announcements'), 'startDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation like '/announcements') and response_field = 'startDate');
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation like '/announcements'), 'endDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'GET' and api_operation like '/announcements') and response_field = 'endDate');
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation like '/announcements'), 'startDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation like '/announcements') and response_field = 'startDate');
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation like '/announcements'), 'endDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'POST' and api_operation like '/announcements') and response_field = 'endDate');
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation like '/announcements/{announcementId}'), 'startDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use startDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation like '/announcements/{announcementId}') and response_field = 'startDate');
insert into openchpl.deprecated_response_field (deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
select (select id from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation like '/announcements/{announcementId}'), 'endDate', '2022-10-15', 'This field is deprecated and will be removed from the response data in a future release. Please use endDateTime.', -1 where not exists (select * from openchpl.deprecated_response_field where deprecated_api_id = (select id from openchpl.deprecated_response_field_api where http_method = 'PUT' and api_operation like '/announcements/{announcementId}') and response_field = 'endDate');
