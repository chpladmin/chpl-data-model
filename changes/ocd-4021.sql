alter table openchpl.form add column if not exists instructions text;

update openchpl.form
set instructions = 'If "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.'
where description = 'Attestation Period 2022-04-01 to 2022-09-30';

