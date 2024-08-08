create table if not exists openchpl.forgot_password (
    id bigserial not null,
    token uuid not null,
    email text not null,
    creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
    last_modified_sso_user uuid,
    deleted bool not null default false,
	constraint forgot_password_pk primary key (id)
);

CREATE or replace TRIGGER forgot_password_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.forgot_password FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER forgot_password_timestamp BEFORE UPDATE on openchpl.forgot_password FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS forgot_password_last_modified_user_constraint ON openchpl.forgot_password;
CREATE CONSTRAINT TRIGGER forgot_password_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.forgot_password DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
