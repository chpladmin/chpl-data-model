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


