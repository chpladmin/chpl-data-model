DROP PROCEDURE if exists openchpl.backfill_standards;

CREATE OR REPLACE PROCEDURE openchpl.backfill_standards(
  p_regulatory_text			text,
  p_value					text,
  p_rule_id					int,
  p_start_day				date,
  p_required_day			date,
  p_end_day					date,
  p_group_name				text,
  p_additional_info			text,
  p_criterion_ids			int[])
LANGUAGE plpgsql AS $$
DECLARE
  	v_standard_cnt							int;
	v_standard_criterion_map_cnt			int;
	v_cert_result_standard_cnt				int;
	v_standard 								record;
 	v_criterion_id							int;
 	v_cert_result							record;
 	v_certification_criterion 				record;
BEGIN
	select count(*)
	into v_standard_cnt
	from openchpl.standard s
	where s.regulatory_text_citation = p_regulatory_text;

	if v_standard_cnt = 0 then
		insert into openchpl.standard(rule_id, value, regulatory_text_citation, additional_information, group_name, start_day, required_day, end_day, last_modified_user)
		select p_rule_id, p_value, p_regulatory_text, p_additional_info, p_group_name, p_start_day, p_required_day, p_end_day, -1
		where not exists (
			select * from openchpl.standard s where s.regulatory_text_citation = p_regulatory_text)
		returning * into v_standard;

		raise notice 'Inserted Standard: %', v_standard;--p_regulatory_text;
	else
		select *
		into v_standard
		from openchpl.standard s
		where s.regulatory_text_citation = p_regulatory_text;

		raise notice 'Standard Exists: %', v_standard;--p_regulatory_text;
	end if;

	foreach v_criterion_id in array p_criterion_ids
	loop

		select *
		into v_certification_criterion
		from openchpl.certification_criterion
		where certification_criterion_id = v_criterion_id;

		select count(*)
		into v_standard_criterion_map_cnt
		from openchpl.standard_criteria_map where standard_id = v_standard.id
		and certification_criterion_id = v_criterion_id;

		if v_standard_criterion_map_cnt = 0 then

			insert into openchpl.standard_criteria_map(standard_id, certification_criterion_id, last_modified_user)
			select v_standard.id, v_criterion_id, -1
			where not exists (
				select *
				from openchpl.standard_criteria_map where standard_id = v_standard.id
				and certification_criterion_id = v_criterion_id);

			raise notice 'Inserted Standard Crtieria Map: % -- % (%)', p_regulatory_text, v_certification_criterion.number, v_criterion_id;

		else
			raise notice 'Standard Crtieria Map Exists: % -- % (%)', p_regulatory_text, v_certification_criterion.number, v_criterion_id;
		end if;

		--Check if this is an HTI-1 standard, if so, do not add it to any listings
		if v_standard.required_day < now() then
			for v_cert_result in select cpd.chpl_product_number, cpd.certification_date, cert_result.*
			from openchpl.certification_result cert_result
				inner join openchpl.certified_product_details cpd
					on cert_result.certified_product_id = cpd.certified_product_id
			where cert_result.certification_criterion_id = v_criterion_id
			and cpd.certification_date <= coalesce(v_standard.end_day, '2099-12-31')
			and cert_result.deleted = false
			loop

				select count(*)
				into v_cert_result_standard_cnt
				from openchpl.certification_result_standard
				where certification_result_id = v_cert_result.certification_result_id
				and standard_id = v_standard.id;

				if v_cert_result_standard_cnt = 0 then
					insert into openchpl.certification_result_standard(standard_id, certification_result_id, last_modified_user)
					select v_standard.id, v_cert_result.certification_result_id, -1
					where not exists (
						select *
						from openchpl.certification_result_standard
						where certification_result_id = v_cert_result.certification_result_id
						and standard_id = v_standard.id);

					raise notice 'Inserted Certification Result Standard %  -- %  -- %', v_cert_result.chpl_product_number, v_certification_criterion.number, v_standard.regulatory_text_citation;
				else
					raise notice 'Certification Result Standard Exists %  -- %  -- %', v_cert_result.chpl_product_number, v_certification_criterion.number, v_standard.regulatory_text_citation;
				end if;
			end loop;
		end if;
	end loop;
end $$;


call openchpl.backfill_standards('170.202(a)(2)', 'Direct Project: ONC Applicability Statement for Secure Health Transport, Version 1.2 August 2015', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 59, 60, 165]);

