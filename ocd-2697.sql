--
-- OCD-2697: accept bad characters during upload
--
alter table openchpl.pending_certified_product
alter column certification_date type varchar(50),
alter column vendor_transparency_attestation type varchar(50),
alter column accessibility_certified type varchar(25),
alter column sed_testing_end type varchar(50),
alter column has_qms type varchar(25);

alter table openchpl.pending_test_participant
alter column professional_experience_months type varchar(25),
alter column computer_experience_months type varchar(25),
alter column product_experience_months type varchar(25);

alter table openchpl.pending_test_task
alter column task_success_avg_pct type varchar(25),
alter column task_success_stddev_pct type varchar(25),
alter column task_path_deviation_observed type varchar(25),
alter column task_path_deviation_optimal type varchar(25),
alter column task_time_avg_seconds type varchar(25),
alter column task_time_stddev_seconds type varchar(25),
alter column task_time_deviation_observed_avg_seconds type varchar(25),
alter column task_time_deviation_optimal_avg_seconds type varchar(25),
alter column task_errors_pct type varchar(25),
alter column task_errors_stddev_pct type varchar(25),
alter column task_rating type varchar(25),
alter column task_rating_stddev type varchar(25);

alter table openchpl.pending_certification_result
alter column meets_criteria type varchar(25),
alter column gap type varchar(25),
alter column sed type varchar(25),
alter column g1_success type varchar(25),
alter column g2_success type varchar(25);

alter table openchpl.pending_cqm_criterion
alter column meets_criteria type varchar(25);
