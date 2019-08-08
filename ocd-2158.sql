drop table if exists openchpl.user_developer_map;
CREATE TABLE IF NOT EXISTS openchpl.user_developer_map (
	id bigserial NOT NULL,
	user_id bigint NOT NULL,
	developer_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_developer_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id)
		REFERENCES openchpl.user (user_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT,
	CONSTRAINT developer_fk FOREIGN KEY (developer_id)
		REFERENCES openchpl.vendor (vendor_id)
		MATCH SIMPLE ON UPDATE NO ACTION ON DELETE RESTRICT
);


insert into openchpl.user_permission ("name", description, authority, last_modified_user)
select 'DEVELOPER', 'This permission gives a user the ability to submit update requests for their ACBs.', 'ROLE_DEVELOPER', -1
where not exists
        (select *
        from openchpl.user_permission
        where authority = 'ROLE_DEVELOPER');