call openchpl.backfill_standards('170.202(b)', 'ONC XDR and XDM for Direct Messaging Specification', 3, '2016-01-14', '2016-01-14', null, null, null, array[60]);

call openchpl.backfill_standards('170.202(d)', 'ONC Implementation Guide for Direct Edge Protocols, Version 1.1, June 25, 2014', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 60, 165]);

call openchpl.backfill_standards('170.202(e)(1)', 'Delivery Notification - Implementation Guide for Delivery Notification in Direct v1.0', 3, '2016-01-14', '2016-01-14', null, null, null, array[59, 60]);

call openchpl.backfill_standards('170.204(a)(1)', 'Web Content Accessibility Guidelines (WCAG) 2.0, Level A Conformance', 3, '2016-01-14', '2016-01-14', null, null, null, array[40, 178]);

call openchpl.backfill_standards('170.204(a)(2)', 'Web Content Accessibility Guidelines (WCAG) 2.0, Level AA Conformance', 3, '2016-01-14', '2016-01-14', null, null, null, array[40, 178]);

call openchpl.backfill_standards('170.205(a)(3)', 'HL7 Implementation Guide for CDA® Release 2: IHE Health Story Consolidation, (incorporated by reference in § 170.299). The use of the “unstructured document” document-level template is prohibited.', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 17, 20, 165, 166]);

call openchpl.backfill_standards('170.205(a)(4)', 'HL7 Implementation Guide for CDA® Release 2: Consolidated CDA Templates for Clinical Notes (US Realm), Draft Standard for Trial Use Release 2.1, August 2015', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 17, 19, 20, 21, 22, 23, 24, 40, 55, 58, 165, 166, 168, 169, 170, 178, 180, 181]);

call openchpl.backfill_standards('170.205(a)(5)', 'HL7® CDA R2 IG: C-CDA Templates for Clinical Notes R2.1 Companion Guide, Release 2, October 2019, IBR approved for § 170.205(a)(5).', 4, '2020-06-30', '2020-06-30', '2025-12-31', 'CCDA-CG', 'Must be replaced by C-CDA Templates for Clinical Notes R2.1 Companion Guide, Release 4-US Realm, May 2023', array[165, 166, 170, 178, 180, 181]);

call openchpl.backfill_standards('170.205(a)(6)', 'HL7® CDA R2 Implementation Guide: C-CDA Templates for Clinical Notes R2.1 Companion Guide, Release 4-US Realm, May 2023', 5, '2024-02-08', '2025-12-31', null, 'CCDA-CG', null, array[165, 166, 170, 178, 180, 181]);

call openchpl.backfill_standards('170.205(b)(1)', 'NCPDP SCRIPT Standard, Implementation Guide, Version 2017071', 4, '2020-06-30', '2020-06-30', null, null, null, array[167]);

call openchpl.backfill_standards('170.205(d)(4)', 'HL7 2.5.1. Implementation specifications. PHIN Messaging Guide for Syndromic Surveillance: Emergency Department, Urgent Care, Inpatient and Ambulatory Care Settings, Release 2.0, April 21, 2015 and Erratum to the CDC PHIN 2.0 Implementation Guide, August 2015; Erratum to the CDC PHIN 2.0 Messaging Guide, April 2015 Release for Syndromic Surveillance: Emergency Department, Urgent Care, Inpatient and Ambulatory Care Settings.', 3, '2016-01-14', '2016-01-14', null, null, null, array[44]);

call openchpl.backfill_standards('170.205(e)(4)', 'HL7 2.5.1 (incorporated by reference in § 170.299). Implementation specifications. HL7 2.5.1 Implementation Guide for Immunization Messaging, Release 1.5 (incorporated by reference in § 170.299) and HL7 Version 2.5.1 Implementation Guide for Immunization Messaging (Release 1.5)—Addendum, July 2015 (incorporated by reference in § 170.299).', 3, '2016-01-14', '2016-01-14', null, null, null, array[43]);

call openchpl.backfill_standards('170.205(g)', 'HL7 2.5.1 (incorporated by reference in § 170.299). Implementation specifications. HL7 Version 2.5.1 Implementation Guide: Electronic Laboratory Reporting to Public Health, Release 1 (US Realm) (incorporated by reference in § 170.299) with Errata and Clarifications, (incorporated by reference in § 170.299) and ELR 2.5.1 Clarification Document for EHR Technology Certification, (incorporated by reference in § 170.299).', 3, '2016-01-14', '2016-01-14', null, null, null, array[45]);

