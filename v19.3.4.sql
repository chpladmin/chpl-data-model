-- Deployment file for version 19.3.4
--     as of 2020-07-13
-- ocd-3322.sql
insert into openchpl.filter_type (name, last_modified_user)
select 'ONC-ACB Report', -1
where not exists (select * from openchpl.filter_type where name = 'ONC-ACB Report');
;
-- ocd-3423.sql
update openchpl.macra_criteria_map set description = 'Required Test 1: Medicaid Promoting Interoperability Program' where description = 'Required Test 1: Medicaid Promoting Interopability Program';
update openchpl.macra_criteria_map set description = 'Required Test 1: Medicare and Medicaid Promoting Interoperability Programs' where description = 'Required Test 1: Medicare and Medicaid Promoting Interopability Programs';
update openchpl.macra_criteria_map set description = 'Required Test 2: Medicaid Promoting Interoperability Program' where description = 'Required Test 2: Medicaid Promoting Interopability Program';
update openchpl.macra_criteria_map set description = 'Required Test 2: Medicare and Medicaid Promoting Interoperability Programs' where description = 'Required Test 2: Medicare and Medicaid Promoting Interopability Programs';
update openchpl.macra_criteria_map set description = 'Required Test 4: Medicaid Promoting Interoperability Program' where description = 'Required Test 4: Medicaid Promoting Interopability Program';
update openchpl.macra_criteria_map set description = 'Required Test 5: Medicaid Promoting Interoperability Program' where description = 'Required Test 5: Medicaid Promoting Interopability Program';
update openchpl.macra_criteria_map set description = 'Required Test 6: Medicaid Promoting Interoperability Program' where description = 'Required Test 6: Medicaid Promoting Interopability Program';
update openchpl.macra_criteria_map set description = 'Required Test 14: Medicare Promoting Interoperability Program' where description = 'Required Test 14: Medicare Promoting Interopability Program';
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.3.4', '2020-07-13', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
