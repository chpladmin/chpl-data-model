--Drop the column practice_type_id if it exists
ALTER TABLE openchpl.test_functionality DROP COLUMN IF EXISTS practice_type_id;
--Add the column practice_type_id to terst_functionality table
ALTER TABLE openchpl.test_functionality ADD COLUMN practice_type_id bigint DEFAULT null;
--Add the FK relation between test_functionality and practice_type
ALTER TABLE openchpl.test_functionality 
		ADD CONSTRAINT practice_type_fk 
		FOREIGN KEY (practice_type_id)
        REFERENCES openchpl.practice_type (practice_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

--Drop the column certification_criterion_id if it exists
ALTER TABLE openchpl.test_functionality DROP COLUMN IF EXISTS certification_criterion_id;
--Add the column certification_criterion_id to terst_functionality table
ALTER TABLE openchpl.test_functionality ADD COLUMN certification_criterion_id bigint DEFAULT null;
--Add the FK relation between test_functionality and certification_criterion_id
ALTER TABLE openchpl.test_functionality 
		ADD CONSTRAINT certification_criterion_fk 
		FOREIGN KEY (certification_criterion_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;
		
--Update the appropriate test_functionality records with practice type and certification criterion		
UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)')
WHERE test_functionality_id = 6; 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)')
WHERE test_functionality_id = 7;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)')
WHERE test_functionality_id = 8;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(8)')
WHERE test_functionality_id = 9;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(14)')
WHERE test_functionality_id = 10;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)')
WHERE test_functionality_id = 11;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)')
WHERE test_functionality_id = 12;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)')
WHERE test_functionality_id = 13;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 14;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 15;
-----------------
UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)')
WHERE test_functionality_id = 16;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)')
WHERE test_functionality_id = 17;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)')
WHERE test_functionality_id = 18;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)')
WHERE test_functionality_id = 19;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)')
WHERE test_functionality_id = 20;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)')
WHERE test_functionality_id = 21;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 22;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 23;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 24;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = 25;

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)')
WHERE test_functionality_id = 26;
------------------------
UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(4)')
WHERE test_functionality_id = 1;

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)')
WHERE test_functionality_id = 2;

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)')
WHERE test_functionality_id = 3;

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)')
WHERE test_functionality_id = 4;

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(7)')
WHERE test_functionality_id = 5;