call openchpl.backfill_standards('170.205(h)(2)', 'HL7 CDA® Release 2 Implementation Guide for: Quality Reporting Document Architecture – Category I (QRDA I); Release 1, DSTU Release 3 (US Realm), Volume 1', 3, '2016-01-14', '2016-01-14', null, null, null, array[25, 26, 27, 28]);

call openchpl.backfill_standards('170.205(h)(2)-Cures', 'HL7 CDA® Release 2 Implementation Guide for: Quality Reporting Document Architecture – Category I (QRDA I); Release 1, DSTU Release 3 (US Realm), Volume 1', 4, '2020-06-30', '2020-06-30', '2022-12-31', null, null, array[172]);

call openchpl.backfill_standards('170.205(h)(3)', 'CMS Implementation Guide for Quality Reporting Document Architecture: Category I; Hospital Quality Reporting; Implementation Guide for 2020', 4, '2020-06-30', '2020-06-30', null, null, null, array[172]);

call openchpl.backfill_standards('170.205(i)(2)', 'HL7 Implementation Guide for CDA© Release 2: Reporting to Public Health Cancer Registries from Ambulatory Healthcare Providers, Release 1, DSTU Release 1.1, April 2015', 3, '2016-01-14', '2016-01-14', null, null, null, array[46]);

call openchpl.backfill_standards('170.205(k)(1)', 'Quality Reporting Document Architecture Category III, Implementation Guide for CDA Release 2', 3, '2016-01-14', '2016-01-14', null, null, null, array[27, 28]);

call openchpl.backfill_standards('170.205(k)(1)-Cures', 'Quality Reporting Document Architecture Category III, Implementation Guide for CDA Release 2', 4, '2020-06-30', '2020-06-30', '2022-12-31', null, null, array[172]);

call openchpl.backfill_standards('170.205(k)(2)-Cures', 'Errata to the HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture—Category III, DSTU Release 1 (US Realm), September 2014', 4, '2020-06-30', '2020-06-30', '2022-12-31', null, null, array[172]);

call openchpl.backfill_standards('170.205(k)(2)', 'Errata to the HL7 Implementation Guide for CDA® Release 2: Quality Reporting Document Architecture—Category III, DSTU Release 1 (US Realm), September 2014', 3, '2016-01-14', '2016-01-14', null, null, null, array[27, 28]);

call openchpl.backfill_standards('170.205(k)(3)', 'CMS Implementation Guide for Quality Reporting Document Architecture: Category III; Eligible Clinicians and Eligible Professionals Programs; Implementation Guide for 2020', 4, '2020-06-30', '2020-06-30', null, null, null, array[172]);

call openchpl.backfill_standards('170.205(o)(1)', 'HL7 Implementation Guide: Data Segmentation for Privacy (DS4P), Release 1', 3, '2016-01-14', '2016-01-14', null, null, null, array[22, 23, 168, 169]);

call openchpl.backfill_standards('170.205(p)(1)', 'IHE IT Infrastructure Technical Framework Volume 2b (ITI TF- 2b)', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 165]);

call openchpl.backfill_standards('170.205(s)(1)', 'HL7 Implementation Guide for CDA Release 2: National Health Care Surveys (NHCS), Release 1 – US Realm, Draft Standard for Trial Use, December 2014', 3, '2016-01-14', '2016-01-14', null, null, null, array[49]);

call openchpl.backfill_standards('170.205(t)(3)', 'HL7 CDA® R2 Implementation Guide: Reportability Response, Release 1, STU Release 1.1—US Realm (HL7 CDA RR IG)', 5, '2024-02-08', '2025-12-31', null, 'F5-group-1', 'For receiving, consuming and processing a case report, must certify to HL7 FHIR eCR IG in § 170.205(t)(1) or the HL7 CDA RR IG in § 170.205(t)(3) as dependent on standard selected in paragraph 170.215(f)(5)(ii)(B).', array[47]);

call openchpl.backfill_standards('170.205(t)(4)', 'Reportable Conditions Trigger Codes Value Set for Electronic Case Reporting. RCTC OID: 2.16.840.1.114222.4.11.7508, Release March 29, 2022', 5, '2024-02-08', '2025-12-31', null, 'F5-group-1', 'Must certify to the Reportable Conditions Trigger Codes Cvalue Set for eCR.', array[47]);

