-- Deployment file for version 24.1.0
--     as of 2023-09-18
-- ./changes/ocd-4288.sql
alter table openchpl.test_tool drop column if exists name;

alter table openchpl.test_tool drop column if exists description;

alter table openchpl.test_tool drop column if exists retired;

--------------------------------------------------------------------------

alter table openchpl.functionality_tested add column if not exists value text;

alter table openchpl.functionality_tested add column if not exists regulatory_text_citation text;

alter table openchpl.functionality_tested add column if not exists additional_information text;

alter table openchpl.functionality_tested add column if not exists start_day date;

alter table openchpl.functionality_tested add column if not exists end_day date;

alter table openchpl.functionality_tested add column if not exists required_day date;

alter table openchpl.functionality_tested add column if not exists rule_id bigint;

alter table openchpl.functionality_tested drop constraint if exists rule_fk;

alter table openchpl.functionality_tested add constraint rule_fk foreign key (rule_id)
    references openchpl.rule (id)
    match simple on update no action on delete restrict;

update openchpl.functionality_tested
set value = name,
regulatory_text_citation = number;

alter table openchpl.functionality_tested alter column value set not null;

alter table openchpl.functionality_tested alter column regulatory_text_citation set not null;

-- Remove Functionality Tested criteria attribute from 170.315 (h)(1)
update openchpl.certification_criterion_attribute
set functionality_tested = false
where criterion_id = 59;

