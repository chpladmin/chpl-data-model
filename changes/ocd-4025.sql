DELETE FROM openchpl.attestation_period WHERE description = 'Second Period';
DELETE FROM openchpl.attestation_period WHERE description = 'Third Period';

INSERT INTO openchpl.attestation_period
(description, period_start, period_end, submission_start, submission_end, form_id, last_modified_user)
VALUES
('Second Period', '2022-04-01', '2022-09-30', '2022-10-01', '2022-10-31', 2, -1),
('Third Period',  '2022-10-01', '2023-03-31', '2023-04-01', '2023-04-30', null, -1);