--call openchpl.backfill_standards('170.207(a)(1)', 'IHTSDO SNOMED CT®, U.S. Edition, March 2022 Release', 5, '2024-02-08', '2024-02-08', null, 'SNOMED', null, array[12, 21, 28, 45, 46, 165]);

--call openchpl.backfill_standards('170.207(a)(3)', 'IHTSDO SNOMED CT® International Release July 31, 2012 and US Extension to SNOMED CT® March 2012', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'SNOMED', 'Must be updated to SNOMED CT, U.S. Edition, March 2022 Release', array[45]);

--call openchpl.backfill_standards('170.207(a)(4)', 'IHTSDO SNOMED CT®, U.S. Edition, September 2015 Release', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'SNOMED', 'Must be updated to SNOMED CT, U.S. Edition, March 2022 Release', array[6, 12, 16, 19, 20, 21, 28, 46, 165]);

--call openchpl.backfill_standards('170.207(c)(1)', 'LOINC® Database Version 2.72, February 16, 2022', 5, '2024-02-08', '2024-02-08', null, 'LOINC', null, array[45, 46]);

--call openchpl.backfill_standards('170.207(c)(2)', 'LOINC® Database version 2.40, Released July 2012', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'LOINC', 'Must be updated to LOINC Database Version 2.72, February 16, 2022', array[45]);

--call openchpl.backfill_standards('170.207(c)(3)', 'LOINC® Database version 2.52, Released June 2015', 3, '2016-01-14', '2016-01-14', '2025-12-31', 'LOINC', 'Must be updated to LOINC Database Version 2.72, February 16, 2022', array[46]);

--call openchpl.backfill_standards('170.207(d)(1)', 'RxNorm, July 5, 2022 Full Monthly Release', 5, '2024-02-08', '2024-02-08', null, 'RxNorm', null, array[167]);

--call openchpl.backfill_standards('170.207(d)(2)', 'RxNorm, August 6, 2012 Full Release Update', 3, '2016-01-14', '2016-01-14', '2022-12-31', 'RxNorm', null, array[18]);

--call openchpl.backfill_standards('170.207(d)(3)', 'RxNorm, September 8, 2015 Full Release Update', 4, '2020-06-30', '2022-12-31', '2024-02-08', 'RxNorm', 'Must be updated to RxNorm, July 5, 2022 Full Monthly Release', array[167]);

--call openchpl.backfill_standards('170.207(e)(1)', 'HL7 Standard Code Set CVX—Vaccines Administered, updates through June 15, 2022', 5, '2024-02-08', '2024-02-08', null, 'CVX', null, array[43]);

--call openchpl.backfill_standards('170.207(e)(2)', 'National Drug Code Directory (NDC)—Vaccine NDC Linker, updates through July 19, 2022', 5, '2024-02-08', '2024-02-08', null, 'NDC', null, array[43]);

--call openchpl.backfill_standards('170.207(e)(3)', 'HL7 Standard Code Set CVX— Vaccines Administered, updates through August 17, 2015', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'CVX', 'Must be updated to HL7 Standard Code Set CVX—Vaccines Administered, updates through June 15, 2022', array[43]);

--call openchpl.backfill_standards('170.207(e)(4)', 'National Drug Code (NDC) Directory– Vaccine NDC Linker, updates through August 17, 2015', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'NDC', 'Must be updated to National Drug Code Directory (NDC)—Vaccine NDC Linker, updates through July 19, 2022', array[43]);

--call openchpl.backfill_standards('170.207(f)(1)', 'The Office of Management and Budget Standards for Maintaining, Collecting, and Presenting Federal Data on Race and Ethnicity, Statistical Policy Directive No. 15, as revised, October 30, 1997', 3, '2016-01-14', '2016-01-14', null, null, null, array[5]);

--call openchpl.backfill_standards('170.207(f)(2)', 'CDC Race and Ethnicity Code Set Version 1.0 (March 2000)', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'Race and Ethnicity', 'Must be updated to CDC Race and Ethnicity Code Set Version 1.2 (July 15, 2021)', array[5, 28]);

--call openchpl.backfill_standards('170.207(f)(3)', 'CDC Race and Ethnicity Code Set Version 1.2 (July 15, 2021)', 5, '2024-02-08', '2024-02-08', null, 'Race and Ethnicity', null, array[5, 28]);

--call openchpl.backfill_standards('170.207(g)(2)', 'Request for Comments (RFC) 5646, “Tags for Identifying Languages,” September 2009', 3, '2016-01-14', '2016-01-14', null, null, null, array[5]);