-- Update the dates and rule for functionalities Tested
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(a)(1)(ii)  Include a "reason for order" field' and regulatory_text_citation = '(a)(1)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2022-01-01' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(10)(i) Drug formulary checks. Automatically check whether a drug formulary exists for a given patient and medication' and regulatory_text_citation = '(a)(10)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2022-01-01' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(10)(ii)  Preferred drug list checks. Automatically check whether a preferred drug list exists for a given patient and medication' and regulatory_text_citation = '(a)(10)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2022-01-01' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(a)(13)(ii) Request that patient-specific education resources be identified in accordance with the standard in § 170.207(g)(2)' and regulatory_text_citation = '(a)(13)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(14)(iii)(A)(1) The "GMDN PT Name" attribute associated with the Device Identifier in the Global Unique Device Identification Database' and regulatory_text_citation = '(a)(14)(iii)(A)(1)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(14)(iii)(A)(2) The "SNOMED CT Description" mapped to the attribute referenced in (a)(14)(iii)(1) (The "GMDN PT Name" attribute associated with the Device Identifier in the Global Unique Device Identification Database)' and regulatory_text_citation = '(a)(14)(iii)(A)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(a)(14)(vi) Patient communication preferences' and regulatory_text_citation = '(a)(14)(vi)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(a)(2)(ii) Include a "reason for order" field' and regulatory_text_citation = '(a)(2)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(a)(3)(ii) Include a "reason for order" field' and regulatory_text_citation = '(a)(3)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(4)(ii)(B)(1) To a specific set of identified users' and regulatory_text_citation = '(a)(4)(ii)(B)(1)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(a)(4)(ii)(B)(2) As a system administrative function' and regulatory_text_citation = '(a)(4)(ii)(B)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.314(a)(4)(iii) Plot and electronically display, upon request, growth charts for patients' and regulatory_text_citation = '(a)(4)(iii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(a)(5)(i) Over multiple encounters in accordance with, at a minimum, the version of the standard specified in §170.207(a)(3)' and regulatory_text_citation = '(a)(5)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(a)(5)(ii) For the duration of an entire hospitalization in accordance with, at a minimum, the version of the standard specified in §170.207(a)(3)' and regulatory_text_citation = '(a)(5)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(a)(5)(ii) Enable a user to record, change, and access the preliminary cause of death and date of death in the event of mortality' and regulatory_text_citation = '(a)(5)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(a)(6)(i) Over multiple encounters' and regulatory_text_citation = '(a)(6)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(a)(6)(i) Over multiple encounters in accordance with, at a minimum, the version of the standard specified in § 170.207(a)(4)' and regulatory_text_citation = '(a)(6)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(a)(6)(ii) For the duration of an entire hospitalization' and regulatory_text_citation = '(a)(6)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(a)(6)(ii) For the duration of an entire hospitalization in accordance with, at a minimum, the version of the standard specified in §170.207(a)(4)' and regulatory_text_citation = '(a)(6)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2015-12-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(a)(7)(i) Over multiple encounters' and regulatory_text_citation = '(a)(7)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(a)(7)(i) Over multiple encounters' and regulatory_text_citation = '(a)(7)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(a)(7)(ii) For the duration of an entire hospitalization' and regulatory_text_citation = '(a)(7)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(a)(7)(ii) For the duration of an entire hospitalization' and regulatory_text_citation = '(a)(7)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(a)(8)(i) Over multiple encounters' and regulatory_text_citation = '(a)(8)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(a)(8)(ii) For the duration of an entire hospitalization' and regulatory_text_citation = '(a)(8)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(a)(8)(iii)(B)(3) When a patient''s laboratory tests and values/results are incorporated pursuant to paragraph (b)(5)(i)(A)(1) of this section' and regulatory_text_citation = '(a)(8)(iii)(B)(3)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.314(b)(1)(i)(B) Receive summary care record using the standards specified at §170.202(a) and (b) (Direct and XDM Validation)' and regulatory_text_citation = '(b)(1)(i)(B)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.314(b)(1)(i)(C) Receive summary care record using the standards specified at §170.202(b) and (c) (SOAP Protocols)' and regulatory_text_citation = '(b)(1)(i)(C)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(1)(ii)(A)(5)(i) Be notified of the errors produced' and regulatory_text_citation = '(b)(1)(ii)(A)(5)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(1)(ii)(A)(5)(ii) Review the errors produced' and regulatory_text_citation = '(b)(1)(ii)(A)(5)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(b)(1)(iii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(1)(iii)(E)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(b)(1)(iii)(F) Discharge Instructions' and regulatory_text_citation = '(b)(1)(iii)(F)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(b)(1)(iii)(G)(1)(ii) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included' and regulatory_text_citation = '(b)(1)(iii)(G)(1)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(b)(2)(i)(E) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(2)(i)(E)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2022-12-31' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(b)(3)(i)(C) For each transaction listed in paragraph (b)(3)(i)(A) of this section, the technology must be able to receive and transmit the reason for the prescription using the indication elements in the SIG Segment' and regulatory_text_citation = '(b)(3)(i)(C)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Create and respond to new prescriptions (NewRxRequest, NewRxResponseDenied)' and regulatory_text_citation = '(b)(3)(ii)(B)(1)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Receive fill status notifications (RxFillIndicator)' and regulatory_text_citation = '(b)(3)(ii)(B)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ask the Mailbox if there are any transactions (GetMessage)' and regulatory_text_citation = '(b)(3)(ii)(B)(3)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Request to send an additional supply of medication (Resupply)' and regulatory_text_citation = '(b)(3)(ii)(B)(4)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Communicate drug administration events (DrugAdministration)' and regulatory_text_citation = '(b)(3)(ii)(B)(5)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Request and respond to transfer one or more prescriptions between pharmacies (RxTransferRequest, RxTransferResponse, RxTransferConfirm)' and regulatory_text_citation = '(b)(3)(ii)(B)(6)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Recertify the continued administration of a medication order (Recertification)' and regulatory_text_citation = '(b)(3)(ii)(B)(7)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Complete Risk Evaluation and Mitigation Strategy (REMS) transactions (REMSInitiationRequest, REMSInitiationResponse, REMSRequest, and REMSResponse)' and regulatory_text_citation = '(b)(3)(ii)(B)(8)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Electronic prior authorization transactions (PAInitiationRequest, PAInitiationResponse, PARequest, PAResponse, PAAppealRequest, PAAppealResponse,  PACancelRequest, and PACancelResponse).' and regulatory_text_citation = '(b)(3)(ii)(B)(9)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Request to send an additional supply of medication (Resupply)' and regulatory_text_citation = '(b)(3)(ii)(C)(2)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Request and respond to transfer one or more prescriptions between pharmacies (RxTransferRequest, RxTransferResponse)' and regulatory_text_citation = '(b)(3)(ii)(C)(2)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Complete Risk Evaluation and Mitigation Strategy (REMS) transactions (REMSInitiationRequest, REMSInitiationResponse, REMSRequest, and REMSResponse)' and regulatory_text_citation = '(b)(3)(ii)(C)(2)(iii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Electronic prior authorization (ePA) transactions (PAInitiationRequest, PAInitiationResponse, PARequest, PAResponse, PAAppealRequest, PAAppealResponse and PACancelRequest, PACancelResponse)' and regulatory_text_citation = '(b)(3)(ii)(C)(2)(iv)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(b)(3)(ii)(D) For each transaction listed in paragraph (b)(3)(ii)(C) of this section, the technology must be able to receive and transmit the reason for the prescription using the <IndicationforUse> element in the SIG segment' and regulatory_text_citation = '(b)(3)(ii)(D)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(b)(4)(v) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(4)(v)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(b)(4)(vi) Discharge Instructions' and regulatory_text_citation = '(b)(4)(vi)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(b)(4)(vii)(A)(2) When the hour, minute, and second are associated with a date of birth the technology must demonstrate that the correct time zone offset is included' and regulatory_text_citation = '(b)(4)(vii)(A)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(b)(5)(i)(E) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(5)(i)(E)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(b)(5)(i)(F) Discharge Instructions' and regulatory_text_citation = '(b)(5)(i)(F)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(5)(ii)(A)(5)(i) Be notified of the errors produced' and regulatory_text_citation = '(b)(5)(ii)(A)(5)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(5)(ii)(A)(5)(ii) Review the errors produced' and regulatory_text_citation = '(b)(5)(ii)(A)(5)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2023-12-31' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(6)(i)(B)(1) To a specific set of identified users' and regulatory_text_citation = '(b)(6)(i)(B)(1)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2023-12-31' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(b)(6)(i)(B)(2) As a system administrative function' and regulatory_text_citation = '(b)(6)(i)(B)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2023-12-31' where id = (select id from openchpl.functionality_tested where value ='Ambulatory: 170.315(b)(6)(ii)(E) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(6)(ii)(E)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14', end_day = '2023-12-31' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(b)(6)(ii)(F) Discharge Instructions' and regulatory_text_citation = '(b)(6)(ii)(F)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(b)(7)(v) The reason for referral; and referring or transitioning provider''s name and office contact information' and regulatory_text_citation = '(b)(7)(v)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(b)(7)(vi) Discharge Instructions' and regulatory_text_citation = '(b)(7)(vi)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.315(c)(3)(ii) That can be electronically accepted by CMS' and regulatory_text_citation = '(c)(3)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(d)(7)(i) Technology that is designed to locally store electronic health information on end-user devices must encrypt the electronic health information stored on such devices after use of the technology on those devices stops' and regulatory_text_citation = '(d)(7)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(d)(7)(ii) Technology is designed to prevent electronic health information from being locally stored on end-user devices after use of the technology on those devices stops' and regulatory_text_citation = '(d)(7)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2020-06-30' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(d)(9)(i) Message-level. Encrypt and integrity protect message contents in accordance with the standards specified in § 170.210(a)(2) and (c)(2)' and regulatory_text_citation = '(d)(9)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = 'Cures'), start_day = '2022-12-31' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(d)(9)(ii) Transport-level. Use a trusted connection in accordance with the standards specified in § 170.210(a)(2) and (c)(2)' and regulatory_text_citation = '(d)(9)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(e)(1)(i)(A)(2) Provider''s name and office contact information' and regulatory_text_citation = '(e)(1)(i)(A)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(e)(1)(i)(A)(3) Admission and discharge dates and locations; discharge instructions; and reason(s) for hospitalization' and regulatory_text_citation = '(e)(1)(i)(A)(3)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(e)(1)(i)(B)(1)(i) All of the data in the Common MU Data Set (which should be in their English (i.e., noncoded) representation if they associate with a vocabulary/code set) and the Provider''s name and office contact information' and regulatory_text_citation = '(e)(1)(i)(B)(1)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(e)(1)(i)(B)(1)(ii) All of the data in the Common MU Data Set (which should be in their English (i.e., noncoded) representation if they associate with a vocabulary/code set) and the admission and discharge dates and locations; discharge instructions; and reason(s) for hospitalization' and regulatory_text_citation = '(e)(1)(i)(B)(1)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(e)(1)(i)(B)(2) Electronically download transition of care/referral summaries that were created as a result of a transition of care (pursuant to the capability expressed in the certification criterion adopted at paragraph (b)(2) of this section)' and regulatory_text_citation = '(e)(1)(i)(B)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient: 170.315(e)(1)(i)(B)(3) Patients (and their authorized representatives) must be able to download transition of care/referral summaries that were created as a result of a transition of care (pursuant to the capability expressed in the certification criterion specified in paragraph (b)(1) of this section)' and regulatory_text_citation = '(e)(1)(i)(B)(3)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(e)(1)(i)(C)(2) Electronically transmit transition of care/referral summaries (as a result of a transition of care/referral) selected by the patient (or their authorized representative) in accordance with at least one of the following: (i) The standard specified in §170.202(a). (ii) Through a method that conforms to the standard specified at §170.202(d) and that leads to such summary being processed by a service that has implemented the standard specified in §170.202(a)' and regulatory_text_citation = '(e)(1)(i)(C)(2)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Ambulatory setting: 170.314(f)(3)(i) (A) The standard specified in §170.205(d)(2). (B) Optional. The standard (and applicable implementation specifications) specified in §170.205(d)(3)' and regulatory_text_citation = '(f)(3)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: 170.314(f)(3)(i)(B) Create syndrome-based public health surveillance information for transmission using the standard specified at §170.205(d)(3) (urgent care visit scenario)' and regulatory_text_citation = '(f)(3)(i)(B)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Inpatient setting: 170.314(f)(3)(ii)  The standard (and applicable implementation specifications) specified in §170.205(d)(3)' and regulatory_text_citation = '(f)(3)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2014'), start_day = '2012-12-14', end_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Optional: (f)(7)(i) EHR technology must be able to electronically create syndrome-based public health surveillance information for electronic transmission that contains the following data: (A) Patient demographics; (B) Provider specialty; (C) Provider address; (D) Problem list; (E) Vital signs; (F) Laboratory test values/results; (G) Procedures; (H) Medication list; and (I) Insurance' and regulatory_text_citation = '(f)(7)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(g)(4)(i)(A) The QMS used is established by the Federal government or a standards developing organization' and regulatory_text_citation = '(g)(4)(i)(A)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(g)(4)(i)(B) The QMS used is mapped to one or more QMS established by the Federal government or standards developing organization(s)' and regulatory_text_citation = '(g)(4)(i)(B)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(g)(5)(i) When a single accessibility-centered design standard or law was used for applicable capabilities, it would only need to be identified once' and regulatory_text_citation = '(g)(5)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(g)(5)(ii) When different accessibility-centered design standards and laws were applied to specific capabilities, each accessibility-centered design standard or law applied would need to be identified. This would include the application of an accessibility-centered design standard or law to some capabilities and none to others' and regulatory_text_citation = '(g)(5)(ii)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where value ='Alternative: 170.315(g)(5)(iii) When no accessibility-centered design standard or law was applied to all applicable capabilities such a response is acceptable to satisfy this certification criterion' and regulatory_text_citation = '(g)(5)(iii)');

