--
-- Optional Standard Updates
--

UPDATE openchpl.optional_standard
SET description = 'SNOMED CT®'
WHERE id = 5;
-- Question: This optional standard also maps to 3 removed criteria (b1-original, b6, f5-original)
-- Should the description change for those as well or should it be left as it currently is? These criteria are not in the spreadhsheet so I 
-- would assume the optional standard names should be left as they are currently.

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
-- Optional Standard Additions:
--