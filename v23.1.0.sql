-- Deployment file for version 23.1.0
--     as of 2023-02-06
-- ./changes/ocd-3766.sql
--
-- Rename tables, columns, indexes to use functionality_tested language
--

ALTER TABLE IF EXISTS openchpl.test_functionality
RENAME COLUMN test_functionality_id TO id;

ALTER TABLE IF EXISTS openchpl.test_functionality
RENAME TO functionality_tested;

ALTER TABLE openchpl.functionality_tested
DROP COLUMN IF EXISTS certification_edition_id;

ALTER INDEX IF EXISTS openchpl.test_functionality_pk RENAME TO functionality_tested_pk;
ALTER INDEX IF EXISTS openchpl.ix_test_functionality RENAME TO ix_functionality_tested;
DROP TRIGGER IF EXISTS test_functionality_audit on openchpl.functionality_tested;
DROP TRIGGER IF EXISTS functionality_tested_audit on openchpl.functionality_tested;
CREATE TRIGGER functionality_tested_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.functionality_tested FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS test_functionality_timestamp on openchpl.functionality_tested;
DROP TRIGGER IF EXISTS functionality_tested_timestamp on openchpl.functionality_tested;
CREATE TRIGGER functionality_tested_timestamp BEFORE UPDATE on openchpl.functionality_tested FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

ALTER TABLE IF EXISTS openchpl.test_functionality_criteria_map
RENAME COLUMN test_functionality_id TO functionality_tested_id;

ALTER TABLE IF EXISTS openchpl.test_functionality_criteria_map
RENAME TO functionality_tested_criteria_map;

ALTER INDEX IF EXISTS openchpl.test_functionality_criteria_map_pk RENAME TO functionality_tested_criteria_map_pk;
DROP TRIGGER IF EXISTS test_functionality_criteria_map_audit on openchpl.functionality_tested_criteria_map;
DROP TRIGGER IF EXISTS functionality_tested_criteria_map_audit on openchpl.functionality_tested_criteria_map;
CREATE TRIGGER functionality_tested_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.functionality_tested_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
DROP TRIGGER IF EXISTS test_functionality_criteria_map_timestamp on openchpl.functionality_tested_criteria_map;
DROP TRIGGER IF EXISTS functionality_tested_criteria_map_timestamp on openchpl.functionality_tested_criteria_map;
CREATE TRIGGER functionality_tested_criteria_map_timestamp BEFORE UPDATE on openchpl.functionality_tested_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME COLUMN certification_result_test_functionality_id TO id;

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME COLUMN test_functionality_id TO functionality_tested_id;

ALTER TABLE IF EXISTS openchpl.certification_result_test_functionality
RENAME TO certification_result_functionality_tested;

ALTER INDEX IF EXISTS openchpl.certification_result_test_functionality_pk RENAME TO certification_result_functionality_tested_pk;
ALTER INDEX IF EXISTS openchpl.ix_certification_result_test_functionality RENAME TO ix_certification_result_functionality_tested;
--audit triggers for this table are already properly named

--
-- Add functionality tested to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS functionality_tested bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 8;

-- a10
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 10;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 13;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 14;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 16;

-- b1Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 165;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 167;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 19;

-- b5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 20;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 21;

