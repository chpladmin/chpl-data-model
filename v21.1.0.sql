-- Deployment file for version 21.1.0
--     as of 2022-10-03
-- ./changes/ocd-4010.sql
insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Real World Testing Plans URL or Check Date updated outside normal update period', 'Listing', -1
where not exists (
	select *
	from openchpl.questionable_activity_trigger
	where name = 'Real World Testing Plans URL or Check Date updated outside normal update period'
	and level = 'Listing'
);

insert into openchpl.questionable_activity_trigger (name, level, last_modified_user)
select 'Real World Testing Results URL or Check Date updated outside normal update period', 'Listing', -1
where not exists (
	select *
	from openchpl.questionable_activity_trigger
	where name = 'Real World Testing Results URL or Check Date updated outside normal update period'
	and level = 'Listing'
);;
-- ./changes/ocd-4026.sql
alter table openchpl.attestation_submission drop column if exists drop_developer_attestation_submission_id;

drop table if exists openchpl.developer_attestation_response;
drop table if exists openchpl.developer_attestation_submission;
drop table if exists openchpl.change_request_attestation_response;
drop table if exists openchpl.attestation_form;
drop table if exists openchpl.attestation;
drop table if exists openchpl.attestation_valid_response;
drop table if exists openchpl.attestation_condition;
;
-- ./changes/ocd-4042.sql
UPDATE openchpl.certification_criterion
SET title = 'Electronic Health Information Export (Cures Update)'
WHERE number = '170.315 (b)(10)';

UPDATE openchpl.certification_criterion
SET title = 'Encrypt Authentication Credentials (Cures Update)'
WHERE number = '170.315 (d)(12)';

UPDATE openchpl.certification_criterion
SET title = 'Multi-Factor Authentication (Cures Update)'
WHERE number = '170.315 (d)(13)';

UPDATE openchpl.certification_criterion
SET title = 'Standardized API for Patient and Population Services (Cures Update)'
WHERE number = '170.315 (g)(10)';
;
-- ./changes/ocd-4058.sql
-- delete the orphaned version
DELETE FROM openchpl.product_version
WHERE product_version_id = 8583;

-- delete version split + version creation activities
DELETE FROM openchpl.activity
WHERE activity_id = 89349;

DELETE FROM openchpl.activity
WHERE activity_id = 89348;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('21.1.0', '2022-10-03', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
