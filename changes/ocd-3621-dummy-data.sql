-- OCD-3261

-- insert optional standard data
insert into openchpl.optional_standard (citation, description, last_modified_user) values
('170.204(b)(3)', 'HL7® V3 IG: Context-Aware Information Retrieval (Infobutton) SOA, R1', -1),
('170.204(b)(4)', 'HL7® V3 IG: Context-Aware Knowledge Retrieval (Infobutton), R4', -1),
('170.205(a)(3)', 'HL7® IG for CDA® R2: IHE Health Story Consolidation, DSTU R1.1', -1),
('170.205(a)(5)', 'HL7® CDA® R2.1 IG: C-CDA Templates for Clinical Notes', -1),
('170.205(a)(5)', 'HL7® CDA® R2 IG: C-CDA Templates for Clinical Notes R2.1 Companion Guide, R2', -1),
('170.207(a)(4)', 'SNOMED CT® U.S. Edition, September 2019 Release', -1),
('TBD-1', 'SNOMED CT® U.S. Edition, September 2015 Release', -1),
('TBD-2', 'ICD-10-CM', -1),
('170.204(a)(1)', 'WCAG 2.0, Level A Conformance', -1),
('170.204(a)(2)', 'WCAG 2.0, Level AA Conformance', -1),
('170.207(i)', 'TBD', -1);

-- add rows for criteria that don't yet have attributes
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9); --a9
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 13, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 13); --a13
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 16, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 16); --b1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 21, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 21); --b6
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 40, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 40); --e1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 47, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 47); --f5
--2014
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 61, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 61);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 62, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 62);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 63, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 63);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 64, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 64);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 65, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 65);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 66, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 66);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 67, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 67);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 68, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 68);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 69, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 69);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 70, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 70);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 71, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 71);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 72, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 72);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 73, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 73);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 74, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 74);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 75, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 75);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 76, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 76);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 77, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 77);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 78, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 78);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 79, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 79);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 80, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 80);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 81, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 81);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 82, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 82);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 83, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 83);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 84, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 84);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 85, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 85);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 86, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 86);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 87, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 87);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 88, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 88);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 89, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 89);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 90, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 90);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 91, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 91);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 92, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 92);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 93, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 93);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 94, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 94);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 95, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 95);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 96, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 96);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 97, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 97);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 98, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 98);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 99, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 99);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 100, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 100);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 101, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 101);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 102, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 102);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 103, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 103);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 104, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 104);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 105, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 105);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 106, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 106);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 107, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 107);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 108, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 108);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 109, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 109);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 110, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 110);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 111, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 111);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 112, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 112);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 113, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 113);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 114, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 114);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 115, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 115);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 116, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 116);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 117, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 117);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 118, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 118);
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 119, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 119);

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
--2014
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 61;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 62;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 63;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 64;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 65;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 66;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 67;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 68;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 69;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 70;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 71;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 72;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 73;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 74;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 75;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 76;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 77;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 78;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 79;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 80;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 81;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 82;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 83;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 84;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 85;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 86;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 87;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 88;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 89;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 90;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 91;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 92;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 93;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 94;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 95;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 96;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 97;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 98;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 99;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 100;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 101;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 102;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 103;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 104;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 105;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 106;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 107;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 108;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 109;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 110;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 111;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 112;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 113;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 114;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 115;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 116;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 117;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 118;
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 119;

-- add mappings for optional standards to criteria
--a9
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 1, 9, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 1 and criterion_id = 9);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 2, 9, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 2 and criterion_id = 9);
--a13
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 1, 13, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 1 and criterion_id = 13);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 2, 13, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 2 and criterion_id = 13);
--b1
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 3, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 3 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 5, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 5 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 11, 16, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 11 and criterion_id = 16);
--b1 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 3, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 3 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 11, 165, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 11 and criterion_id = 165);
--b6
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 7, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 7 and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 8, 21, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 8 and criterion_id = 21);
--e1
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 9, 40, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 9 and criterion_id = 40);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 40, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 40);
--e1 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 9, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 9 and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 4, 178, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 4 and criterion_id = 178);
--f5
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 6, 47, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 6 and criterion_id = 47);
--g8
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 57, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 57);
--g9
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) select 10, 58, -1 where not exists (select * from openchpl.optional_standard_criteria_map where optional_standard_id = 10 and criterion_id = 58);
