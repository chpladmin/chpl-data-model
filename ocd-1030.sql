SELECT certification_status from openchpl.certification_status;

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Suspended by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Suspended by ONC'
        );

INSERT INTO openchpl.certification_status (certification_status, last_modified_user)
SELECT 'Terminated by ONC', -1
WHERE
    NOT EXISTS (
    SELECT certification_status FROM openchpl.certification_status WHERE certification_status = 'Terminated by ONC'
        );

SELECT certification_status from openchpl.certification_status;

