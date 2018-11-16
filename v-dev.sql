DROP TABLE IF EXISTS openchpl.user_reset_token;
CREATE TABLE openchpl.user_reset_token(
	user_reset_token_id bigserial NOT NULL,
	user_reset_token varchar(25) NOT NULL,
	user_id bigint NOT NULL,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_fk FOREIGN KEY (user_id),
	CONSTRAINT user_reset_token_pk PRIMARY KEY (user_reset_token_id)
);

CREATE TRIGGER user_reset_token_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_reset_token FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE TRIGGER user_reset_token_timestamp BEFORE UPDATE on openchpl.user_reset_token FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();

--re-run grants
\i dev/openchpl_grant-all.sql