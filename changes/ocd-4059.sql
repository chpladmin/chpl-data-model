--
-- Add Additional Software to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS additional_software bool NOT NULL default false;

--
-- All Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET additional_software = true;

--
-- Add Api Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS api_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- g7
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 56;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 57;

-- g9
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 58;

-- g9Cures
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 181;

-- g10
UPDATE openchpl.certification_criterion_attribute
SET api_documentation = true
WHERE criterion_id = 182;


--
-- Add Attestation Answer to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS attestation_answer bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d12
UPDATE openchpl.certification_criterion_attribute
SET attestation_answer = true
WHERE criterion_id = 176;

-- d13
UPDATE openchpl.certification_criterion_attribute
SET attestation_answer = true
WHERE criterion_id = 177;


--
-- Add Documentation URL to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS documentation_url bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d12
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 176;

-- d13
UPDATE openchpl.certification_criterion_attribute
SET documentation_url = true
WHERE criterion_id = 177;



--
-- Add Export Documentation to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS export_documentation bool NOT NULL default false;

--
-- 2015 Criteria
--

-- b10
UPDATE openchpl.certification_criterion_attribute
SET export_documentation = true
WHERE criterion_id = 171;



--
-- Add GAP to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS gap bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 4;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 8;


-- a10
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 10;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 11;

--d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 29;


--d4
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 32;

--d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 33;

--d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 34;

--d7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 35;

--d11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 39;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 45;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 61;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 67;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 77;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 80;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 86;

-- d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 94;

-- d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 98;

-- d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 99;

-- d8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 101;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 102;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 106;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 112;

-- h1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 117;

-- h2
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 118;

-- h3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 119;



--
-- Add G1 Success to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS g1_success bool NOT NULL default false;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 61;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 67;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 69;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 76;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 77;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 87;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET g1_success = true
WHERE criterion_id = 105;


--
-- Add G2 Success to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS g2_success bool NOT NULL default false;

--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 61;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 67;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 69;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 76;

-- a17
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 77;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 87;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET g2_success = true
WHERE criterion_id = 105;


--
-- Add SED  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS sed bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 8;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 9;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 14;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 17;

-- b2Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 166;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 167;


--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 61;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 62;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 68;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 76;

-- a18
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 78;

-- a19
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 79;

-- a20
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 80;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 84;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET sed = true
WHERE criterion_id = 90;



--
-- Add Test Standard  to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS test_standard bool NOT NULL default false;

--
-- 2014 Criteria
--

UPDATE openchpl.certification_criterion_attribute
SET test_standard = true
WHERE criterion_id IN 
	(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE certification_edition_id = 2);


--
-- Add Use Cases to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS use_cases bool NOT NULL default false;

--
-- 2015 Criteria
--

-- d13
UPDATE openchpl.certification_criterion_attribute
SET use_cases = true
WHERE criterion_id = 177;
