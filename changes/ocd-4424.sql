-- delete from criterion attributes
DELETE FROM openchpl.certification_criterion_attribute WHERE criterion_id = 211;

-- set the sequence back so the next attribute will have the expected ID
ALTER SEQUENCE openchpl.certification_criterion_attribute_id_seq RESTART WITH 162;

-- delete d14 conformance methods
DELETE FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 211;

-- set the sequence back so the next attribute will have the expected ID
ALTER SEQUENCE openchpl.conformance_method_criteria_map_id_seq RESTART WITH 87;

-- delete d14
DELETE FROM openchpl.certification_criterion WHERE number = '170.315 (d)(14)';

-- set the sequence back so the next criterion will have the expected ID
ALTER SEQUENCE openchpl.certification_criterion_certification_criterion_id_seq RESTART WITH 211;

-- set the correct start date for b11
UPDATE openchpl.certification_criterion SET start_day = '2024-03-11' WHERE certification_criterion_id = 210;
