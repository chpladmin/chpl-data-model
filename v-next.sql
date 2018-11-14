-- OCD-2533 - Update eCQM numbers and versions for 2019 reporting bundle
-- 1) Create new CQM Version
-- 2) Create new version of 70 existing CQM
-- 3) Add 2 new CQMs

INSERT INTO openchpl.cqm_version (version, last_modified_user) 
SELECT 'v8', -1
WHERE NOT EXISTS (SELECT version FROM openchpl.cqm_version WHERE version = 'v8');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS2'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS2');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS9'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS9');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS22'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS22');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v6'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v5'
WHERE cc.cms_id = 'CMS26'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v6' WHERE cc.cms_id = 'CMS26');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS31'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS31');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS32'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS32');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS50'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS50');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS52'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS52');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS53'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS53');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS55'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS55');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS56'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS56');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS65'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS65');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS66'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS66');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS68'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS68');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS69'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS69');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS71'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS71');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS72'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS72');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS74'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS74');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS75'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS75');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v6'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v5'
WHERE cc.cms_id = 'CMS82'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS82');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS90'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS90');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS102'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS102');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS104'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS104');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS105'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS105');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS107'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS107');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS108'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS108');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS111'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS111');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS113'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS113');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS117'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS117');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS122'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS122');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS123'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS123');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS124'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS124');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS125'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS125');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS127'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS127');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS128'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS128');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS129'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS129');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS130'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS130');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS131'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS131');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS132'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS132');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS133'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS133');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS134'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS134');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS135'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS135');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS136'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS136');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS137'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS137');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS138'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS138');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS139'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS139');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS142'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS142');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS143'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS143');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS144'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS144');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS145'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS145');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS146'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS146');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v8'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v7'
WHERE cc.cms_id = 'CMS147'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v8' WHERE cc.cms_id = 'CMS147');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS149'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS149');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS153'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS153');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS154'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS154');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS155'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS155');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS156'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS156');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS157'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS157');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS158'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS158');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS159'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS159');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS160'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS160');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS161'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS161');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS164'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS164');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS165'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS165');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS167'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS167');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS169'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS169');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS177'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS177');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v7'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v6'
WHERE cc.cms_id = 'CMS190'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v7' WHERE cc.cms_id = 'CMS190');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v1'
WHERE cc.cms_id = 'CMS347'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS347');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT cc.number, cc.cms_id, cc.title, cc.description, cc.cqm_domain, cc.nqf_number, -1, (SELECT cqm_version_id FROM openchpl.cqm_version WHERE version = 'v2'), cc.cqm_criterion_type_id, cc.retired
FROM openchpl.cqm_criterion cc
	INNER JOIN openchpl.cqm_version cv
		ON cc.cqm_version_id = cv.cqm_version_id
		AND cv.version = 'v1'
WHERE cc.cms_id = 'CMS645'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v2' WHERE cc.cms_id = 'CMS645');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT
 null,
 'CMS249',
 'Appropriate Use of DXA Scans in Women Under 65 Years Who Do Not Meet the Risk Factor Profile for Osteoporotic Fracture',
 'Percentage of female patients 50 to 64 years of age without select risk factors for osteoporotic fracture who received an order for a dual-energy x-ray absorptiometry (DXA) scan during the measurement period.',
 'Efficiency and Cost Reduction',
 'N/A',
 -1,
 cqm_version_id,
 1,
 false
FROM openchpl.cqm_version WHERE version = 'v1'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v1' WHERE cc.cms_id = 'CMS249');

INSERT INTO openchpl.cqm_criterion (number, cms_id, title, description, cqm_domain, nqf_number, last_modified_user, cqm_version_id, cqm_criterion_type_id, retired)
SELECT
 null,
 'CMS349',
 'HIV Screening',
 'Percentage of patients 15-65 years of age who have been tested for HIV within that age range',
 'Community/Population Health',
 'N/A',
 -1,
 cqm_version_id,
 1,
 false
FROM openchpl.cqm_version WHERE version = 'v1'
AND NOT EXISTS (SELECT * FROM openchpl.cqm_criterion cc INNER JOIN openchpl.cqm_version cv ON cc.cqm_version_id = cv.cqm_version_id AND cv.version = 'v1' WHERE cc.cms_id = 'CMS349');

