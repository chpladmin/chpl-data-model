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
