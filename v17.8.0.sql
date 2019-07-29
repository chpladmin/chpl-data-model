-- Deployment file for version 17.8.0
--     as of 2019-07-29
-- ocd-3016.sql
insert into openchpl.activity_concept (concept, last_modified_user)
select 'COMPLAINT', -1
where not exists
	(select *
	from openchpl.activity_concept
	where concept = 'COMPLAINT');

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.8.0', '2019-07-29', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
