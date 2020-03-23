-- Deployment file for version 19.1.0
--     as of 2020-03-23
-- ocd-3149.sql
ALTER TABLE openchpl.pending_certified_product DROP COLUMN IF EXISTS self_developer;
ALTER TABLE openchpl.pending_certified_product ADD COLUMN self_developer bool;
;
-- ocd-3220.sql
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
;
insert into openchpl.data_model_version (version, deploy_date, last_modified_user) values ('19.1.0', '2020-03-23', -1);
\i dev/openchpl_soft-delete.sql
\i dev/openchpl_views.sql
\i dev/openchpl_grant-all.sql
