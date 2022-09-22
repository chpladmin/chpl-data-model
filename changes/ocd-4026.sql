alter table openchpl.attestation_submission drop column if exists drop_developer_attestation_submission_id;

drop table if exists openchpl.developer_attestation_response;
drop table if exists openchpl.developer_attestation_submission;
drop table if exists openchpl.change_request_attestation_response;
drop table if exists openchpl.attestation_valid_response;
drop table if exists openchpl.attestation_form;
drop table if exists openchpl.attestation_condition;
drop table if exists openchpl.attestation;
