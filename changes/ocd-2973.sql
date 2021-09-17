INSERT INTO openchpl.deprecated_api
(http_method, api_operation, change_description, last_modified_user)
SELECT 'GET', 
	'/data/test_tools',
	'This endpoint is deprecated and will be removed in a future release. The test_tools are now dependent on the criteria they are associated with and can be found in the CertifiedProductSearchDetails.',
	-1
WHERE NOT EXISTS
	(SELECT *
	FROM openchpl.deprecated_api
	WHERE http_method = 'GET'
	AND api_operation = '/data/test_tools');

-- DROP and ADD constraint to ensure each criterion is only in the table once
ALTER TABLE openchpl.certification_criterion_attribute DROP CONSTRAINT criterion_unique;
ALTER TABLE openchpl.certification_criterion_attribute ADD CONSTRAINT criterion_unique UNIQUE (criterion_id);

-- Add new column to indicate whether the criterion supports test tools
ALTER TABLE openchpl.certification_criterion_attribute ADD COLUMN IF NOT EXISTS test_tool BOOL NOT NULL DEFAULT FALSE;

-- Add the new test tools
INSERT INTO openchpl.test_tool
(name, last_modified_user)
SELECT 'NCPDP Electronic Prescribing (eRx) Testing Tool', -1
WHERE NOT EXISTS
	(SELECT *
	FROM openchpl.test_tool
	WHERE name = 'NCPDP Electronic Prescribing (eRx) Testing Tool');

INSERT INTO openchpl.test_tool
(name, last_modified_user)
SELECT 'NIST General Validation Tool (GVT)', -1
WHERE NOT EXISTS
	(SELECT *
	FROM openchpl.test_tool
	WHERE name = 'NIST General Validation Tool (GVT)');

-- INSERT or UPDATE (also called UPSERT - learned something new) the criterion and whther it supports test tools
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(9)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;
INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(10)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(11)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(12)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(13)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(14)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(15)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(16)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(17)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(18)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(19)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (a)(20)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(5)(A)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(5)(B)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (b)(9)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (c)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (c)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (c)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (d)(9)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (e)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (e)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (e)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (f)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (g)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (g)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (g)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (g)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (h)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (h)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.314 (h)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(9)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(10)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(11)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(12)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(13)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(14)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (a)(15)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(1)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(1)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(2)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(2)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(3)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(3)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(7)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(7)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(8)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(8)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(9)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(9)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(10)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (b)(10)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (c)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (c)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (c)(3)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (c)(3)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (c)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(2)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;


INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(2)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(3)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(3)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;


INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(9)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(10)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(10)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;


INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(11)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(12)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (d)(13)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (e)(1)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (e)(1)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (e)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (e)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(5)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(5)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(6)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (f)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(3)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(4)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(5)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(6)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(6)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(7)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, false, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(8)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(9)'
AND title NOT LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(9)'
AND title LIKE '%(Cures Update)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (g)(10)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (h)(1)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

INSERT INTO openchpl.certification_criterion_attribute (criterion_id, test_tool, last_modified_user)
SELECT certification_criterion_id, true, -1
FROM openchpl.certification_criterion
WHERE number = '170.315 (h)(2)'
ON CONFLICT ON CONSTRAINT criterion_unique DO UPDATE SET
	test_tool = EXCLUDED.test_tool;

-- Add new table to support test tool / criterion mapping
DROP TABLE IF EXISTS openchpl.test_tool_criteria_map;

CREATE TABLE openchpl.test_tool_criteria_map (
	id bigserial NOT NULL,
	certification_criterion_id bigint NOT NULL,
	test_tool_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT test_tool_criteria_map_pk PRIMARY KEY (id),
	CONSTRAINT criteria_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT test_tool_fk FOREIGN KEY (test_tool_id)
		REFERENCES openchpl.test_tool (test_tool_id)
		MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Add the test tools / crierion maapings
INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'CDC''s NHSN CDA Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Cypress' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Direct Certificate Discovery Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Edge Testing Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Electronic Prescribing' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HIMSS Immunization Integration Program' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 CDA Cancer Registry Reporting Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 CDA National Health Care Surveys Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Immunization Information System (IIS) Reporting Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Laboratory Results Interface (LRI) Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Syndromic Surveillance Reporting Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7v2 Immunization Test Suite' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7v2 Syndromic Surveillance Test Suite' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Inferno' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NCQA ONC Health IT Testing' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NHCS IG Release 1 Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NHCS IG Release 1.2 Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Transport Testing Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Not Applicable' AND NOT deleted),
	-1
FROM openchpl.certification_criterion_attribute cca
INNER JOIN openchpl.certification_criterion cc 
	ON cca.criterion_id = cc.certification_criterion_id
WHERE cca.test_tool
AND cc.certification_edition_id = 2;

--------------------------------
INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'CDC''s NHSN CDA Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(6)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Cypress' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (c)(1)', '170.315 (c)(2)', '170.315 (c)(3)', '170.315 (c)(4)');


INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Direct Certificate Discovery Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (h)(1)', '170.315 (h)(2)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Edge Testing Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (b)(1)', '170.315 (b)(2)', '170.315 (b)(5)', '170.315 (b)(6)', '170.315 (b)(7)', '170.315 (b)(8)', '170.315 (b)(9)', '170.315 (e)(1)', '170.315 (g)(6)', '170.315 (g)(9)', '170.315 (h)(1)', '170.315 (h)(2)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Electronic Prescribing' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (b)(3)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HIMSS Immunization Integration Program' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(1)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 CDA Cancer Registry Reporting Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(4)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 CDA National Health Care Surveys Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(7)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(3)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7v2 Immunization Test Suite' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(1)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7v2 Syndromic Surveillance Test Suite' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(2)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'HL7 v2 Syndromic Surveillance Reporting Validation Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(2)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Inferno' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (g)(10)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NCPDP Electronic Prescribing (eRx) Testing Tool' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (b)(3)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NCQA ONC Health IT Testing' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (c)(2)', '170.315 (c)(3)', '170.315 (c)(4)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NHCS IG Release 1 Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(7)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NHCS IG Release 1.2 Validator' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(7)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'NIST General Validation Tool (GVT)' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (f)(7)');

INSERT INTO openchpl.test_tool_criteria_map
(certification_criterion_id, test_tool_id, last_modified_user)
SELECT cc.certification_criterion_id, 
	(SELECT tt.test_tool_id FROM openchpl.test_tool tt WHERE tt.name = 'Not Applicable' AND NOT deleted),
	-1
FROM openchpl.certification_criterion cc 
WHERE cc.number in ('170.315 (b)(1)', '170.315 (b)(2)', '170.315 (b)(3)', '170.315 (b)(6)', '170.315 (b)(7)', '170.315 (b)(8)', '170.315 (b)(9)', 
					'170.315 (c)(1)', '170.315 (c)(2)', '170.315 (c)(3)', '170.315 (c)(4)', '170.315 (e)(1)', '170.315 (f)(1)', '170.315 (f)(2)', 
					'170.315 (f)(3)', '170.315 (f)(4)', '170.315 (f)(6)', '170.315 (f)(7)', '170.315 (g)(6)', '170.315 (g)(9)', '170.315 (g)(10)',
					'170.315 (h)(1)', '170.315 (h)(2)');
