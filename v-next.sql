--Drop the column practice_type_id if it exists
ALTER TABLE openchpl.test_functionality DROP COLUMN IF EXISTS practice_type_id;
--Add the column practice_type_id to terst_functionality table
ALTER TABLE openchpl.test_functionality ADD COLUMN practice_type_id bigint DEFAULT null;
--Add the FK relation between test_functionality amd practice_type
ALTER TABLE openchpl.test_functionality 
		ADD CONSTRAINT practice_type_fk 
		FOREIGN KEY (practice_type_id)
        REFERENCES openchpl.practice_type (practice_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

--Update the appropriate test_functionality records with practice type		
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 6;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 7;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 8;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 9;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 10;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 11;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 12;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 13;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 14;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 15;
UPDATE openchpl.test_functionality SET practice_type_id = 1 WHERE test_functionality_id = 16;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 17;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 18;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 19;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 20;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 21;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 22;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 23;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 24;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 25;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 26;
UPDATE openchpl.test_functionality SET practice_type_id = 2 WHERE test_functionality_id = 27;

