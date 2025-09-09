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

--
-- Associate the Gap Conformane Method with criteria
--

-- b1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	165, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 165
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- b2
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	166, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 166
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- b9
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	170, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 170
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- e1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	178, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 178
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

-- f1
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	43, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 43
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--f3
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	45, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 45
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--f4
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	46, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 46
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g6
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	180, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 180
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g9
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	181, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 181
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);

--g10
INSERT INTO openchpl.conformance_method_criteria_map (conformance_method_id, criteria_id, last_modified_sso_user)
SELECT (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation'),
	182, 
	'6498c4f8-b0f1-70b5-55de-d84faae73402'
WHERE NOT EXISTS (
	SELECT * FROM openchpl.conformance_method_criteria_map WHERE criteria_id = 182
	AND conformance_method_id = (SELECT id FROM openchpl.conformance_method WHERE name = 'Gap certification via 2025 Attestation')
);
