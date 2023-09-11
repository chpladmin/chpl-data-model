DO $$
DECLARE _citation_text_array text[] := array['170.102(13)(ii)(C)', '170.102(19)(i)', '170.102(19)(ii)'];
DECLARE _citation_text text;

DECLARE  _rec_count integer;

DECLARE _functionality_tested_id bigint;
DECLARE _optional_standard_id bigint;
DECLARE _optional_standard_criteria_map_id bigint;
DECLARE _certification_result_optional_standard_id bigint;

DECLARE _functionality_tested_record record;
DECLARE _functionality_tested_criteria_map_record record;
DECLARE _optional_standard_criteria_map_record record;
DECLARE _certification_result_functionality_tested_record record;
DECLARE _certification_result_optional_standard_record record;
DECLARE _result_record record;

BEGIN
	FOREACH _citation_text IN ARRAY _citation_text_array
	LOOP
		--If this FT has already been converted, skip
		SELECT into _functionality_tested_id id
		FROM openchpl.functionality_tested
		WHERE regulatory_text_citation = _citation_text;
	
		IF _functionality_tested_id IS NOT NULL THEN
			--Determine if the optional statdard exists...
			SELECT INTO _optional_standard_id id
			FROM openchpl.optional_standard
			WHERE citation = _citation_text;
		
			IF _optional_standard_id IS NULL THEN
					
				SELECT INTO _functionality_tested_record * 
				FROM openchpl.functionality_tested
				WHERE regulatory_text_citation = _citation_text;
				
				INSERT INTO openchpl.optional_standard (
					citation, 
					description, 
					last_modified_user)
				VALUES (
					_functionality_tested_record.regulatory_text_citation, 
					_functionality_tested_record.value, 
					-1)
				RETURNING id INTO _optional_standard_id;
				RAISE NOTICE 'INSERTING optional_standard ';
				RAISE NOTICE 'optional_standard_id = %', _optional_standard_id;
			ELSE
				RAISE NOTICE 'optional_standard already exists';
			END IF;
				
			--Handle creating the optional_standard_criteria_map
			FOR _functionality_tested_criteria_map_record IN
				SELECT * 
				FROM openchpl.functionality_tested_criteria_map
				WHERE functionality_tested_id = (
					SELECT id
					FROM openchpl.functionality_tested
					WHERE regulatory_text_citation = _citation_text)
			LOOP 
				SELECT INTO _optional_standard_criteria_map_id id
				FROM openchpl.optional_standard_criteria_map
				WHERE optional_standard_id = _optional_standard_id
				AND criterion_id = _functionality_tested_criteria_map_record.criteria_id;
			
				IF _optional_standard_criteria_map_id IS NULL THEN
					INSERT INTO openchpl.optional_standard_criteria_map (
						optional_standard_id, 
						criterion_id, 
						last_modified_user)
					VALUES (
						_optional_standard_id,
						_functionality_tested_criteria_map_record.criteria_id,
						-1)
					RETURNING id INTO _optional_standard_criteria_map_id;
		
					RAISE NOTICE 'INSERTING optional_standard_criteria_map';
					RAISE NOTICE 'optional_standard_criteria_map_id = %', _optional_standard_criteria_map_id;
				ELSE
					RAISE NOTICE 'optional_standard_criteria_map already exists';
				END IF;
			END LOOP;
			
			--Handle creating certification_result_optional_standard records
			FOR _certification_result_functionality_tested_record IN 
				SELECT crft.*, cr.certification_criterion_id , cr.certified_product_id
				FROM openchpl.certification_result_functionality_tested crft
					INNER JOIN openchpl.certification_result cr
						ON crft.certification_result_id  = cr.certification_result_id 
				WHERE crft.deleted = false
				AND crft.functionality_tested_id = (
					SELECT id
					FROM openchpl.functionality_tested
					WHERE regulatory_text_citation = _citation_text)
			LOOP
				--Does the optional standard exist for the listing/criteria?
				SELECT INTO _certification_result_optional_standard_id  cros.id 
				FROM openchpl.certification_result_optional_standard cros
					INNER JOIN openchpl.certification_result cr
						ON cros.certification_result_id  = cr.certification_result_id 
				WHERE cros.optional_standard_id = _optional_standard_id
				AND cr.certified_product_id = _certification_result_functionality_tested_record.certified_product_id
				AND cr.certification_criterion_id  = _certification_result_functionality_tested_record.certification_criterion_id;
				
				IF _certification_result_optional_standard_id IS NULL THEN
					INSERT INTO openchpl.certification_result_optional_standard (
						certification_result_id, 
						optional_standard_id, 
						last_modified_user)
					VALUES (
						_certification_result_functionality_tested_record.certification_result_id,
						_optional_standard_id,
						-1)
					RETURNING id INTO _certification_result_optional_standard_id;
					
					select into _result_record cpd.chpl_product_number, cc."number", os.citation 
					from openchpl.certified_product_details cpd
						inner join openchpl.certification_result cr
							on cpd.certified_product_id = cr.certified_product_id
						inner join openchpl.certification_result_optional_standard cros
							on cr.certification_result_id = cros.certification_result_id 
						inner join openchpl.optional_standard os
							on cros.optional_standard_id = os.id 
						inner join openchpl.certification_criterion cc 
							on cc.certification_criterion_id = cr.certification_criterion_id
					where cros.id  = _certification_result_optional_standard_id;
					
				
					RAISE NOTICE 'INSERTING certification_result_optional_standard for  % | % | %', 
						_result_record.chpl_product_number, 
						_result_record.number,
						_result_record.citation;
				ELSE
					RAISE NOTICE 'ALREADY EXISTS certification_result_optional_standard for  % | % | %', 
						_certification_result_optional_standard_record.chpl_product_number, 
						_certification_result_optional_standard_record.number,
						_certification_result_optional_standard_record.citation;
				END IF;
				
			END LOOP;
		
			--DELETE the functionality tested from functionality_tested, functionality_tested_criteria_map, certification_result_functionality_tested 
			DELETE FROM openchpl.certification_result_functionality_tested
			WHERE functionality_tested_id = _functionality_tested_id;
			
			GET DIAGNOSTICS _rec_count = ROW_COUNT;
			RAISE NOTICE 'certification_result_functionality_tested rows deleted: %', _rec_count;
						
			DELETE FROM openchpl.functionality_tested_criteria_map
			WHERE functionality_tested_id = _functionality_tested_id;
			
			GET DIAGNOSTICS _rec_count = ROW_COUNT;
			RAISE NOTICE 'functionality_tested_criteria_map rows deleted: %', _rec_count;
			
			DELETE FROM openchpl.functionality_tested
			WHERE id = _functionality_tested_id;
		
			GET DIAGNOSTICS _rec_count = ROW_COUNT;
			RAISE NOTICE 'functionality_tested rows deleted: %', _rec_count;
		
		ELSE 
			RAISE NOTICE 'Functionality Tested % has already been converted', _citation_text;
		END IF;
	END LOOP;

	--Add optional standards as a criteria attribute on (b)(4) and (b)(5)
	update openchpl.certification_criterion_attribute
	set optional_standard = true
	where criterion_id in (19, 20);

	GET DIAGNOSTICS _rec_count = ROW_COUNT;
	RAISE NOTICE 'certification_criterion_attribute rows updated to allow optional standards: %', _rec_count;

	--Remove Functionality tested as a criteria attribute on (b)(5)
	update openchpl.certification_criterion_attribute
	set optional_standard = true
	where criterion_id in (20);

	GET DIAGNOSTICS _rec_count = ROW_COUNT;
	RAISE NOTICE 'certification_criterion_attribute rows updated to not allow functionality tested: %', _rec_count;
		
END $$;