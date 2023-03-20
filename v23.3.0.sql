-- Deployment file for version 23.3.0
--     as of 2023-03-20
-- ./changes/ocd-4157.sql
--
-- Remove existing P&S Values for b10
--
UPDATE openchpl.certification_result
SET privacy_security_framework = NULL
WHERE certification_criterion_id = 171
AND privacy_security_framework IS NOT NULL;

--
-- Add privacy and security to criterion attribute table
--

ALTER TABLE openchpl.certification_criterion_attribute
ADD COLUMN IF NOT EXISTS privacy_security_framework bool NOT NULL default false;

--
-- 2015 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 1;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 2;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 3;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 4;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 8;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 9;

-- a10
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 10;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 11;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 12;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 13;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 14;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 15;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 16;

-- b1Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 165;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 17;

-- b2Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 166;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 167;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 19;

-- b5
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 20;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 21;

-- b7
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 22;

-- b7Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 168;

-- b8
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 23;

-- b8Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 169;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 24;

-- b9Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 170;

-- c1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 25;

-- c2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 26;

-- c3
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 27;

-- c3Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 172;

-- c4
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 28;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 40;

-- e1Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 178;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 41;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 42;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 43;

-- f2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 44;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 45;

-- f4
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 46;

-- f5
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 47;

-- f5Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 179;

-- f6
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 48;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 49;

-- g7
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 56;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 57;

-- g9
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 58;

-- g9Cures
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 181;

-- g10
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 182;

-- h1
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 59;

-- h2
UPDATE openchpl.certification_criterion_attribute
SET privacy_security_framework = true
WHERE criterion_id = 60;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('23.3.0', '2023-03-20', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
