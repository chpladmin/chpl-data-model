-- Deployment file for version 23.0.0
--     as of 2023-01-23
-- ./changes/ocd-3996.sql
DROP TABLE IF EXISTS openchpl.macra_criteria_map CASCADE;
DROP TABLE IF EXISTS openchpl.allowed_measure_criteria_legacy_map CASCADE;
;
-- ./changes/ocd-4030.sql
INSERT INTO openchpl.user_permission (name, description, authority, last_modified_user)
SELECT 'STARTUP', 'This permission allows a user to use APIs needed for system startup', 'ROLE_STARTUP', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.user_permission
    WHERE name = 'STARTUP'
);

;
-- ./changes/ocd-4041.sql
DROP TABLE IF EXISTS openchpl.fuzzy_choices;
;
-- ./changes/ocd-4086.sql
INSERT INTO openchpl.questionable_activity_trigger (name, level, last_modified_user)
SELECT 'Cures Update Designation Removed', 'Listing', -1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.questionable_activity_trigger
	WHERE name = 'Cures Update Designation Removed'
	and level = 'Listing'
);
;
-- ./changes/ocd-4106.sql
insert into openchpl.requirement_group_type ("name", last_modified_user)
values ('Inherited Certified Status', -1)
on conflict ("name") do nothing;

insert into openchpl.additional_requirement_type ("name", last_modified_user, requirement_group_type_id)
select 'Inherited Certified Status', -1, (select id from openchpl.requirement_group_type where "name" = 'Inherited Certified Status')
where not exists
 (select * from openchpl.additional_requirement_type where "name" = 'Inherited Certified Status');
;
-- ./changes/ocd-4113.sql
UPDATE openchpl.certified_product
SET deleted = true
WHERE certified_product_id = 11034;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.0.0', '2023-01-23', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
