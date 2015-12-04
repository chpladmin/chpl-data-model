psql -Upostgres -f drop-openchpl.sql openchpl
psql -Upostgres -f drop-openchpl.sql openchpl_test
psql -Upostgres -f drop-role.sql
psql -Upostgres -f openchpl_role.sql
psql -Upostgres -f openchpl_database.sql
psql -Upostgres -f openchpl_data-model.sql openchpl
psql -Upostgres -f openchpl_data-model.sql openchpl_test
psql -Upostgres -f openchpl_audit.sql openchpl
psql -Upostgres -f openchpl_audit.sql openchpl_test
psql -Upostgres -f openchpl_views.sql openchpl
psql -Upostgres -f openchpl_views.sql openchpl_test
psql -Upostgres -f openchpl_preload.sql openchpl
psql -Upostgres -f openchpl_preload.sql openchpl_test
