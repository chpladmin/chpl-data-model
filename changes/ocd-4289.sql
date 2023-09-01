-- set criteria start and end dates
UPDATE openchpl.certification_criterion
SET start_day = '2010-07-28'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET end_day = '2016-04-13'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET start_day = '2012-09-04'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET start_day = '2015-10-16'
WHERE number LIKE '170.315%' and title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET end_day = '2022-12-31'
WHERE certification_criterion_id != 21 
AND number LIKE '170.315%' 
AND title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET end_day = '2023-12-31'
WHERE certification_criterion_id = 21;

UPDATE openchpl.certification_criterion
SET start_day = '2020-06-30'
WHERE number LIKE '170.315%' and title LIKE '%Cures Update%';
