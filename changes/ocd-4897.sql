-- Conformance method "Attestation" is no longer allowed for f5 criteria. It used to be allowed if GAP was true on that criteria

UPDATE openchpl.conformance_method_criteria_map
SET deleted = true
WHERE criteria_id = 45 -- f5
AND conformance_method_id = 1; -- Attestation
