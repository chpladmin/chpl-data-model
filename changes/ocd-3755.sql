-- OCD-3755

TRUNCATE openchpl.pending_certification_result_optional_standard;
TRUNCATE openchpl.certification_result_optional_standard;
TRUNCATE openchpl.optional_standard_criteria_map CASCADE;
TRUNCATE openchpl.optional_standard CASCADE;

-- insert optional standard data
insert into openchpl.optional_standard (citation, description, last_modified_user) values
('170.204(a)(1)', 'WCAG 2.0, Level A Conformance', -1),
('170.204(a)(2)', 'WCAG 2.0, Level AA Conformance', -1),
('170.204(b)(3)', 'HL7® V3 IG: Context-Aware Information Retrieval (Infobutton) SOA, R1', -1),
('170.204(b)(4)', 'HL7® Version 3 IG: Context-Aware Knowledge Retrieval (Infobutton), Release 4', -1),
('170.207(a)(4)', 'SNOMED CT® U.S. Edition, September 2019 Release', -1),
('170.207(i)', 'ICD-10-CM', -1),
('170.207(i) Encounter Diagnosis', 'ICD-10-CM Encounter Diagnosis', -1),
('CCDS Ref: 170.207(a)(4)', 'SNOMED CT® U.S. Edition, September 2019 Release', -1),
('CCDS Ref: 170.207(b)(2)', 'CPT-4/HCPCS', -1),
('CCDS Ref: 170.207(b)(3)', 'Current Dental Terminology (CDT)', -1),
('CCDS Ref: 170.207(b)(4)', 'ICD-10-PCS', -1),
('USCDI Ref: 170.207(a)(4)', 'SNOMED CT® U.S. Edition, September 2019 Release', -1),
('USCDI Ref: 170.207(b)(2)', 'CPT-4/HCPCS', -1),
('USCDI Ref: 170.207(b)(3)', 'Code on Dental Procedures and Nomenclature (CDT)', -1),
('USCDI Ref: 170.207(b)(4)', 'ICD-10-PCS 2020', -1);

-- add rows for criteria that don't yet have attributes
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9); --a9
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 13, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 13); --a13
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 16, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 16); --b1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 165, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 165); --b1 cures
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 166, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 166); --b2 cures
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 21, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 21); --b6
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 40, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 40); --e1
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 178, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 178); --e1 cures
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 47, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 47); --f5
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 179, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 179); --f5 cures
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 55, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 55); -- g6
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 180, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 180); --g6 cures
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 57, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 57); -- g8
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 58, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 58); -- g9
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 181, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 181); -- g9 cures

-- set all optional standards to false
update openchpl.certification_criterion_attribute set optional_standard = false;

-- update data for new attribute
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 9; --a9
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 13; --a13
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 16; --b1
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 165; --b1 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 166; --b2 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 21; --b6
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 40; --e1
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 178; --e1 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 47; --f5
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 179; --f5 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 55; --g6
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 180; --g6 cures
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 57; --g8
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 58; --g9
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 181; --g9 cures

-- add mappings for optional standards to criteria
-- TODO ---
--a9
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(b)(3)'), 9, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(b)(3)') 
		and criterion_id = 9);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(b)(4)'), 9, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(b)(4)') 
		and criterion_id = 9);	
-- a13
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(b)(3)'), 13, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(b)(3)') 
		and criterion_id = 13);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(b)(4)'), 13, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(b)(4)') 
		and criterion_id = 13);	
-- b1
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(a)(4)'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(a)(4)') 
		and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis') 
		and criterion_id = 16);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 16);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 16);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 16);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 16, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 16);
-- b1 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(a)(4)'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(a)(4)') 
		and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis') 
		and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 165);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 165);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 165, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 165);	
-- b2 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 166, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 166);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 166, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 166);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 166, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 166);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 166, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 166);
-- b6
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(a)(4)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(a)(4)') 
		and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(i)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(i)') 
		and criterion_id = 21);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 21);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 21);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 21);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 21, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 21);
-- e1
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(a)(1)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(a)(1)') 
		and criterion_id = 40);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(a)(2)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(a)(2)') 
		and criterion_id = 40);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 40);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 40);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 40);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 40, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 40);
-- e1 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(a)(1)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(a)(1)') 
		and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.204(a)(2)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.204(a)(2)') 
		and criterion_id = 178);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 178);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 178);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 178);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 178, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 178);
-- f5
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(a)(4)'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(a)(4)') 
		and criterion_id = 47);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis') 
		and criterion_id = 47);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 47);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 47);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 47);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 47, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 47);
-- f5 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(a)(4)'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(a)(4)') 
		and criterion_id = 179);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = '170.207(i) Encounter Diagnosis') 
		and criterion_id = 179);
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 179);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 179);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 179);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 179, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 179);
-- g6
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 55, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 55);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 55, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 55);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 55, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 55);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 55, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 55);
-- g6 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 180, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 180);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 180, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 180);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 180, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 180);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 180, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 180);
-- g8
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 57, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 57);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 57, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 57);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 57, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 57);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 57, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 57);
-- g9
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)'), 58, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(a)(4)') 
		and criterion_id = 58);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)'), 58, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(2)') 
		and criterion_id = 58);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)'), 58, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(3)') 
		and criterion_id = 58);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)'), 58, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'CCDS Ref: 170.207(b)(4)') 
		and criterion_id = 58);
-- g9 cures
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)'), 181, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(a)(4)') 
		and criterion_id = 181);		
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)'), 181, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(2)') 
		and criterion_id = 181);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)'), 181, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(3)') 
		and criterion_id = 181);			
insert into openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user) 
	select (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)'), 181, -1 
	where not exists 
		(select * from openchpl.optional_standard_criteria_map 
		where optional_standard_id = (select id from openchpl.optional_standard where citation = 'USCDI Ref: 170.207(b)(4)') 
		and criterion_id = 181);		