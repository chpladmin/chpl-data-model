CREATE FUNCTION openchpl.deleteDuplicateCertifiedProducts() RETURNS integer AS $$
DECLARE
	duplicates integer;
BEGIN
--see how many duplicates there are.
-- we expect 3 and we know which ones to delete.
-- if there are not 3, we should raise an error and not continue.
	SELECT count(*) 
	INTO duplicates
	from 
		(SELECT count(*), year, testing_lab_code, certification_body_code,vendor_code, product_code, version_code, 
			 ics_code, additional_software_code, certified_date_code
		FROM openchpl.certified_product_details
		where year in ('2014', '2015')
		and product_code is not null
		group by year, testing_lab_code, certification_body_code,vendor_code, product_code, version_code, 
			 ics_code, additional_software_code, certified_date_code
		having count(*) > 1) dups;

	IF duplicates <> 3 THEN
		RAISE EXCEPTION '% duplicate records were found - expecting to find 3', duplicates;
	ELSE
		RAISE NOTICE 'Found 3 duplicate records - marking 7703, 7704, and 8001 as deleted.';
		UPDATE openchpl.certified_product SET deleted = true where certified_product_id = 7703;
		UPDATE openchpl.certified_product SET deleted = true where certified_product_id = 7704;
		UPDATE openchpl.certified_product SET deleted = true where certified_product_id = 8001;
	END IF;
	
	RETURN duplicates;
END
$$ LANGUAGE plpgsql;

select openchpl.deleteDuplicateCertifiedProducts();

DROP FUNCTION openchpl.deleteDuplicateCertifiedProducts();
