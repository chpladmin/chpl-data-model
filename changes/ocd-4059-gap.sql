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

-- a5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 5;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 6;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 7;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 8;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 9;

-- a10
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 10;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 11;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 12;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 13;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 14;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 15;

-- b1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 16;

-- b1Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 165;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 17;

-- b2Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 166;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 18;

-- b3Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 167;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 19;

-- b5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 20;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 21;

-- b7
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 22;

-- b7Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 168;

-- b8
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 23;

-- b8Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 169;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 24;

-- b9Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 170;

-- b10
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 171;

-- c1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 25;

-- c2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 26;

-- c3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 27;

-- c3Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 172;

-- c4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 28;

--d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 29;

--d2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 30;

--d2Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 173;

--d3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 31;

--d3Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 174;

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

--d8
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 36;

--d9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 37;

--d10
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 38;

--d10Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 175;

--d11
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 39;

--d12
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 176;

--d13
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 177;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 40;

-- e1Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 178;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 41;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 42;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 43;

-- f2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 44;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 45;

-- f4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 46;

-- f5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 47;

-- f5Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 179;

-- f6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 48;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 49;

-- g1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 50;

-- g2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 51;

-- g3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 52;

-- g4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 53;

-- g5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 54;

-- g6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 55;

-- g6Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 180;

-- g7
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 56;

-- g8
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 57;

-- g9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 58;

-- g9Cures
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 181;

-- g10
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 182;

-- h1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 59;

-- h2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 60;


--
-- 2014 Criteria
--

-- a1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 61;

-- a2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 62;

-- a3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 63;

-- a4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 64;

-- a5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 65;

-- a6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 66;

-- a7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 67;

-- a8
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 68;

-- a9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 69;

-- a10
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 70;

-- a11
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 71;

-- a12
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 72;

-- a13
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 73;

-- a14
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 74;

-- a15
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 75;

-- a16
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 76;

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

-- b1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 81;

-- b2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 82;

-- b3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 83;

-- b4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 84;

-- b5A
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 85;

-- b5B
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 86;

-- b6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 87;

-- b7
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 88;

-- b8
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 89;

-- b9
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 90;

-- c1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 91;

-- c2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 92;

-- c3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 93;

-- d1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 94;

-- d2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 95;

-- d3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 96;

-- d4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 97;

-- d5
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 98;

-- d6
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 99;

-- d7
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 100;

-- d8
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 101;

-- d9
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 102;

-- e1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 103;

-- e2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 104;

-- e3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 105;

-- f1
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 106;

-- f2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 107;

-- f3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 108;

-- f4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 109;

-- f5
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 110;

-- f6
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 111;

-- f7
UPDATE openchpl.certification_criterion_attribute
SET gap = true
WHERE criterion_id = 112;

-- g1
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 113;

-- g2
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 114;

-- g3
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 115;

-- g4
UPDATE openchpl.certification_criterion_attribute
SET gap = false
WHERE criterion_id = 116;

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
