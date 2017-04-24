ALTER TABLE openchpl.product DROP CONSTRAINT IF EXISTS contact_fk;
ALTER TABLE openchpl.product DROP COLUMN IF EXISTS contact_id;

ALTER TABLE openchpl.product ADD COLUMN contact_id bigint;
ALTER TABLE openchpl.product ADD CONSTRAINT contact_fk FOREIGN KEY (contact_id)
REFERENCES openchpl.contact (contact_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

BEGIN TRANSACTION;
-- update related requirements to deleted if parent surveillance is deleted
UPDATE openchpl.surveillance_requirement sr
SET deleted = true
WHERE surveillance_id IN (
		SELECT id
		FROM openchpl.surveillance
		WHERE deleted = true)
AND sr.deleted = false;

-- updated related surveillance nonconformities if parent requirement is deleted
UPDATE openchpl.surveillance_nonconformity snc
SET deleted = true
WHERE surveillance_requirement_id IN (
		SELECT id
		FROM openchpl.surveillance_requirement
		WHERE deleted = true)
AND snc.deleted = false;

-- update surveillance requirements to indiciate that a nonconformity was found if there are nonconformities
UPDATE openchpl.surveillance_requirement sr
SET result_id = 1
WHERE (
	SELECT count(*) from openchpl.surveillance_nonconformity WHERE surveillance_requirement_id = sr.id
   ) > 0
AND result_id = 2;
COMMIT;

