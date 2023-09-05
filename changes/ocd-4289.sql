-- set criteria start and end dates

-- 2011
UPDATE openchpl.certification_criterion
SET start_day = '2010-09-27'
WHERE number LIKE '170.30%';

UPDATE openchpl.certification_criterion
SET end_day = '2015-02-28'
WHERE number LIKE '170.30%';

-- 2014
UPDATE openchpl.certification_criterion
SET start_day = '2012-10-04'
WHERE number LIKE '170.314%';

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number LIKE '170.314%';

-- 2014 release 2
UPDATE openchpl.certification_criterion
SET start_day = '2014-10-14'
WHERE number IN ('170.314 (a)(18)', '170.314 (a)(19)', '170.314 (a)(20)', '170.314 (b)(8)', '170.314 (b)(9)', '170.314 (f)(7)', '170.314 (g)(1)', '170.314 (h)(2)', '170.314 (h)(3)');

UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number IN ('170.314 (a)(18)', '170.314 (a)(19)', '170.314 (a)(20)', '170.314 (b)(8)', '170.314 (b)(9)', '170.314 (f)(7)', '170.314 (g)(1)', '170.314 (h)(2)', '170.314 (h)(3)');

-- 2015
UPDATE openchpl.certification_criterion
SET start_day = '2015-10-16'
WHERE number LIKE '170.315%' 
AND title NOT LIKE '%Cures Update%';

-- 2015 removed on Cures ERD
UPDATE openchpl.certification_criterion
SET end_day = '2020-06-29'
WHERE number IN ('170.315 (a)(6)', '170.315 (a)(7)', '170.315 (a)(8)', '170.315 (a)(11)', '170.315 (b)(4)', '170.315 (b)(5)')
AND title NOT LIKE '%Cures Update%';

-- 2015 time limited
UPDATE openchpl.certification_criterion
SET end_day = '2021-12-31'
WHERE number IN ('170.315 (a)(10)', '170.315 (a)(13)', '170.315 (e)(2)')
AND title NOT LIKE '%Cures Update%';

-- 2015 original revised criteria
UPDATE openchpl.certification_criterion
SET end_day = '2022-12-31'
WHERE number IN ('170.315 (b)(1)', '170.315 (b)(2)', '170.315 (b)(3)', '170.315 (b)(7)', '170.315 (b)(8)', '170.315 (b)(9)',
'170.315 (c)(3)', '170.315 (d)(2)', '170.315 (d)(3)', '170.315 (d)(10)', '170.315 (e)(1)', '170.315 (f)(5)', '170.315 (g)(6)', '170.315 (g)(8)', '170.315 (g)(9)')
AND title NOT LIKE '%Cures Update%';

-- 2015 ERD-Phase-3
UPDATE openchpl.certification_criterion
SET end_day = '2023-12-31'
WHERE number IN ('170.315 (b)(6)')
AND title NOT LIKE '%Cures Update%';

UPDATE openchpl.certification_criterion
SET start_day = '2020-06-30'
WHERE number LIKE '170.315%' and title LIKE '%Cures Update%';