--call openchpl.backfill_standards('170.207(n)(2)', 'Sex must be coded in accordance with, at a minimum, the version of SNOMED CT® codes specified in §170.207(a)(1)', 5, '2024-02-08', '2025-12-31', null, 'Sex Code Set', null, array[5, 28, 165]);

--call openchpl.backfill_standards('170.207(n)(3)', 'Sex Parameter for Clinical Use must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(1)', 5, '2024-02-08', '2025-12-31', null, null, null, array[5]);

--call openchpl.backfill_standards('170.207(o)(3)', 'Sexual Orientation and Gender Identity must be coded in accordance with, at a minimum, the version of SNOMED CT® codes specified in § 170.207(a)(1)', 5, '2024-02-08', '2025-12-31', null, 'SOGI', null, array[5]);

--call openchpl.backfill_standards('170.207(o)(4)', 'Pronouns must be coded in accordance with, at a minimum, the version of LOINC codes specified in 170.207(c)(1)', 5, '2024-02-08', '2025-12-31', null, null, null, array[5]);

--call openchpl.backfill_standards('170.207(p)(1)', 'Financial resource strain. Financial resource strain must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with the LOINC® code 76513-1 and LOINC® answer list ID LL3266-5.', 3, '2016-01-14', '2016-01-14', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(2)', 'Education. Education must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® code 63504-5 and LOINC® answer list ID LL1069-5.', 3, '2016-01-14', '2016-01-14', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(3)', 'Stress. Stress must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with the LOINC® code 76542-0 and LOINC® answer list LL3267-3.', 3, '2016-01-14', '2016-01-14', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(4)', 'Depression. Depression must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® codes 55757-9, 44250-9 (with LOINC® answer list ID LL358-3), 44255-8 (with LOINC® answer list ID LL358-3), and 55758-7 (with the answer coded with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)).', 5, '2024-02-08', '2024-02-08', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(4)-Original', 'Depression. Depression must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® codes 55757-9, 44250-9 (with LOINC® answer list ID LL358-3), 44255-8 (with LOINC® answer list ID LL358-3), and 55758-7 (with the answer coded with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)).', 3, '2016-01-14', '2016-01-14', '2024-02-08', null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(5)', 'Physical activity. Physical activity must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® codes 68515-6 and 68516-4. The answers must be coded with the associated applicable unit of measure in the standard specified in § 170.207(m)(2).', 5, '2024-02-08', '2024-02-08', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(5)-Original', 'Physical activity. Physical activity must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® codes 68515-6 and 68516-4. The answers must be coded with the associated applicable unit of measure in the standard specified in § 170.207(m)(1).', 3, '2016-01-14', '2016-01-14', '2024-02-08', null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(6)', 'Alcohol use must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(1) of this section and attributed with LOINC® codes 72109-2, 68518-0 (with LOINC® answer list ID LL2179-1), 68519-8 (with LOINC® answer list ID LL2180-9), 68520-6 (with LOINC® answer list ID LL2181-7), and 75626-2 (with the answer coded with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)).', 5, '2024-02-08', '2024-02-08', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(6)-Original', 'Alcohol use. Alcohol use must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with LOINC® codes 72109-2, 68518-0 (with LOINC® answer list ID LL2179-1), 68519-8 (with LOINC® answer list ID LL2180-9), 68520-6 (with LOINC® answer list ID LL2181-7), and 75626-2.', 3, '2016-01-14', '2016-01-14', '2024-02-08', null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(7)', 'Social connection and isolation. Social connection and isolation must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(1) of this section and attributed with the LOINC® codes 76506-5, 63503-7 (with LOINC® answer list ID LL1068-7), 76508-1 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)), 76509-9 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)), 76510-7 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)), 76511-5 (with LOINC answer list ID LL963-0), and 76512-3 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)).', 5, '2024-02-08', '2024-02-08', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(7)-Original', 'Social connection and isolation. Social connection and isolation must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with the LOINC® codes 76506-5, 63503-7 (with LOINC answer list ID LL1068-7), 76508-1 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)), 76509-9 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)), 76510-7 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)), 76511-5 (with LOINC answer list ID LL963-0), and 76512-3 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)).', 3, '2016-01-14', '2016-01-14', '2024-02-08', null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(8)', 'Exposure to violence (intimate partner violence). Exposure to violence: Intimate partner violence must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(1) of this section and attributed with the LOINC® code 76499-3, 76500-8 (with LOINC® answer list ID LL963-0), 76501-6 (with LOINC® answer list ID LL963-0), 76502-4 (with LOINC® answer list ID LL963-0), 76503-2 (with LOINC® answer list ID LL963-0), and 76504-0 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(2)).', 5, '2024-02-08', '2024-02-08', null, null, null, array[15]);

