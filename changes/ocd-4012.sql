drop table if exists openchpl.surveillance_nonconformity_document;

drop table if exists openchpl.pending_surveillance_validation;
drop table if exists openchpl.pending_surveillance_nonconformity;
drop table if exists openchpl.pending_surveillance_requirement;
drop table if exists openchpl.pending_surveillance;

delete from openchpl.questionable_activity_trigger where name = 'Removed Non-Conformity added to Surveillance';
delete from openchpl.questionable_activity_trigger where name = 'Removed Requirement added to Surveillance';
