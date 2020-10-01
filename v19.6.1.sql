-- Deployment file for version 19.6.1
--     as of 2020-09-21
-- ocd-3452.sql
-- 1) Create new CQM Version
-- 2) Create new version of 58 existing CQM
-- 3) Add 1 new CQM

INSERT INTO openchpl.cqm_version (version, last_modified_user)
SELECT 'v10', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v10');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS2'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS2');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS9'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS9');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS22'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS22');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS50'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS50');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS52'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS52');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS56'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS56');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS66'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS66');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS68'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS68');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS69'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS69');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS71'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS71');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS72'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS72');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS74'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS74');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS75'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS75');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS82'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS82');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS90'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS90');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS104'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS104');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS105'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS105');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS108'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS108');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS111'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS111');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS117'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS117');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS122'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS122');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS124'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS124');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS125'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS125');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS127'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS127');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS128'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS128');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS129'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS129');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS130'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS130');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS131'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS131');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS132'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS132');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS133'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS133');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS134'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS134');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS135'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS135');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS136'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS136');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS137'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS137');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS138'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS138');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS139'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS139');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS142'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS142');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS143'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS143');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS144'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS144');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS145'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS145');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS146'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS146');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v10'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v9'
WHERE cc.cms_id = 'CMS147'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v10' WHERE cc.cms_id = 'CMS147');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS149'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS149');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS153'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS153');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS154'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS154');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS155'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS155');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS156'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS156');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS157'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS157');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS159'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS159');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS160'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS160');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS161'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS161');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS165'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS165');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS177'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS177');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v9'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v8'
WHERE cc.cms_id = 'CMS190'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v9' WHERE cc.cms_id = 'CMS190');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v3'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v2'
WHERE cc.cms_id = 'CMS249'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v3' WHERE cc.cms_id = 'CMS249');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v4'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v3'
WHERE cc.cms_id = 'CMS347'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v4' WHERE cc.cms_id = 'CMS347');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v3'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v2'
WHERE cc.cms_id = 'CMS349'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v3' WHERE cc.cms_id = 'CMS349');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v4'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v3'
WHERE cc.cms_id = 'CMS645'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v4' WHERE cc.cms_id = 'CMS645');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v1'
WHERE cc.cms_id = 'CMS771'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS771');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT
 null,
 'CMS506',
 'Safe Use of Opioids- Concurrent Prescribing',
 'Proportion of inpatient hospitalizations for patients 18 years of age and older prescribed, or continued on, two or more opioids or an opioid and benxodiazepine concurrently at discharge',
 'Prevention and Treatment of Opioid and Substance Use Disorders',
 '3316',
 -1,
 cqm_version_id,
 2,
 false
FROM openchpl.cqm_version WHERE version = 'v3'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v3' WHERE cc.cms_id = 'CMS506');
;
-- ocd-3475.sql
-- rename stage 2 macra measures

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(1)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 10: Stage 2 Objective 3 Measure 1'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(1)'
AND value = 'GAP-EH/CAH';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(2)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 11: Stage 2 Objective 3 Measure 2'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(2)'
AND value = 'GAP-EH/CAH';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EP Stage 2',
	description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(3)'
AND value = 'GAP-EP';

UPDATE openchpl.macra_criteria_map
SET value = 'GAP-EH/CAH Stage 2',
	description = 'Required Test 12: Stage 2 Objective 3 Measure 3'
FROM openchpl.certification_criterion cc
WHERE criteria_id = cc.certification_criterion_id
AND cc.number = '170.315 (a)(3)'
AND value = 'GAP-EH/CAH';


-- add stage 3 macra measures

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Professional',
		'Required Test 10: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Medications: Eligible Hospital/Critical Access Hospital',
		'Required Test 10: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order - Laboratory: Eligible Professional',
		'Required Test 11: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Laboratory: Eligible Hospital/Critical Access Hospital',
		'Required Test 11: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EP Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Professional',
		'Required Test 12: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EP Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)')
);

