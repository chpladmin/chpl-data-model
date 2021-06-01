-- remove new tables
drop table if exists openchpl.certification_result_optional_standard;
drop table if exists openchpl.optional_standard_criteria_map;
drop table if exists openchpl.optional_standard;

-- add new tables
CREATE TABLE openchpl.optional_standard (
  id bigserial not null,
  optional_standard text,
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL DEFAULT false,
  constraint optional_standard_pk primary key (id)
);
CREATE TRIGGER optional_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.optional_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER optional_standard_timestamp BEFORE UPDATE on openchpl.optional_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.optional_standard_criteria_map (
 id bigserial NOT NULL,
 optional_standard_id bigint NOT NULL,
 criterion_id bigint NOT NULL,
 creation_date timestamp NOT NULL DEFAULT NOW(),
 last_modified_date timestamp NOT NULL DEFAULT NOW(),
 last_modified_user bigint NOT NULL,
 deleted bool NOT NULL DEFAULT false,
 CONSTRAINT optional_standard_criteria_map_pk PRIMARY KEY (id),
 CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
 REFERENCES openchpl.optional_standard (id)
 MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
 CONSTRAINT optional_standard_criteria_map_fk FOREIGN KEY (criterion_id)
 REFERENCES openchpl.certification_criterion (certification_criterion_id)
 MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);
CREATE TRIGGER optional_standard_criteria_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.optional_standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER optional_standard_criteria_map_timestamp BEFORE UPDATE on openchpl.optional_standard_criteria_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

CREATE TABLE openchpl.certification_result_optional_standard (
  id bigserial NOT NULL,
  certification_result_id bigint not null,
  optional_standard_id bigint,
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL,
  CONSTRAINT certification_result_optional_standard_pk PRIMARY KEY (id),
  CONSTRAINT certification_result_fk FOREIGN KEY (certification_result_id)
  REFERENCES openchpl.certification_result (certification_result_id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT optional_standard_fk FOREIGN KEY (optional_standard_id)
  REFERENCES openchpl.optional_standard (id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE TRIGGER certification_result_optional_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER certification_result_optional_standard_timestamp BEFORE UPDATE on openchpl.certification_result_optional_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

-- add new column for criterion attribute
alter table openchpl.certification_criterion_attribute drop column if exists optional_standard;
alter table openchpl.certification_criterion_attribute add column optional_standard bool NOT NULL default false;