--The following updates occur to Functionalies Tested where the regualtory_text_citation is unique.  These
--typically had odd chars in the "value" column so value was removed from the identifying "where" clause.
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where regulatory_text_citation = '(e)(1)(i)(A)(4)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where regulatory_text_citation = '(e)(1)(i)(A)(5)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where regulatory_text_citation = '(e)(1)(i)(B)(2)(i)');
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where regulatory_text_citation = '(e)(1)(i)(B)(2)(ii)');

--Only "easy" way to identify this record id via the "id"
update openchpl.functionality_tested set rule_id = (select id from openchpl.rule where name = '2015'), start_day = '2016-01-14' where id = (select id from openchpl.functionality_tested where id = 80);

;
-- ./changes/ocd-4289.sql
-- set criteria start and end dates

-- 2011
UPDATE openchpl.certification_criterion
SET start_day = '2010-09-27'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET end_day = '2015-02-28'
WHERE number LIKE '170.30%';

-- 2014
UPDATE openchpl.certification_criterion
SET start_day = '2012-10-04'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number LIKE '170.314%';

-- 2014 release 2
UPDATE openchpl.certification_criterion
SET start_day = '2014-10-14'
WHERE number IN ('170.314 (a)(18)', '170.314 (a)(19)', '170.314 (a)(20)', '170.314 (b)(8)', '170.314 (b)(9)', '170.314 (f)(7)', '170.314 (g)(1)', '170.314 (h)(2)', '170.314 (h)(3)');

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number IN ('170.314 (a)(18)', '170.314 (a)(19)', '170.314 (a)(20)', '170.314 (b)(8)', '170.314 (b)(9)', '170.314 (f)(7)', '170.314 (g)(1)', '170.314 (h)(2)', '170.314 (h)(3)');

