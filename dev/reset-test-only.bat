psql -Upostgres -p 5433 -f drop-openchpl.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_data-model.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_audit.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_soft-delete.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_views.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_preload.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_api-key.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_quartz.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_ff4j.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_grant-all.sql openchpl_test
psql -Upostgres -p 5433 -f openchpl_preload-test-only.sql openchpl_test