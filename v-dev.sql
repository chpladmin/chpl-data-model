--
-- OCD-2226: Clean up Test Tools
--

-- Consolidate all Direct Certificate Discovery Tool + 2015 Direct Certificate Discovery Tool to "Direct Certificate Discovery Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id > (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
and tt.name like '%Direct Certificate Discovery Tool%';

update openchpl.certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = true);

update openchpl.pending_certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Direct Certificate Discovery Tool%' and tt.deleted = true);

-- Consolidate HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool (x2) and HL7 v2 Electronic Laboratory Reporting Validation Tool to "HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id > (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
and tt.name like '%Electronic Laboratory Reporting%';

update openchpl.certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = true);

update openchpl.pending_certification_result_test_tool
set test_tool_id = (select min(test_tool_id) from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = false)
where test_tool_id = any(select test_tool_id from openchpl.test_tool tt where tt.name like '%Electronic Laboratory Reporting%' and tt.deleted = true);

-- "Electronic Prescribing" + "ePrescribing Validation Tool" = "Electronic Prescribing"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id = 1;

update openchpl.certification_result_test_tool
set test_tool_id = 13
where test_tool_id = 1;

update openchpl.pending_certification_result_test_tool
set test_tool_id = 13
where test_tool_id = 1;

-- "Transport Test Tool" + "Transport Testing Tool" = "Transport Testing Tool"
update openchpl.test_tool tt
set deleted = true
where tt.test_tool_id = 15;

update openchpl.certification_result_test_tool
set test_tool_id = 7
where test_tool_id = 15;

update openchpl.pending_certification_result_test_tool
set test_tool_id = 7
where test_tool_id = 15;

-- "Healthcare Associated Infections (HAI) Validator" -> CDC's NHSN CDA Validator
-- "Edge Test Tool" -> "Edge Testing Tool"
update openchpl.test_tool tt
set name = 'CDC''s NHSN CDA Validator'
where test_tool_id = 24;
update openchpl.test_tool tt
set name = 'Edge Testing Tool'
where test_tool_id = 16;

--
-- OCD-2104: new vs. incumbent statistics
--
DROP TABLE IF EXISTS openchpl.incumbent_developers_statistics;
CREATE TABLE openchpl.incumbent_developers_statistics (
        id bigserial NOT NULL,
        new_2011_to_2014 bigint NOT NULL,
        new_2011_to_2015 bigint NOT NULL,
        new_2014_to_2015 bigint NOT NULL,
        incumbent_2011_to_2014 bigint NOT NULL,
        incumbent_2011_to_2015 bigint NOT NULL,
        incumbent_2014_to_2015 bigint NOT NULL,
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
        last_modified_user bigint NOT NULL,
        deleted boolean NOT NULL DEFAULT false,
        CONSTRAINT incumbent_developers_statistics_pk PRIMARY KEY (id)
        );
CREATE TRIGGER incumbent_developers_statistics_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.incumbent_developers_statistics FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER incumbent_developers_statistics_timestamp BEFORE UPDATE on openchpl.incumbent_developers_statistics FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
--re-run grants
\i dev/openchpl_grant-all.sql