INSERT INTO openchpl.macra_criteria_map (value, name, description, criteria_id, last_modified_user)
SELECT 'GAP-EH/CAH Stage 3', 
		'(Gap Certified) Computerized Provider Order Entry - Diagnostic Imaging: Eligible Hospital/Critical Access Hospital',
		'Required Test 12: Medicaid Promoting Interoperability Program',
		(SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
		-1
WHERE NOT EXISTS (
	SELECT * FROM openchpl.macra_criteria_map
	WHERE value = 'GAP-EH/CAH Stage 3'
	AND criteria_id = (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)')
);

-- add the new Stage 3 measures to every certification result that has one of the Stage 2 measures
DROP FUNCTION If EXISTS openchpl.insert_stage_3(text, text, text);

CREATE OR REPLACE FUNCTION openchpl.insert_stage_3 (criterion_number text, old_macra_value text, new_macra_value text)
RETURNS void AS $$
DECLARE
	old_macra_id bigint;
	new_macra_id bigint;
	existingG1Macra RECORD;
	existingG2Macra RECORD;
	
BEGIN
	SELECT mcm.id INTO old_macra_id
	FROM openchpl.macra_criteria_map mcm 
	JOIN openchpl.certification_criterion cc ON mcm.criteria_id = cc.certification_criterion_id
	WHERE mcm.value = old_macra_value
	AND cc.number = criterion_number;
	
	SELECT mcm.id INTO new_macra_id
	FROM openchpl.macra_criteria_map mcm 
	JOIN openchpl.certification_criterion cc ON mcm.criteria_id = cc.certification_criterion_id
	WHERE mcm.value = new_macra_value
	AND cc.number = criterion_number;
	
	FOR existingG1Macra IN
		SELECT g1.*
		FROM openchpl.certification_result_g1_macra g1
		JOIN openchpl.certification_result cr ON cr.certification_result_id = g1.certification_result_id
		JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
		WHERE g1.deleted = false
		AND cr.deleted = false
		AND cc.number = criterion_number
		AND g1.macra_id = old_macra_id
	LOOP
		INSERT INTO openchpl.certification_result_g1_macra (macra_id, certification_result_id, last_modified_user)
		SELECT  new_macra_id,
				existingG1Macra.certification_result_id,
				-1
		WHERE NOT EXISTS (
			SELECT * FROM openchpl.certification_result_g1_macra
			WHERE macra_id = new_macra_id
			AND certification_result_id = existingG1Macra.certification_result_id
		);
	END LOOP;
	
	FOR existingG2Macra IN
		SELECT g2.*
		FROM openchpl.certification_result_g2_macra g2
		JOIN openchpl.certification_result cr ON cr.certification_result_id = g2.certification_result_id
		JOIN openchpl.certification_criterion cc ON cr.certification_criterion_id = cc.certification_criterion_id
		WHERE g2.deleted = false
		AND cr.deleted = false
		AND cc.number = criterion_number
		AND g2.macra_id = old_macra_id
	LOOP
		INSERT INTO openchpl.certification_result_g2_macra (macra_id, certification_result_id, last_modified_user)
		SELECT  new_macra_id,
				existingG2Macra.certification_result_id,
				-1
		WHERE NOT EXISTS (
			SELECT * FROM openchpl.certification_result_g2_macra
			WHERE macra_id = new_macra_id
			AND certification_result_id = existingG2Macra.certification_result_id
		);
	END LOOP;
END;
$$ language plpgsql
volatile;

SELECT openchpl.insert_stage_3('170.315 (a)(1)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(1)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(2)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(2)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(3)', 'GAP-EP Stage 2', 'GAP-EP Stage 3');
SELECT openchpl.insert_stage_3('170.315 (a)(3)', 'GAP-EH/CAH Stage 2', 'GAP-EH/CAH Stage 3');

DROP FUNCTION If EXISTS openchpl.insert_stage_3(text, text, text);
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.6.1', '2020-09-21', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
