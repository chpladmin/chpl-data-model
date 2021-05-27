-- remove new tables
drop table if exists openchpl.certification_result_optional_standard;
drop table if exists openchpl.optional_standard;

-- add new tables
CREATE TABLE openchpl.optional_standard (
  id bigserial not null,
  name text not null,
  description varchar(1000),
  creation_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_date timestamp NOT NULL DEFAULT NOW(),
  last_modified_user bigint NOT NULL,
  deleted bool NOT NULL DEFAULT false,
  constraint optional_standard_pk primary key (id)
);
CREATE TRIGGER optional_standard_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.optional_standard FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER optional_standard_timestamp BEFORE UPDATE on openchpl.optional_standard FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

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

-- insert optional standard data
insert into openchpl.optional_standard (name, description, last_modified_user) values
('OS 1', 'Fake Optional Standard 1', -1),
('Optional Standard 2', 'Fake Optional Standard 2', -1),
('Standard 3', 'Fake Optional Standard 3', -1),
('Newest Optional Standard 4', 'Fake Optional Standard 4', -1);

-- add new column for criterion attribute
alter table openchpl.certification_criterion_attribute drop column if exists optional_standard;
alter table openchpl.certification_criterion_attribute add column optional_standard bool NOT NULL default false;

-- add rows for criteria that don't yet have attributes
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 8, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 8); --a12
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 9, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 9); --a13
insert into openchpl.certification_criterion_attribute (criterion_id, last_modified_user) select 12, -1 where not exists (select * from openchpl.certification_criterion_attribute where criterion_id = 12); --b1

-- update data for new attribute
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 8; --a12
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 9; --a13
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 12; --b1
update openchpl.certification_criterion_attribute set optional_standard = true where criterion_id = 21; --b6
