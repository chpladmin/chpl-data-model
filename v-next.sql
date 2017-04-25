------------------------------------------------------------
-- OCD-1433 - Find any current products that have bad values
------------------------------------------------------------
DO $$
BEGIN
raise notice 'Updating openchpl.certification_result and openchpl.pending_certification_result to remove whitespace from privacy_security_framework';
END; 
$$;

BEGIN;
UPDATE openchpl.certification_result
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;

BEGIN;
UPDATE openchpl.pending_certification_result 
SET privacy_security_framework = TRIM(both ' ' from privacy_security_framework);
END;
---------------------- certified products with bad data

DO $$
BEGIN
raise notice 'The following certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT cr.certified_product_id, cc.number, cr.privacy_security_framework
FROM openchpl.certification_result cr
LEFT JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
WHERE cr.privacy_security_framework IS NOT NULL
AND cr.privacy_security_framework <> ''
AND cr.privacy_security_framework NOT IN ('Approach 1', 'Approach 2', 'Approach 1;Approach 2');

---------------------- pending products with bad data
DO $$
BEGIN
raise notice 'The following pending_certified_product_id have bad values not in the set of Approach 1, Approach 2, or Approach 1;Approach 2';
END; 
$$;

SELECT pr.pending_certified_product_id, cc.number, pr.privacy_security_framework
FROM openchpl.pending_certification_result pr
LEFT JOIN openchpl.certification_criterion cc ON pr.certification_criterion_id = cc.certification_criterion_id
WHERE pr.privacy_security_framework IS NOT NULL 
AND pr.privacy_security_framework <> ''
AND pr.privacy_security_framework NOT IN ('Approach 1', 'Approach 2', 'Approach 1;Approach 2');
