ALTER TABLE openchpl.test_tool add column retired boolean NOT NULL DEFAULT false;
UPDATE openchpl.test_tool set retired = true where name = 'Transport Testing Tool';
UPDATE openchpl.test_tool set retired = true where name = 'Transport Test Tool';