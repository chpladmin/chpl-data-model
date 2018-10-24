DROP TABLE IF EXISTS openchpl.user_reset_token;
CREATE TABLE openchpl.user_reset_token(
	user_reset_token_id bigserial NOT NULL,
	user_reset_token varchar(25) NOT NULL,
	user_id bigint,
	creation_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_date timestamp NOT NULL DEFAULT NOW(),
	last_modified_user bigint NOT NULL,
	deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_reset_token_pk PRIMARY KEY (user_reset_token_id)
);