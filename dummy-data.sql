-- OCD-3261

-- insert optional standard data
insert into openchpl.optional_standard (optional_standard, last_modified_user) values
('HL7® V3 IG: Context-Aware Information Retrieval (Infobutton) SOA, R1', -1),
('HL7® V3 IG: Context-Aware Knowledge Retrieval (Infobutton), R4', -1),
('HL7® IG for CDA® R2: IHE Health Story Consolidation, DSTU R1.1 ', -1),
('HL7® CDA® R2.1 IG: C-CDA Templates for Clinical Notes', -1),
('HL7® CDA® R2 IG: C-CDA Templates for Clinical Notes R2.1 Companion Guide, R2', -1),
('SNOMED CT® U.S. Edition, September 2019 Release', -1),
('SNOMED CT® U.S. Edition, September 2015 Release', -1),
('ICD-10-CM', -1),
('WCAG 2.0, Level A Conformance', -1),
('WCAG 2.0, Level AA Conformance', -1);

-- add rows for criteria that don't yet have attributes
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9); --a9
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 13, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 13); --a13
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 16, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 16); --b1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 21, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 21); --b6
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 40, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 40); --e1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 47, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 47); --f5

-- update data for new attribute
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 9; --a9
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 13; --a13
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 16; --b1
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 165; --b1 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 21; --b6
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 40; --e1
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 178; --e1 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 47; --f5
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 57; --g8
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 58; --g9

-- add mappings for optional standards to criteria
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 1, 9, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 1 and criterion_id = 9);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 2, 9, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 2 and criterion_id = 9);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 1, 13, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 1 and criterion_id = 13);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 2, 13, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 2 and criterion_id = 13);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 3, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 3 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 3, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 3 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 5, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 5 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 7, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 7 and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 8, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 8 and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 9, 40, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 9 and criterion_id = 40);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 9, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 9 and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 40, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 40);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 47, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 47);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 57, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 57);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 58, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 58);