-- 2015
UPDATE openchpl.certification_criterion
SET start_day = '2015-10-16'
WHERE number LIKE '170.315%' 
AND title NOT LIKE '%Cures Update%';

-- 2015 removed on Cures ERD
UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number IN ('170.315 (a)(6)', '170.315 (a)(7)', '170.315 (a)(8)', '170.315 (a)(11)', '170.315 (b)(4)', '170.315 (b)(5)')
AND title NOT LIKE '%Cures Update%';

-- 2015 time limited
UPDATE openchpl.certification_criterion
SET end_day = '2021-12-31'
WHERE number IN ('170.315 (a)(10)', '170.315 (a)(13)', '170.315 (e)(2)')
AND title NOT LIKE '%Cures Update%';

-- 2015 original revised criteria
UPDATE openchpl.certification_criterion
SET end_day = '2022-12-31'
WHERE number IN ('170.315 (b)(1)', '170.315 (b)(2)', '170.315 (b)(3)', '170.315 (b)(7)', '170.315 (b)(8)', '170.315 (b)(9)',
'170.315 (c)(3)', '170.315 (d)(2)', '170.315 (d)(3)', '170.315 (d)(10)', '170.315 (e)(1)', '170.315 (f)(5)', '170.315 (g)(6)', '170.315 (g)(8)', '170.315 (g)(9)')
AND title NOT LIKE '%Cures Update%';

-- 2015 ERD-Phase-3
UPDATE openchpl.certification_criterion
SET end_day = '2023-12-31'
WHERE number IN ('170.315 (b)(6)')
AND title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET start_day = '2020-06-30'
WHERE number LIKE '170.315%' and title LIKE '%Cures Update%';
;
-- ./changes/ocd-4335.sql
alter table openchpl.test_tool drop column if exists required_day;

;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.1.0', '2023-09-18', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
