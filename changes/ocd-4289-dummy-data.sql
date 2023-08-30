-- set criteria start and end dates
UPDATE openchpl.certification_criterion
SET start_day = '2011-01-01'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET end_day = '2013-12-31'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET start_day = '2014-01-01'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET end_day = '2014-12-31'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET start_day = '2015-01-01'
WHERE number LIKE '170.315%' and title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-30'
WHERE certification_criterion_id IN (8, 19, 20, 6, 7, 11);

UPDATE openchpl.certification_criterion
SET end_day = '2022-01-01'
WHERE certification_criterion_id IN (10, 13, 41);

UPDATE openchpl.certification_criterion
SET end_day = '2023-01-01'
WHERE certification_criterion_id IN (16, 17, 18, 22, 23, 24, 27, 30, 31, 38, 40, 47, 55, 57, 58);

UPDATE openchpl.certification_criterion
SET end_day = '2024-01-01'
WHERE certification_criterion_id IN (21);

UPDATE openchpl.certification_criterion
SET start_day = '2020-06-30'
WHERE number LIKE '170.315%' and title LIKE '%Cures Update%';
