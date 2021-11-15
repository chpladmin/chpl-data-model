-- Deployment file for version 20.10.0
--     as of 2021-11-15
-- ./changes/ocd-3440.sql
ALTER TABLE openchpl.pending_surveillance
DROP COLUMN IF EXISTS user_permission_id CASCADE;

ALTER TABLE openchpl.surveillance
DROP COLUMN IF EXISTS user_permission_id CASCADE;

-- fix a typo from a previous ticket
UPDATE openchpl.deprecated_response_field_api 
SET api_operation = '/surveillance-report/quarterly/{quarterlyReportId}/listings/{listingId}'
WHERE api_operation = '/surveillance-reportquarterly/{quarterlyReportId}/listings/{listingId}'
AND http_method = 'PUT';
	
-- add deprecated fields
INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 5, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 5
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 9, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 9
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 10, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 10
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 11, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 11
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 12, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 12
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 13, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 13
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 14, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 14
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 15, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 15
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 16, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 16
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 17, 'pendingCertifiedProducts -> surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 17
	AND response_field = 'pendingCertifiedProducts -> surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 19, 'surveillances -> surveillance -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 19
	AND response_field = 'surveillances -> surveillance -> userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 20, 'results -> surveillances -> surveillance -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 20
	AND response_field = 'results -> surveillances -> surveillance -> userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 21, 'surveillances -> surveillance -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 21
	AND response_field = 'surveillances -> surveillance -> userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 24, 'surveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 24
	AND response_field = 'surveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 34, 'authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 34
	AND response_field = 'authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 35, 'authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 35
	AND response_field = 'authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 37, 'pendingSurveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 37
	AND response_field = 'pendingSurveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 38, 'authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 38
	AND response_field = 'authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 39, 'pendingSurveillance -> authority', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 39
	AND response_field = 'pendingSurveillance -> authority'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 45, 'results -> surveillances -> surveillance -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 45
	AND response_field = 'results -> surveillances -> surveillance -> userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 46, 'surveillances -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 46
	AND response_field = 'surveillances -> userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 47, 'userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 47
	AND response_field = 'userPermissionId'
);

INSERT INTO openchpl.deprecated_response_field 
(deprecated_api_id, response_field, removal_date, change_description, last_modified_user)
SELECT 49, 'surveillances -> userPermissionId', '2022-05-15', 'This field is deprecated and will be removed from the response data in a future release.', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.deprecated_response_field
	WHERE deprecated_api_id = 49
	AND response_field = 'surveillances -> userPermissionId'
);;
-- ./changes/ocd-3748.sql
insert into openchpl.surveillance_requirement_type
(name, last_modified_user)
select 'Real World Testing Submission', -1
where not exists
    (select *
    from openchpl.surveillance_requirement_type
    where name = 'Real World Testing Submission');

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Removed Non-Conformity added to Surveillance', 'Listing', -1
where not exists
	(select *
	from openchpl.questionable_activity_trigger
	where name = 'Removed Non-Conformity added to Surveillance'
	and level ='Listing');

insert into openchpl.questionable_activity_trigger
(name, level, last_modified_user)
select 'Removed Requirement added to Surveillance', 'Listing', -1
where not exists
	(select *
	from openchpl.questionable_activity_trigger
	where name = 'Removed Requirement added to Surveillance'
	and level ='Listing');
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('20.10.0', '2021-11-15', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
