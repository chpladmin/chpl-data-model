create table if not exists openchpl.user_invitation (
    id bigserial not null,
    email text not null,
	token uuid not null,
	creation_date timestamp not null default now(),
    last_modified_date timestamp not null default now(),
    last_modified_user bigint,
	last_modified_sso_user uuid,
    deleted bool not null default false,
    constraint user_invitation_pk primary key (id)
);
CREATE or replace TRIGGER user_invitation_audit AFTER INSERT OR UPDATE OR DELETE on openchpl.user_invitation FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
CREATE or replace TRIGGER user_invitation_timestamp BEFORE UPDATE on openchpl.user_invitation FOR EACH ROW EXECUTE PROCEDURE openchpl.update_last_modified_date_column();
DROP TRIGGER IF EXISTS user_invitation_last_modified_user_constraint ON openchpl.user_invitation;
CREATE CONSTRAINT TRIGGER user_invitation_last_modified_user_constraint AFTER INSERT OR UPDATE ON openchpl.user_invitation DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE PROCEDURE openchpl.last_modified_user_constraint();