--call openchpl.backfill_standards('170.207(p)(8)-Original', 'Exposure to violence (intimate partner violence). Exposure to violence: intimate partner violence must be coded in accordance with, at a minimum, the version of LOINC® codes specified in § 170.207(c)(3) and attributed with the LOINC® code 76499-3, 76500-8 (with LOINC® answer list ID LL963-0), 76501-6 (with LOINC® answer list ID LL963-0), 76502-4 (with LOINC® answer list ID LL963-0), 76503-2 (with LOINC® answer list ID LL963-0), and 76504-0 (with the associated applicable unit of measure in the standard specified in § 170.207(m)(1)).', 3, '2016-01-14', '2016-01-14', '2024-02-08', null, null, array[15]);

--call openchpl.backfill_standards('170.207(q)(1)', 'International Telecommunication Union E.123: Notation for national and international telephone numbers, e-mail addresses and web addresses and International Telecommunication Union E.164: The international public telecommunication numbering plan', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 165]);

--call openchpl.backfill_standards('170.207(r)(1)', 'Crosswalk: Medicare Provider/Supplier to Healthcare Provider Taxonomy, April 2, 2015', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'Provider/Supplier Taxonomy', 'Must be updated to Crosswalk: Medicare Provider/Supplier to Healthcare Provider Taxonomy, October 29, 2021', array[28]);

--call openchpl.backfill_standards('170.207(r)(2)', 'Crosswalk: Medicare Provider/Supplier to Healthcare Provider Taxonomy, October 29, 2021', 5, '2024-02-08', '2024-02-08', null, 'Provider/Supplier Taxonomy', null, array[28]);

--call openchpl.backfill_standards('170.207(s)(1)', 'Public Health Data Standards Consortium Source of Payment Typology Code Set Version 5.0 (October 2011)', 3, '2016-01-14', '2016-01-14', '2024-02-08', 'Payment Typology', 'Must be updated to Public Health Data Standards Consortium Source of Payment Typology Code Set Version 9.2 (December 2020)', array[28]);

--call openchpl.backfill_standards('170.207(s)(2)', 'Public Health Data Standards Consortium Source of Payment Typology Code Set Version 9.2 (December 2020)', 5, '2024-02-08', '2024-02-08', null, 'Payment Typology', null, array[28]);

call openchpl.backfill_standards('170.210(a)(2)', 'Any encryption algorithm identified by the National Institute of Standards and Technology (NIST) as an approved security function in Annex A of the Federal Information Processing Standards (FIPS) Publication 140–2, October 8, 2014', 3, '2016-01-14', '2016-01-14', null, null, null, array[35, 37, 176]);

call openchpl.backfill_standards('170.210(c)(2)', 'A hashing algorithm with a security strength equal to or greater than SHA-2 as specified by NIST in FIPS Publication 180-4, Secure Hash Standard, 180-4 (August 2015).', 3, '2016-01-14', '2016-01-14', null, null, null, array[36, 37]);

call openchpl.backfill_standards('170.210(d)', 'Record treatment, payment, and health care operations disclosures. The date, time, patient identification, user identification, and a description of the disclosure must be recorded for disclosures for treatment, payment, and health care operations, as these terms are defined at 45 CFR 164.501.', 3, '2016-01-14', '2016-01-14', null, null, null, array[39]);

call openchpl.backfill_standards('170.210(e)(3)', 'The audit log must record the information specified in sections 7.1.1 and 7.1.7 of the standard specified at § 170.210(h) when the encryption status of electronic health information locally stored by EHR technology on end-user devices is changed. The date and time each action occurs in accordance with the standard specified at § 170.210(g).', 4, '2020-06-30', '2020-06-30', null, null, null, array[173, 174]);

call openchpl.backfill_standards('170.210(g)', 'The date and time recorded utilize a system clock that has been synchronized using any Network Time Protocol (NTP) standard.', 3, '2016-01-14', '2016-01-14', null, null, null, array[30, 31, 38, 40]);

