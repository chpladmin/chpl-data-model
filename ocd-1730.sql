DROP TABLE IF EXISTS openchpl.chart_data;
DROP TABLE IF EXISTS openchpl.chart_data_stat_type;
CREATE TABLE openchpl.chart_data(
	chart_data_id bigserial NOT NULL,
	data_date timestamp NOT NULL DEFAULT NOW(),
	json_data_object text,
	chart_data_stat_type_id bigint NOT NULL,
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	CONSTRAINT chart_data_pk PRIMARY KEY (chart_data_id)
);

CREATE TABLE openchpl.chart_data_stat_type(
	chart_data_stat_type_id bigserial NOT NULL,
	data_type varchar(64),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	CONSTRAINT chart_data_stat_type_pk PRIMARY KEY (chart_data_stat_type_id)
);

INSERT INTO openchpl.chart_data_stat_type (data_type, last_modified_user)
values ('Total Number of Unique Products over time', -1),('Total Number of Unique Products w/ Active Listings Over Time', -1),
		('Total Number of Unique Products w/ Active 2014 Listings', -1),('Total Number of Unique Products w/ Active 2015 Listings', -1);
		
ALTER TABLE openchpl.chart_data ADD CONSTRAINT chart_data_stat_type_fk FOREIGN KEY (chart_data_stat_type_id)
REFERENCES openchpl.chart_data_stat_type (chart_data_stat_type_id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
		
CREATE TRIGGER chart_data_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.chart_data FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER chart_data_timestamp BEFORE UPDATE on openchpl.chart_data FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
CREATE TRIGGER chart_data_stat_type_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.chart_data_stat_type FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER chart_data_stat_type_timestamp BEFORE UPDATE on openchpl.chart_data_stat_type FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
\i dev/openchpl_grant-all.sql