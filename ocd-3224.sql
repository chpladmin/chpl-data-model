alter table openchpl.certification_result
drop column if exists attestation_answer cascade,
drop column if exists export_documentation cascade,
drop column if exists documentation_url cascade,
drop column if exists use_cases cascade;

alter table openchpl.certification_result
add column attestation_answer bool,
add column export_documentation varchar(1024),
add column documentation_url varchar(1024),
add column use_cases varchar(1024);

alter table openchpl.pending_certification_result
drop column if exists attestation_answer,
drop column if exists export_documentation,
drop column if exists documentation_url,
drop column if exists use_cases;

alter table openchpl.pending_certification_result
add column attestation_answer bool,
add column export_documentation varchar(1024),
add column documentation_url varchar(1024),
add column use_cases varchar(1024);

insert into openchpl.certification_criterion (certification_edition_id, number, title, last_modified_user) select 3, '170.315 (b)(10)', 'Clinical Information Export', -1
       where not exists (select * from openchpl.certification_criterion where number = '170.315 (b)(10)' and title = 'Clinical Information Export');
insert into openchpl.certification_criterion (certification_edition_id, number, title, last_modified_user) select 3, '170.315 (d)(12)', 'Encrypt Authentication Credentials', -1
       where not exists (select * from openchpl.certification_criterion where number = '170.315 (d)(12)' and title = 'Encrypt Authentication Credentials');
insert into openchpl.certification_criterion (certification_edition_id, number, title, last_modified_user) select 3, '170.315 (d)(13)', 'Multi-Factor Authentication', -1
       where not exists (select * from openchpl.certification_criterion where number = '170.315 (d)(13)' and title = 'Multi-Factor Authentication');
insert into openchpl.certification_criterion (certification_edition_id, number, title, last_modified_user) select 3, '170.315 (g)(10)', 'Standardized API for Patient and Population Services', -1
       where not exists (select * from openchpl.certification_criterion where number = '170.315 (g)(10)' and title = 'Standardized API for Patient and Population Services');
