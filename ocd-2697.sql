--
-- OCD-2697: accept bad characters in number fields for test/participant data during upload
--
alter table openchpl.pending_test_participant
alter column professional_experience_months type text,
alter column computer_experience_months type text,
alter column product_experience_months type text;

alter table openchpl.pending_test_task
alter column task_success_avg_pct type text,
alter column task_success_stddev_pct type text,
alter column task_path_deviation_observed type text,
alter column task_path_deviation_optimal type text,
alter column task_time_avg_seconds type text,
alter column task_time_stddev_seconds type text,
alter column task_time_deviation_observed_avg_seconds type text,
alter column task_time_deviation_optimal_avg_seconds type text,
alter column task_errors_pct type text,
alter column task_errors_stddev_pct type text,
alter column task_rating type text,
alter column task_rating_stddev type text;
