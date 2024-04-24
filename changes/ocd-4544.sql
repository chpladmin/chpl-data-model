--
-- Add a column for 'display_value' that will be used for selection and display in the CHPL.
-- For existing optional standards this will match what is in the 'description' field.
-- New optional standards that are being added have different values in each column.
--
ALTER TABLE openchpl.optional_standard ADD COLUMN IF NOT EXISTS display_value text;

--
-- Allow citation and description to be null because some of the new optional standards have null values in those fields
--
ALTER TABLE openchpl.optional_standard ALTER COLUMN citation DROP NOT NULL;
ALTER TABLE openchpl.optional_standard ALTER COLUMN description DROP NOT NULL;

--
-- Existing Optional Standard Description Updates
--
UPDATE openchpl.optional_standard
SET description = 'SNOMED CT®'
WHERE id = 5;

UPDATE openchpl.optional_standard
SET description = 'USCDI v1 Procedures: CPT-4/HCPCS'
WHERE id = 13;

UPDATE openchpl.optional_standard
SET description = 'USCDI v1 Procedures: SNOMED CT®'
WHERE id = 12;

UPDATE openchpl.optional_standard
SET description = 'USCDI v1 Procedures: ICD-10-PCS'
WHERE id = 15;

UPDATE openchpl.optional_standard
SET description = 'USCDI v1 Procedures: CDT'
WHERE id = 14;

--
-- Copy the 'description' to the 'display_value'. These match for all optional standards that have not been added yet.
--
UPDATE openchpl.optional_standard os
SET display_value = (SELECT description FROM openchpl.optional_standard osInner WHERE osInner.id = os.id)
WHERE creation_date < '2024-04-23';

ALTER TABLE openchpl.optional_standard ALTER COLUMN display_value SET NOT NULL;

--
-- Optional Standard Additions:
--

--
-- Add USCDI v3 Procedures Ref: 170.207(b)(2) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 Procedures Ref: 170.207(b)(2)', 'Current Procedural Terminology, Fourth Edition (CPT-4)/Healthcare Common Procedure Coding System (HCPCS)', 'USCDI v3 Procedures: CPT-4/HCPCS', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(2)')
);

--
-- Add USCDI v3 Procedures Ref: 170.207(a)(1) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 Procedures Ref: 170.207(a)(1)', 'International Health Terminology Standards Development Organisation (IHTSDO) Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT® ), meeting the minimum requirements as outlined in regulation.', 'USCDI v3 Procedures: SNOMED CT®', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(a)(1)')
);

--
-- USCDI v3 Procedures Ref: 170.207(b)(4) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 Procedures Ref: 170.207(b)(4)', 'International Classification of Diseases ICD-10-PCS 2020', 'USCDI v3 Procedures: ICD-10-PCS', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(4)')
);

--
-- USCDI v3 Procedures Ref: 170.207(b)(3) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 Procedures Ref: 170.207(b)(3)', 'Code on Dental Procedures and Nomenclature (CDT)', 'USCDI v3 Procedures: CDT', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Procedures Ref: 170.207(b)(3)')
);

--
-- USCDI v3 SDOH Assessment Ref: 170.207(a)(1) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)', 'SNOMED International, Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT®) U.S. Edition, March 2022 Release', 'USCDI v3 SDOH Assessment: SNOMED CT®', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 SDOH Assessment Ref: 170.207(a)(1)')
);

--
-- USCDI v3 Medications Ref: 170.207(e)(2) to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (citation, description, display_value, last_modified_user)
SELECT 'USCDI v3 Medications Ref: 170.207(e)(2)', 'National Drug Code (NDC)', 'USCDI v3 Medications: NDC', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE citation = 'USCDI v3 Medications Ref: 170.207(e)(2)')
);

--
-- USCDI v3 SDOH Interventions: SNOMED CT®  to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (display_value, last_modified_user)
SELECT 'USCDI v3 SDOH Interventions: SNOMED CT®', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: SNOMED CT®')
);

--
--USCDI v3 SDOH Interventions: CPT® to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (display_value, last_modified_user)
SELECT 'USCDI v3 SDOH Interventions: CPT®', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: CPT®')
);

--
--USCDI v3 SDOH Interventions: HCPCS Level II to b1, b2, e1, f5, g6, and g9
--

INSERT INTO openchpl.optional_standard (display_value, last_modified_user)
SELECT 'USCDI v3 SDOH Interventions: HCPCS Level II', -1
WHERE NOT EXISTS (
	SELECT * 
	FROM openchpl.optional_standard 
	WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	165,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 165
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	166,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 166
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	178,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 178
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	179,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 179
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	180,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 180
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);

INSERT INTO openchpl.optional_standard_criteria_map (optional_standard_id, criterion_id, last_modified_user)
SELECT 
	(SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II'),
	181,
	-1
WHERE NOT EXISTS (
	SELECT *
	FROM openchpl.optional_standard_criteria_map
	WHERE criterion_id = 181
	AND optional_standard_id = (SELECT id FROM openchpl.optional_standard 
		WHERE display_value = 'USCDI v3 SDOH Interventions: HCPCS Level II')
);
