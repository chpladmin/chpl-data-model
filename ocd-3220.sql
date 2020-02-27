ALTER TABLE openchpl.pending_surveillance_requirement DROP COLUMN IF EXISTS certification_criterion_id;
ALTER TABLE openchpl.pending_surveillance_nonconformity DROP COLUMN IF EXISTS certification_criterion_id;
ALTER TABLE openchpl.nonconformity_type_statistics DROP COLUMN IF EXISTS certification_criterion_id;

ALTER TABLE openchpl.pending_surveillance_requirement
ADD COLUMN certification_criterion_id bigint;

ALTER TABLE openchpl.pending_surveillance_requirement
ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE openchpl.pending_surveillance_nonconformity
ADD COLUMN certification_criterion_id bigint;

ALTER TABLE openchpl.pending_surveillance_nonconformity
ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE openchpl.nonconformity_type_statistics
ADD COLUMN certification_criterion_id bigint;

ALTER TABLE openchpl.nonconformity_type_statistics
ADD CONSTRAINT certification_criterion_fk FOREIGN KEY (certification_criterion_id)
		REFERENCES openchpl.certification_criterion (certification_criterion_id)
		MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE;