alter table openchpl.questionable_activity_certification_result alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_developer alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_listing alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_product alter column activity_user_id drop not null;

alter table openchpl.questionable_activity_version alter column activity_user_id drop not null;