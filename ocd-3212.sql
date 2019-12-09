update openchpl.test_tool
set retired = false
where name = 'CDC''s NHSN CDA Validator';

update openchpl.test_tool
set retired = true
where name = 'HL7 CDA National Health Care Surveys Validator';
