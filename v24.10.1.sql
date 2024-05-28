-- Deployment file for version 24.10.1
--     as of 2024-05-28
-- ./changes/ocd-4544.sql
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
;
-- ./changes/ocd-4563.sql
INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'RWT Plans URL Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'RWT Plans URL Changed'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'RWT Results URL Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'RWT Results URL Changed'
);

INSERT INTO openchpl.subscription_subject (subscription_object_type_id, subject, last_modified_user)
SELECT 1, 'Service Base URL List Changed', -1
WHERE NOT EXISTS (
	SELECT id FROM openchpl.subscription_subject WHERE subject = 'Service Base URL List Changed'
);

-- Add these subjects to existing listing subscriptions
DROP FUNCTION IF EXISTS openchpl.create_missing_subscriptions_for_new_subjects();
CREATE FUNCTION openchpl.create_missing_subscriptions_for_new_subjects()
  RETURNS void AS $$
	DECLARE
		unique_subscription_rec record;
		subject_id bigint;
	BEGIN
		FOR unique_subscription_rec IN
			SELECT DISTINCT subscriber_id, subscribed_object_id, creation_date FROM openchpl.subscription
		LOOP
		
			-- RWT Plans URL Subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'RWT Plans URL Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
		
			-- RWT Results URL subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'RWT Results URL Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
			
			-- Service Base URL List subjects
			SELECT id INTO subject_id FROM openchpl.subscription_subject WHERE subject = 'Service Base URL List Changed';
			
			IF (SELECT COUNT(*) FROM openchpl.subscription WHERE subscriber_id = unique_subscription_rec.subscriber_id AND subscription_subject_id = subject_id AND subscribed_object_id = unique_subscription_rec.subscribed_object_id AND subscription_consolidation_method_id = 1 AND deleted = false)>0 THEN
				-- subscriptions already exists, print notice
				RAISE NOTICE 'Subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			ELSE
				-- insert the subscription
				INSERT INTO openchpl.subscription (subscriber_id, subscription_subject_id, subscribed_object_id, subscription_consolidation_method_id, creation_date, last_modified_user)
				VALUES (unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id, 1, unique_subscription_rec.creation_date, -1);
				RAISE NOTICE 'Added subscription for subscriber %, subject %, object % already exists', unique_subscription_rec.subscriber_id, subject_id, unique_subscription_rec.subscribed_object_id;
			END IF;
			

		END LOOP;
		RETURN;
	END;
$$ language plpgsql
volatile;

SELECT openchpl.create_missing_subscriptions_for_new_subjects();
DROP FUNCTION openchpl.create_missing_subscriptions_for_new_subjects();

;
-- ./changes/ocd-4588.sql
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = false
WHERE criterion_id = 210;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('24.10.1', '2024-05-28', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