-- END OCD-2533
----------------------------------------------------

-- OCD-2532 - 2015 functionality tested should be restricted by criteria
-- 1) Create new table to support relationship between criteria and test functionality
-- 2) Add triggers to new table
-- 3) Rename old column
-- 4) Add new 2015 data to new table
-- 5) Add existing 2014 data to new table

--Drop thje new table if it exists
DROP TABLE IF EXISTS openchpl.test_functionality_criteria_map;

--Create the new table
CREATE TABLE openchpl.test_functionality_criteria_map
(
    id bigserial NOT NULL,
    criteria_id bigint NOT NULL,
    test_functionality_id bigint NOT NULL,
    creation_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_date timestamp without time zone NOT NULL DEFAULT now(),
    last_modified_user bigint NOT NULL,
    deleted boolean NOT NULL DEFAULT false,
    CONSTRAINT test_functionality_criteria_map_pk PRIMARY KEY (id),
    CONSTRAINT test_functionality_criteria_fk FOREIGN KEY (criteria_id)
        REFERENCES openchpl.certification_criterion (certification_criterion_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT test_functionality_fk FOREIGN KEY (test_functionality_id)
        REFERENCES openchpl.test_functionality (test_functionality_id) MATCH FULL
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

--Create the required triggers
CREATE TRIGGER test_functionality_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER test_functionality_criteria_map_timestamp BEFORE UPDATE on openchpl.test_functionality_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- Rename the column that will no longer be used
DO $$
BEGIN
  IF NOT EXISTS(SELECT *
                FROM information_schema.columns
                WHERE table_catalog = 'openchpl'
                AND table_name = 'test_functionality'
                AND column_name = 'certification_criterion_id')
  THEN
      ALTER TABLE "openchpl"."test_functionality" RENAME COLUMN "certification_criterion_id" TO "certification_criterion_id_deleted";
  END IF;
END $$;

--Insert the 2015 data
INSERT INTO openchpl.test_functionality_criteria_map (criteria_id, test_functionality_id, last_modified_user)
VALUES (
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(1)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(2)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(3)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(ii)(B)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(ii)(B)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(10)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(10)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(10)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(10)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(13)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(13)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(iii)(A)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(iii)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(ii)(A)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(ii)(A)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(iii)(G)(1)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(3)(iii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(v)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(vi)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(4)(vii)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(i)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(i)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(ii)(A)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(5)(ii)(A)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(i)(B)(1)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(i)(B)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(ii)(E)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(6)(ii)(F)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (c)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(c)(3)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(7)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(7)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(9)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (d)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(d)(9)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(3)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(3)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(C)(2)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(4)(i)(A)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(4)(i)(B)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(g)(5)(iii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(13)(ii)(C)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(i)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (b)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (f)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.315 (g)(9)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '170.102(19)(ii)' AND  certification_edition_id = 3),
	-1
);

-- Convert the existing 2014 data
INSERT INTO openchpl.test_functionality_criteria_map (criteria_id, test_functionality_id, last_modified_user)
VALUES (
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(14)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(14)(vi)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(E)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(v)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(E)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(6)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(6)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(7)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(2)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(2)(i)(F)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(7)(vi)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(8)(iii)(F)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(A)(3)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(C)(2)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(ii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(4)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(4)(iii)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(B)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (b)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(b)(1)(i)(C)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(3)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(3)(i)(B)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (f)(7)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(f)(7)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(5)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(5)(i)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (a)(8)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(a)(8)(iii)(B)(3)' AND  certification_edition_id = 2),
	-1
),
(
    (SELECT certification_criterion_id FROM openchpl.certification_criterion WHERE number = '170.314 (e)(1)'),
    (SELECT test_functionality_id FROM openchpl.test_functionality WHERE number = '(e)(1)(i)(B)(1)(ii)' AND  certification_edition_id = 2),
	-1
);
-- END OCD-2532
----------------------------------------------------

--re-run grants
\i dev/openchpl_grant-all.sql