-- c3 (c3Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 27;

-- d7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 35;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 37;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 40;

-- e1Cures
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 178;

-- f5 (f5Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 47;

-- g4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 53;

-- g5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 54;

-- g6 (g6Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 55;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 57;

-- g9 (g9Cures cannot have functionality tested)
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 59;

--
-- 2014 Criteria
--

-- a4
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 68;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 74;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 81;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 82;

-- b7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 88;

-- b8
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 89;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 104;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 108;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET functionality_tested = true
WHERE criterion_id = 112;

--
-- This is not related to functionality tested, but with OCD-3793, we moved test data attributes into this criterion attribute table.
-- When we did that, we did not set test_data to true for g9-original(we did set it to true for g9-Cures).
-- I checked this with our PO and confirmed that both g9 and g9Cures should be allowed to have test data.
--
UPDATE openchpl.certification_criterion_attribute
SET test_data = true
WHERE criterion_id = 58;









;
-- ./changes/ocd-4078.sql
insert into openchpl.form
 (description, instructions, last_modified_user)
 select 'Attestation Period 2022-10-01 to 2023-03-31', 'If "Noncompliant" is selected, you may, but are not required to, indicate the status of a Corrective Action Plan (CAP) under the Certification Program.', -1
 where not exists (select * from openchpl.form where description = 'Attestation Period 2022-10-01 to 2023-03-31');

update openchpl.attestation_period
 set form_id = (select id from openchpl.form where description = 'Attestation Period 2022-10-01 to 2023-03-31')
 where id = (select id from openchpl.attestation_period where description = 'Third Period');

insert into openchpl.attestation_period
 (description, period_start, period_end, submission_start, submission_end, last_modified_user)
 select 'Fourth Period', '2023-04-01', '2023-09-30', '2023-10-01', '2023-10-31', -1
 where not exists (select * from openchpl.attestation_period where description = 'Fourth Period');

insert into openchpl.question
 (question, response_cardinality_type_id, section_heading_id, last_modified_user)
 select 'We attest to compliance with the Assurances Condition and Maintenance of Certification requirements described in [45 CFR 170.402](https://ecfr.federalregister.gov/current/title-45/subtitle-A/subchapter-D/part-170/subpart-D/section-170.402).', 1, 2, -1
 where not exists (select * from openchpl.question where id = 7);
 /* will have two rows with duplicate question text, but allowed reponses must be different, and the question_id is how the form is populated */

insert into openchpl.allowed_response
 (response, last_modified_user)
 select 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is applicable because we are a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI and therefore must certify to the certification criterion in § 170.315(b)(10).', -1
 where not exists (select * from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is applicable because we are a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI and therefore must certify to the certification criterion in § 170.315(b)(10).');

insert into openchpl.allowed_response
 (response, last_modified_user)
 select 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is not applicable because we are not a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI.', -1
 where not exists (select * from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is not applicable because we are not a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI.');

insert into openchpl.question_allowed_response_map
 (question_id, allowed_response_id, sort_order, last_modified_user)
 select 7, (select id from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is applicable because we are a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI and therefore must certify to the certification criterion in § 170.315(b)(10).'), 2, -1
 where not exists (select * from openchpl.question_allowed_response_map where question_id = 7 and allowed_response_id = (select id from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is applicable because we are a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI and therefore must certify to the certification criterion in § 170.315(b)(10).'));

insert into openchpl.question_allowed_response_map
 (question_id, allowed_response_id, sort_order, last_modified_user)
 select 7, (select id from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is not applicable because we are not a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI.'), 3, -1
 where not exists (select * from openchpl.question_allowed_response_map where question_id = 7 and allowed_response_id = (select id from openchpl.allowed_response where response = 'Compliant with the requirements of 45 CFR 170.402; 45 CFR 170.402(a)(4) is not applicable because we are not a developer of a Certified Health IT Module that is part of a health IT product which electronically stores EHI.'));

insert into openchpl.question_allowed_response_map
 (question_id, allowed_response_id, sort_order, last_modified_user)
 select
 7, 2, 10, -1
 where not exists (select * from openchpl.question_allowed_response_map where question_id = 7 and allowed_response_id = 2);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 1, NULL, NULL, 1, TRUE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 1);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 7, NULL, NULL, 2, TRUE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 7);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 3, NULL, NULL, 3, TRUE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 3);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 4, NULL, NULL, 4, TRUE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 4);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 5, NULL, NULL, 5, TRUE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 5);

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 6, (select id from openchpl.form_item where form_id = 3 and question_id = 1), 2, 1, FALSE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 6 and parent_form_item_id = (select id from openchpl.form_item where form_id = 3 and question_id = 1));

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 6, (select id from openchpl.form_item where form_id = 3 and question_id = 7), 2, 1, FALSE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 6 and parent_form_item_id = (select id from openchpl.form_item where form_id = 3 and question_id = 7));

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 6, (select id from openchpl.form_item where form_id = 3 and question_id = 3), 2, 1, FALSE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 6 and parent_form_item_id = (select id from openchpl.form_item where form_id = 3 and question_id = 3));

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 6, (select id from openchpl.form_item where form_id = 3 and question_id = 4), 2, 1, FALSE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 6 and parent_form_item_id = (select id from openchpl.form_item where form_id = 3 and question_id = 4));

insert into openchpl.form_item
 (form_id, question_id, parent_form_item_id, parent_response_id, sort_order, required, last_modified_user)
 select 3, 6, (select id from openchpl.form_item where form_id = 3 and question_id = 5), 2, 1, FALSE, -1
 where not exists (select * from openchpl.form_item where form_id = 3 and question_id = 6 and parent_form_item_id = (select id from openchpl.form_item where form_id = 3 and question_id = 5));
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.1.0', '2023-02-06', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
