----
-- OCD-1748
----

-- Report on all Tasks missing values
--   return Listing DB ID, Criteria number, and Task Description
select tt.description, cc."number", cr.certified_product_id
from openchpl.test_task as tt,
    openchpl.certification_criterion as cc,
    openchpl.certification_result as cr,
    openchpl.certification_result_test_task as crtt
where
    cc.certification_criterion_id = cr.certification_criterion_id
    and cr.certification_result_id = crtt.certification_result_id
    and crtt.test_task_id = tt.test_task_id
    and (
        tt.description is null
        or tt.task_errors_pct is null
        or tt.task_success_avg_pct is null
        or tt.task_success_stddev_pct is null
        or tt.task_path_deviation_observed is null
        or tt.task_path_deviation_optimal is null
        or tt.task_time_avg_seconds is null
        or tt.task_time_stddev_seconds is null
        or tt.task_time_deviation_observed_avg_seconds is null
        or tt.task_time_deviation_optimal_avg_seconds is null
        or tt.task_errors_pct is null
        or tt.task_errors_stddev_pct is null
        or tt.task_rating_scale is null
        or tt.task_rating is null
        or tt.task_rating_stddev is null
        )
    and tt.deleted is false
    ;

-- Report on all Participants missing values
--  No participants lack age-range or education-type lookup, so report those to aid in finding participants
--  Use "distinct" to only report each participant once per Listing
select distinct on (tp.test_participant_id) cr.certified_product_id, tp.test_participant_id, tpa.age, et."name"
from openchpl.test_task as tt,
    openchpl.certification_criterion as cc,
    openchpl.certification_result as cr,
    openchpl.certification_result_test_task as crtt,
    openchpl.test_participant as tp,
    openchpl.test_task_participant_map as ttpm,
    openchpl.test_participant_age as tpa,
    openchpl.education_type as et
where
    cc.certification_criterion_id = cr.certification_criterion_id
    and cr.certification_result_id = crtt.certification_result_id
    and crtt.test_task_id = tt.test_task_id
    and tp.test_participant_id = ttpm.test_participant_id
    and ttpm.test_task_id = tt.test_task_id
    and tp.test_participant_age_id = tpa.test_participant_age_id
    and tp.education_type_id = et.education_type_id
    and (
        tp.gender is null
        or tp.education_type_id is null
        or tp.occupation is null
        or tp.professional_experience_months is null
        or tp.computer_experience_months is null
        or tp.product_experience_months is null
        or tp.assistive_technology_needs is null
        or tp.test_participant_age_id is null
        )
    and tp.deleted is false
    ;

-- Set all Task values to "-1" or "Unknown", depending on type, where null
--  Include 'deleted' Tasks, so the later alter won't break
update openchpl.test_task as tt set description = 'Unknown' where tt.description is null;
update openchpl.test_task as tt set task_errors_pct = -1 where tt.task_errors_pct is null;
update openchpl.test_task as tt set task_success_avg_pct = -1 where tt.task_success_avg_pct is null;
update openchpl.test_task as tt set task_success_stddev_pct = -1 where tt.task_success_stddev_pct is null;
update openchpl.test_task as tt set task_path_deviation_observed = -1 where tt.task_path_deviation_observed is null;
update openchpl.test_task as tt set task_path_deviation_optimal = -1 where tt.task_path_deviation_optimal is null;
update openchpl.test_task as tt set task_time_avg_seconds = -1 where tt.task_time_avg_seconds is null;
update openchpl.test_task as tt set task_time_stddev_seconds = -1 where tt.task_time_stddev_seconds is null;
update openchpl.test_task as tt set task_time_deviation_observed_avg_seconds = -1 where tt.task_time_deviation_observed_avg_seconds is null;
update openchpl.test_task as tt set task_time_deviation_optimal_avg_seconds = -1 where tt.task_time_deviation_optimal_avg_seconds is null;
update openchpl.test_task as tt set task_errors_pct = -1 where tt.task_errors_pct is null;
update openchpl.test_task as tt set task_errors_stddev_pct = -1 where tt.task_errors_stddev_pct is null;
update openchpl.test_task as tt set task_rating_scale = 'Unknown' where tt.task_rating_scale is null;
update openchpl.test_task as tt set task_rating = -1 where tt.task_rating is null;
update openchpl.test_task as tt set task_rating_stddev = -1 where tt.task_rating_stddev is null;

-- Set all Participant values to "-1" or "Unknown", depending on type, where null
--  Include 'deleted' participants, so the later alter won't break
update openchpl.test_participant as tp set gender = 'Unknown' where tp.gender is null;
update openchpl.test_participant as tp set occupation = 'Unknown' where tp.occupation is null;
update openchpl.test_participant as tp set professional_experience_months = -1 where tp.professional_experience_months is null;
update openchpl.test_participant as tp set computer_experience_months = -1 where tp.computer_experience_months is null;
update openchpl.test_participant as tp set product_experience_months = -1 where tp.product_experience_months is null;
update openchpl.test_participant as tp set assistive_technology_needs = 'Unknown' where tp.assistive_technology_needs is null;

-- Update tables to be required for fields
alter table openchpl.test_task
    alter column description set not null,
    alter column task_errors_pct set not null,
    alter column task_errors_stddev_pct set not null,
    alter column task_path_deviation_observed set not null,
    alter column task_path_deviation_optimal set not null,
    alter column task_rating set not null,
    alter column task_rating_scale set not null,
    alter column task_rating_stddev set not null,
    alter column task_success_avg_pct set not null,
    alter column task_success_stddev_pct set not null,
    alter column task_time_avg_seconds set not null,
    alter column task_time_deviation_observed_avg_seconds set not null,
    alter column task_time_deviation_optimal_avg_seconds set not null,
    alter column task_time_stddev_seconds set not null
    ;

alter table openchpl.test_participant
    alter column gender set not null,
    alter column education_type_id set not null,
    alter column occupation set not null,
    alter column professional_experience_months set not null,
    alter column computer_experience_months set not null,
    alter column product_experience_months set not null,
    alter column assistive_technology_needs set not null,
    alter column test_participant_age_id set not null
    ;

-- Remove "age" column from test_participant; never in use
alter table openchpl.test_participant drop column if exists age;
