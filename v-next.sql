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
--Update the appropriate test_functionality records with practice type and certification criterion		
UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(i)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(i)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(i)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(8)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(iii)(B)(3)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(14)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(vi)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(E)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(v)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(E)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(2)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(i)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Ambulatory'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)' AND certification_edition_id = 2);
-----------------
UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(ii)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(ii)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(ii)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(F)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(vi)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(F)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(3)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(ii)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(C)(2)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET practice_type_id = (SELECT practice_type_id FROM openchpl.practice_type WHERE name = 'Inpatient'), 
		certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(ii)' AND certification_edition_id = 2); 
------------------------
UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(4)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(iii)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(B)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(C)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)(B)' AND certification_edition_id = 2); 

UPDATE openchpl.test_functionality 
	SET certification_criterion_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(7)')
WHERE test_functionality_id = (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(7)(i)' AND certification_edition_id = 2); 




