psql -Upostgres -f drop-openchpl.sql openchpl_test
psql -Upostgres -f openchpl_data-model.sql openchpl_test
psql -Upostgres -f openchpl_audit.sql openchpl_test
psql -Upostgres -f openchpl_views.sql openchpl_test
psql -Upostgres -f openchpl_preload.sql openchpl_test
