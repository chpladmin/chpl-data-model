ALTER TABLE openchpl.questionable_activity_certification_result
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_certification_result
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_certification_result 
ADD CONSTRAINT activity_to_questionable_activity_certification_result_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_developer
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_developer
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_developer 
ADD CONSTRAINT activity_to_questionable_activity_developer_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_listing
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_listing
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_listing 
ADD CONSTRAINT activity_to_questionable_activity_listing_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_product
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_product
ADD COLUMN activity_id bigint; 

ALTER TABLE openchpl.questionable_activity_product 
ADD CONSTRAINT activity_to_questionable_activity_product_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;

ALTER TABLE openchpl.questionable_activity_version
DROP COLUMN IF EXISTS activity_id;

ALTER TABLE openchpl.questionable_activity_version
ADD COLUMN activity_id bigint;

ALTER TABLE openchpl.questionable_activity_version 
ADD CONSTRAINT activity_to_questionable_activity_version_fk FOREIGN KEY (activity_id) REFERENCES openchpl.activity (activity_id)
ON DELETE RESTRICT;
