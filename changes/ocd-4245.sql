update openchpl.attestation_period
set form_id = 3
where id = 5;

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2023-10-01',
    '2024-03-31',
    '2024-04-01',
    '2024-04-30',
    'Fifth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2023-10-01' and period_end = '2024-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2024-04-01',
    '2024-09-30',
    '2024-10-01',
    '2024-10-31',
    'Sixth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2024-04-01' and period_end = '2024-09-30');



insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2024-10-01',
    '2025-03-31',
    '2025-04-01',
    '2025-04-30',
    'Seventh Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2024-10-01' and period_end = '2025-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2025-04-01',
    '2025-09-30',
    '2025-10-01',
    '2025-10-31',
    'Eighth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2025-04-01' and period_end = '2025-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2025-10-01',
    '2026-03-31',
    '2026-04-01',
    '2026-04-30',
    'Ninth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2025-10-01' and period_end = '2026-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2024-04-01',
    '2026-09-30',
    '2026-10-01',
    '2026-10-31',
    'Tenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2026-04-01' and period_end = '2026-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2026-10-01',
    '2027-03-31',
    '2027-04-01',
    '2027-04-30',
    'Eleventh Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2026-10-01' and period_end = '2027-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2027-04-01',
    '2027-09-30',
    '2027-10-01',
    '2027-10-31',
    'Twelfth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2027-04-01' and period_end = '2027-09-30');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2027-10-01',
    '2028-03-31',
    '2028-04-01',
    '2028-04-30',
    'Thirteenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2027-10-01' and period_end = '2028-03-31');

insert into openchpl.attestation_period (period_start, period_end, submission_start, submission_end, description, form_id, last_modified_user)
select '2028-04-01',
    '2028-09-30',
    '2028-10-01',
    '2028-10-31',
    'Fourteenth Period',
    3,
    -1
where not exists (select * from openchpl.attestation_period where period_start = '2028-04-01' and period_end = '2028-09-30');


