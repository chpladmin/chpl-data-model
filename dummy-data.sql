-- OCD-3261

-- insert optional standard data
insert into openchpl.optional_standard (name, description, last_modified_user) values
('OS 1', 'Fake Optional Standard 1', -1),
('Optional Standard 2', 'Fake Optional Standard 2', -1),
('Standard 3', 'Fake Optional Standard 3', -1),
('Newest Optional Standard 4', 'Fake Optional Standard 4', -1);

-- add rows for criteria that don't yet have attributes
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 8, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 8); --a8
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9); --a9
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 12, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 12); --a12

-- update data for new attribute
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 8; --a8
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 9; --a9
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 12; --a12
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 21; --b6
