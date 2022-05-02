-- Deployment file for version 20.15.1
--     as of 2022-05-02
-- ./changes/ocd-3855.sql
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
;
-- ./changes/ocd-3875.sql
-- Delete all deprecated endpoints that had a removal date of 4/15/22
UPDATE openchpl.deprecated_api
SET deleted = true 
WHERE removal_date = '2022-04-15'
AND api_operation != '/meaningful_use/upload';

-- deprecate /activity/users/{id}
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/users/{id}',
	NULL,
	'This endpoint is deprecated and will be removed in a future release.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/users/{id}');

-- deprecate /activity/user_activities/{id}
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/user_activities/{id}',
	NULL,
	'This endpoint is deprecated and will be removed in a future release.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/user_activities/{id}');

-- Deprecate all of the /activity/metadata/beta endpoints in favor of endpoints that don't have "beta"
INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/listings',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/listings instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/listings');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/developers',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/developers instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/developers');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/products',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/products instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/products');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/versions',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/versions instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/versions');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/acbs',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/acbs instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/acbs');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/atls',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/atls instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/atls');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/users',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/users instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/users');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/announcements',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/announcements instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/announcements');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/pending-listings',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/pending-listings instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/pending-listings');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/corrective-action-plans',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/corrective-action-plans instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/corrective-action-plans');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/pending-surveillances',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/pending-surveillances instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/pending-surveillances');

INSERT INTO openchpl.deprecated_api (http_method, api_operation, request_parameter, change_description, removal_date, last_modified_user)
SELECT 'GET',
	'/activity/metadata/beta/api-keys',
	NULL,
	'This endpoint is deprecated and will be removed in a future release. Please use /activity/metadata/api-keys instead.',
	'2022-10-18',
	-1
WHERE NOT EXISTS (SELECT * FROM openchpl.deprecated_api WHERE http_method = 'GET' and api_operation LIKE '/activity/metadata/beta/api-keys');

--
-- Remove endpoints that now have 0 deprecated response fields
--

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/certified_products/{certifiedProductId:^-?\d+$}/certification_results'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/certified_products/{year}.{testingLab}.{certBody}.{vendorCode}.{productCode}.{versionCode}.{icsCode}.{addlSoftwareCode}.{certDateCode}/certification_results'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/certified_products/{chplPrefix}-{identifier}/certification_results'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/key'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/key/confirm'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/quarterly'
AND http_method = 'PUT';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/quarterly'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/quarterly'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/quarterly/{quarterlyReportId}'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/search/beta'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/search/beta'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/collections/certified-products'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/triggers'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/triggers'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/triggers'
AND http_method = 'PUT';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/triggers/one_time'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/jobs'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/schedules/jobs'
AND http_method = 'PUT';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/developers/{developerId}/split'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/developers/merge'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/promoting-interoperability/upload'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/export/annual/{annualReportId}'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance-report/export/quarterly/{quarterlyReportId}'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/surveillance/reports/activity'
AND http_method = 'GET';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/certification_ids'
AND http_method = 'POST';

UPDATE openchpl.deprecated_response_field_api
SET deleted = true
WHERE api_operation = '/certification_ids/search'
AND http_method = 'GET';

--
-- Remove deprecated response fields where the API endpoint has remaining deprecated response fields
--

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%number%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%title%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%currentMeaningfulUseUsers%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%transparencyAttestationUrl%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%startDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%endDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%status%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%nonconformityCloseDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%dateOfDetermination%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%capStartDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%capEndDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%capMustCompleteDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%capApprovalDate%'
AND id < 312;

UPDATE openchpl.deprecated_response_field
SET deleted = true
WHERE response_field like '%frequency%'
AND deleted = false
AND id < 312;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.15.1', '2022-05-02', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
