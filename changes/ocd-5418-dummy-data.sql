-- The end day is being put in as the last day the criterion should appear as active. 
-- On any day following the end_day the criteria will be treated as removed in our system.

-- The following criteria appear as removed beginning on HTI-5 ERD: Dec 28, 2026

-- b7
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 168;

-- b8
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 169;

-- b9
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 170;

-- g6
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 180;

-- h1
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 59;

-- h2
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-01'
WHERE certification_criterion_id = 60;

-- The following criteria appear as removed beginning on Jan 1, 2027

-- a12
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 12;

-- c4
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 28;

-- e3
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 42;

-- g1
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 50;

-- g2
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 51;

-- g7
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 56;

-- g9
UPDATE openchpl.certification_criterion
SET end_day = '2026-11-03'
WHERE certification_criterion_id = 181;
