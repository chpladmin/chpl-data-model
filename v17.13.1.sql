-- Deployment file for version 17.13.1
--     as of 2019-11-04
-- ocd-3120.sql
INSERT INTO openchpl.test_tool (name, last_modified_user, retired)
SELECT 'Not Applicable', -1, false
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.test_tool
    WHERE name = 'Not Applicable');
    ;

INSERT INTO openchpl.test_procedure (name, last_modified_user)
SELECT 'ONC Test Method - Surescripts (Alternative)', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.test_procedure
    WHERE name = 'ONC Test Method - Surescripts (Alternative)');
    ;

INSERT INTO openchpl.test_procedure_criteria_map(criteria_id, test_procedure_id, last_modified_user)
SELECT (SELECT cc.certification_criterion_id FROM openchpl.certification_criterion cc WHERE cc.number = '170.315 (b)(3)'),
    (SELECT tpt.id FROM openchpl.test_procedure tpt WHERE tpt.name = 'ONC Test Method - Surescripts (Alternative)'),
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.test_procedure_criteria_map
    WHERE criteria_id = (SELECT cc.certification_criterion_id FROM openchpl.certification_criterion cc WHERE cc.number = '170.315 (b)(3)')
        AND test_procedure_id = (SELECT tp.id FROM openchpl.test_procedure tp WHERE tp.name = 'ONC Test Method - Surescripts (Alternative)')
        );
    ;

INSERT INTO openchpl.test_data (name, last_modified_user)
SELECT 'Not Applicable', -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.test_data
    WHERE name = 'Not Applicable');
    ;

INSERT INTO openchpl.test_data_criteria_map(criteria_id, test_data_id, last_modified_user)
SELECT (SELECT cc.certification_criterion_id FROM openchpl.certification_criterion cc WHERE cc.number = '170.315 (b)(3)'),
    (SELECT td.id FROM openchpl.test_data td WHERE td.name = 'Not Applicable'),
    -1
WHERE NOT EXISTS (
    SELECT *
    FROM openchpl.test_data_criteria_map
    WHERE criteria_id = (SELECT cc.certification_criterion_id FROM openchpl.certification_criterion cc WHERE cc.number = '170.315 (b)(3)')
        AND test_data_id = (SELECT td.id FROM openchpl.test_data td WHERE td.name = 'Not Applicable')
        );
;
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('17.13.1', '2019-11-04', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