call openchpl.backfill_standards('170.210(h)', 'Audit log content. ASTM E2147-18 Standard Specification for Audit and Disclosure Logs for Use in Health Information Systems.', 4, '2020-06-30', '2020-06-30', null, null, null, array[173, 174, 175]);

call openchpl.backfill_standards('170.213(a)', 'United States Core Data for Interoperability (USCDI), July 2020 Errata, Version 1', 4, '2020-06-30', '2020-06-30', '2025-12-31', 'USCDI', 'Must be replaced by United States Core Data for Interoperability (USCDI), October 2022 Errata, Version 3', array[165, 166, 178, 179, 180, 181, 182, 210]);

call openchpl.backfill_standards('170.213(b)', 'United States Core Data for Interoperability (USCDI), October 2022 Errata, Version 3', 5, '2024-02-08', '2025-12-31', null, 'USCDI', null, array[47, 165, 166, 178, 180, 181, 182, 210]);

call openchpl.backfill_standards('170.215(a)(1)', 'HL7® Version 4.0.1 FHIR® Release 4, October 30, 2019', 4, '2020-06-30', '2020-06-30', null, null, null, array[182]);

call openchpl.backfill_standards('170.215(a)(2)', 'HL7 FHIR® US Core Implementation Guide STU V3.1.1', 4, '2020-06-30', '2020-06-30', '2025-12-31', 'US Core', 'Must be updated to HL7 FHIR® US Core Implementation Guide STU 6.1.0', array[182]);

call openchpl.backfill_standards('170.215(a)(3)', 'HL7® SMART Application Launch Framework Implementation Guide Release 1.0.0', 4, '2020-06-30', '2020-06-30', '2025-12-31', 'SMART', 'Must be updated to HL7 SMART Application Launch Framework Implementation Guide Release 2.0.0', array[182]);

call openchpl.backfill_standards('170.215(a)(4)', 'HL7® FHIR® Bulk Data Access (Flat FHIR®) (V1.0.0:STU 1)', 4, '2020-06-30', '2020-06-30', null, null, null, array[182]);

call openchpl.backfill_standards('170.215(b)', 'OpenID Connect Core 1.0 incorporating errata set 1', 4, '2020-06-30', '2020-06-30', null, null, null, array[182]);

call openchpl.backfill_standards('170.215(b)(1)(ii)', 'HL7 FHIR® US Core Implementation Guide STU 6.1.0', 5, '2024-02-08', '2025-12-31', null, 'US Core', null, array[182]);

call openchpl.backfill_standards('170.215(c)(2)', 'HL7 SMART Application Launch Framework Implementation Guide Release 2.0.0', 5, '2024-02-08', '2025-12-31', null, 'SMART', null, array[182]);

call openchpl.backfill_standards('170.315(g)(3)(iv)', 'NISTIR 7742 Customized Common Industry Format Template for Electronic Health Record Usability Testing', 3, '2016-01-14', '2016-01-14', null, null, null, array[52]);

call openchpl.backfill_standards('170.205(r)(1)', 'The following sections of HL7 Implementation Guide for CDA® Release 2—Level 3: Healthcare Associated Infection Reports, Release 1, U.S. Realm (incorporated by reference in § 170.299 ). Technology is only required to conform to the following sections of the implementation guide: (i) HAI Antimicrobial Use and Resistance (AUR) Antimicrobial Resistance Option (ARO) Report (Numerator) specific document template in Section 2.1.2.1 (pages 69–72); (ii) Antimicrobial Resistance Option (ARO) Summary Report (Denominator) specific document template in Section 2.1.1.1 (pages 54–56); and (iii) Antimicrobial Use (AUP) Summary Report (Numerator and Denominator) specific document template in Section 2.1.1.2 (pages 56–58).', 3, '2016-01-14', '2016-01-14', null, null, null, array[48]);

call openchpl.backfill_standards('170.205(t)(1)', 'HL7 FHIR® Implementation Guide: Electronic Case Reporting (eCR)—US Realm 2.1.0—STU 2 US (HL7 FHIR eCR IG)', 5, '2024-02-08', '2025-12-31', null, 'F5-group-1', 'For creating a case report, must certify to the eICR profile of the HL7 FHIR eCR IG in § 170.205(t)(1) or (2) The HL7 CDA eICR IG in § 170.205(t)(2). If certifiying to the HL7 FHIR eCR IG for case report creation, must also certify to this standard for report receipt, consumption and processing.', array[47]);

