--
-- Remove Conformance method "Attestation" association with f3 criterion.
-- It used to be allowed if GAP was "true" for f3.
--
UPDATE openchpl.conformance_method_criteria_map
SET deleted = true
WHERE criteria_id = 45 -- f3
AND conformance_method_id = 1; -- Attestation

--
-- Add new Conformance Method
--
INSERT INTO openchpl.conformance_method (name, last_modified_sso_user)
SELECT 'Gap certification via 2025 Attestation', '6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'
);

-- The association between the new conformance method and allowed criteria will be done in the UI by the ADMIN 
