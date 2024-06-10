\echo 'loading views'
\i dev/openchpl_views.sql

\echo 'active certificates that attested to d7 and used functionality tested d7ii - pre'
\copy (select distinct cpd.certified_product_id from openchpl.certified_product_details cpd join openchpl.certification_result cr on cpd.certified_product_id = cr.certified_product_id and cr.success = true and cr.deleted = false join openchpl.certification_result_functionality_tested crft on crft.certification_result_id = cr.certification_result_id and crft.deleted = false where cr.success = true and cr.certification_criterion_id = 35 and crft.functionality_tested_id = 41 and cpd.deleted = false and cpd.certification_status_id in (1,6,7)) to d7_with_d7ii.csv with csv header

\echo 'active certificates that attested to d7 and did not use functionality tested d7ii - pre'
\copy (select distinct cpd.certified_product_id from openchpl.certified_product_details cpd join openchpl.certification_result cr on cpd.certified_product_id = cr.certified_product_id and cr.success = true and cr.deleted = false join openchpl.certification_result_functionality_tested crft on crft.certification_result_id = cr.certification_result_id and crft.deleted = false where cr.success = true and cr.certification_criterion_id = 35 and crft.functionality_tested_id <> 41 and cpd.deleted = false and cpd.certification_status_id in (1,6,7)) to d7_without_d7ii.csv with csv header

\echo 'active certificates that attested to d12 and had "Attestation" as "No" - pre'
\copy (select distinct cpd.certified_product_id from openchpl.certified_product_details cpd join openchpl.certification_result cr on cpd.certified_product_id = cr.certified_product_id and cr.success = true and cr.deleted = false where cr.success = true and cr.certification_criterion_id = 176 and cr.attestation_answer = 'No' and cpd.deleted = false and cpd.certification_status_id in (1,6,7)) to d12_with_attestation_yes.csv with csv header

\echo 'active certificates that attested to d12 and had "Attestation" as "Yes" - pre'
\copy (select distinct cpd.certified_product_id from openchpl.certified_product_details cpd join openchpl.certification_result cr on cpd.certified_product_id = cr.certified_product_id and cr.success = true and cr.deleted = false where cr.success = true and cr.certification_criterion_id = 176 and cr.attestation_answer = 'Yes' and cpd.deleted = false and cpd.certification_status_id in (1,6,7)) to d12_with_attestation_no.csv with csv header

\echo 'active certificates that attested to d9 - pre'
\copy (select distinct cpd.certified_product_id from openchpl.certified_product_details cpd join openchpl.certification_result cr on cpd.certified_product_id = cr.certified_product_id and cr.success = true and cr.deleted = false where cr.success = true and cr.certification_criterion_id = 37 and cpd.deleted = false and cpd.certification_status_id in (1,6,7)) to d9.csv with csv header

\echo 'removing certification_result_standard mappings'
delete from openchpl.certification_result_standard crs
  where crs.standard_id = 29;

\echo 'removing mappings of standards to criteria'
delete from openchpl.standard_criteria_map scm
  where scm.standard_id = 29
  and scm.certification_criterion_id in (35, 37, 176);

\echo 'removing standard'
delete from openchpl.standard s
  where s.id = 29;

\echo 'adding optional standard'
insert into openchpl.optional_standard (citation, description, last_modified_user, display_value)
  select '170.210(a)(2)', 'Any encryption algorithm identified by the National Institute of Standards and Technology (NIST) as an approved security function in Annex A of the Federal Information Processing Standards (FIPS) Publication 140–2, October 8, 2014', -1, 'Any encryption algorithm identified by the National Institute of Standards and Technology (NIST) as an approved security function in Annex A of the Federal Information Processing Standards (FIPS) Publication 140–2, October 8, 2014'
    where not exists (select * from openchpl.optional_standard where citation = '170.210(a)(2)');

\echo 'adding optional_standard - criterion mapping'
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
  select (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)'), 35, -1
    where not exists (select * from openchpl.optional_standard_criteria_map
                       where optional_standard_id = (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)')
                             and criterion_id = 35);

insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
  select (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)'), 37, -1
    where not exists (select * from openchpl.optional_standard_criteria_map
                       where optional_standard_id = (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)')
                             and criterion_id = 37);

insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
  select (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)'), 176, -1
    where not exists (select * from openchpl.optional_standard_criteria_map
                       where optional_standard_id = (select id from openchpl.optional_standard os where os.citation = '170.210(a)(2)')
                             and criterion_id = 176);