call openchpl.backfill_standards('170.205(t)(2)', 'HL7 CDA® R2 Implementation Guide: Public Health Case Report—the Electronic Initial Case Report (eICR) Release 2, STU Release 3.1—US Realm (HL7 CDA eICR IG)', 5, '2024-02-08', '2025-12-31', null, 'F5-group-1', 'For creating a case report, must certify to the eICR profile of the HL7 FHIR eCR IG in § 170.205(t)(1) or (2) The HL7 CDA eICR IG in § 170.205(t)(2). If certifiying to the HL7 CDA eICR IG for case report creation, must also certify to HL7 CDA RR IG in § 170.205(t)(3) for report receipt, consumption and processing.', array[47]);


--call openchpl.backfill_standards('170.207(i)', 'Encounter diagnoses: The code set specified at 45 CFR 162.1002(c)(2) for the indicated conditions ICD-10-CM as maintained and distributed by HHS, for the following conditions:
--Diseases.
--Injuries.
--Impairments.
--Other health problems and their manifestations.
--Causes of injury, disease, impairment, or health problems.', 3, '2016-01-14', '2016-01-14', null, null, null, array[16, 19, 20, 21, 165]);


--call openchpl.backfill_standards('170.207(n)(1)', 'Birth sex must be coded in accordance with HL7 Version 3 Standard, Value Sets for AdministrativeGender and NullFlavor attributed as follows:
--Male. M; Female. F; Unknown. UNK', 3, '2016-01-14', '2016-01-14', '2025-12-31', 'Sex Code Set', 'Sex must be coded in accordance with, at a minimum, the version of SNOMED CT® codes specified in §170.207(a)(1)', array[5, 16, 28, 165]);


--call openchpl.backfill_standards('170.207(o)(1)', 'Sexual orientation must be coded in accordance with, at a minimum, the version of SNOMED CT® codes adopted at paragraph (a)(4) of this section for paragraphs (o)(1)(i) through (iii) of this section and HL7 Version 3 for paragraphs (o)(1)(iv) through (vi) of this section, attributed as follows:
--
--Lesbian, gay or homosexual. 38628009
--Straight or heterosexual. 20430005
--Bisexual. 42035005
--Something else, please describe. nullFlavor OTH
--Don’t know. nullFlavor UNK
--Choose not to disclose. nullFlavor ASKU', 3, '2016-01-14', '2016-01-14', '2025-12-31', 'SOGI', 'Sexual Orientation and Gender Identity must be coded in accordance with, at a minimum, the version of SNOMED CT® codes specified in §170.207(a)(1)', array[5]);

--call openchpl.backfill_standards('170.207(o)(2)', 'Gender identity must be coded in accordance with, at a minimum, the version of SNOMED CT® codes adopted at paragraph (a)(4) of this section for paragraphs (o)(2)(i) through (v) of this section and HL7 Version 3 for paragraphs (o)(2)(vi) and (vii) of this section, attributed as follows:
--
--Identifies as Male. 446151000124109
--Identifies as Female. 446141000124107
--Female-to-Male (FTM)/Transgender Male/Trans Man. 407377005
--Male-to-Female (MTF)/Transgender Female/Trans Woman. 407376001
--Genderqueer, neither exclusively male nor female. 446131000124102
--Additional gender category or other, please specify. nullFlavor OTH
--Choose not to disclose. nullFlavor ASKU', 3, '2016-01-14', '2016-01-14', '2025-12-31', 'SOGI', 'Sexual Orientation and Gender Identity must be coded in accordance with, at a minimum, the version of SNOMED CT® codes specified in §170.207(a)(1)', array[5]);


call openchpl.backfill_standards('170.210(e)(1)', '(i) The audit log must record the information specified in sections 7.1.1 and 7.1.2 and 7.1.6 through 7.1.9 of the standard specified in § 170.210(h) and changes to user privileges when health IT is in use (ii) The date and time must be recorded in accordance with the standard specified at § 170.210(g).', 4, '2020-06-30', '2020-06-30', null, null, null, array[173, 174, 175]);

call openchpl.backfill_standards('170.210(e)(2)', '(i) The audit log must record the information specified in sections 7.1.1 and 7.1.7 of the standard specified at § 170.210(h) when the audit log status is changed. (ii) The date and time each action occurs in accordance with the standard specified at § 170.210(g).', 4, '2020-06-30', '2020-06-30', null, null, null, array[173, 174]);

DROP PROCEDURE if exists openchpl.backfill_standards;
