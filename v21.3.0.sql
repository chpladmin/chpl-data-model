-- Deployment file for version 21.3.0
--     as of 2022-11-28
-- ./changes/ocd-3793.sql
alter table openchpl.certification_criterion_attribute
add column if not exists test_data boolean default false;

update openchpl.certification_criterion_attribute
set test_data = true
where criterion_id in
(61,63, 64, 65, 66, 67,69, 70, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
90, 91, 92, 93, 103, 104, 106, 107, 108, 109, 110, 111, 113, 114, 117, 118, 119, 16,
165, 17, 166, 18, 167, 19, 20, 21, 23, 169, 24, 170, 25, 26, 27, 172, 28, 40, 178,
43, 44, 45, 46, 49, 50, 51, 55, 180, 57, 181, 182, 59, 60, 22, 168);
;
-- ./changes/ocd-4039.sql
ALTER TABLE openchpl.ucd_process 
ALTER COLUMN name TYPE text;

ALTER TABLE openchpl.ucd_process 
ALTER COLUMN name SET NOT NULL;

DROP VIEW openchpl.certified_product_details;
DROP VIEW openchpl.certified_product_summary;

ALTER TABLE openchpl.certified_product
ALTER COLUMN sed_testing_end TYPE date;

UPDATE openchpl.certified_product
SET sed_testing_end = NULL
WHERE sed_testing_end = '1970-01-01';;
-- ./changes/ocd-4056.sql
update openchpl.deprecated_api_usage
set deleted = true
where (response_field like '%product -> productId%'
    or response_field like '%products -> productId%')
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where (response_field like '%version -> versionId%'
    or response_field like '%versions -> versionId%')
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where response_field like '%announcement -> startDate%'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where response_field like '%announcement -> endDate%'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/search/beta'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'POST'
and api_operation = '/search/beta'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/announcements/{announcementId}'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/user_activities/{id}'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/users/{id}'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/listings'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/developers'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/products'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/versions'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/acbs'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/atls'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/users'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/announcements'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/corrective-action-plans'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/pending-surveillances'
and notification_sent is null;

update openchpl.deprecated_api_usage
set deleted = true
where http_method = 'GET'
and api_operation = '/activity/metadata/beta/api-keys'
and notification_sent is null;


;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('21.3.0', '2022-11-28', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
