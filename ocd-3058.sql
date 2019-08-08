--create mapping table from users to developers
DROP TABLE IF EXISTS openchpl.user_developer_map;

CREATE TABLE openchpl.user_developer_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_developer_map_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id) 
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);

CREATE TRIGGER user_developer_map_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_developer_map_timestamp BEFORE UPDATE on openchpl.user_developer_map FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--add developer role
insert into openchpl.user_permission (name, description, authority, last_modified_user)
select 'DEVELOPER', 'This permission gives users write access to their Developers.', 'ROLE_DEVELOPER', -1
where not exists
	(select *
	from openchpl.user_permission
	where name = 'DEVELOPER');