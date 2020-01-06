alter table openchpl.certification_result
drop column if exists attestation_answer,
drop column if exists export_documentation,
drop column if exists documentation_url,
drop column if exists use_cases;

alter table openchpl.pending_certification_result
add column attestation_answer bool,
add column export_documentation varchar(1024),
add column documentation_url varchar(1024),
add column use_cases varchar(1024);
