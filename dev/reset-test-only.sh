#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

psql -Upostgres -f drop-openchpl.sql openchpl_test
psql -Upostgres -f openchpl_data-model.sql openchpl_test
psql -Upostgres -f openchpl_audit.sql openchpl_test
psql -Upostgres -f openchpl_views.sql openchpl_test
psql -Upostgres -f openchpl_preload.sql openchpl_test
psql -Upostgres -f openchpl_api-key.sql openchpl_test
psql -Upostgres -f openchpl_grant-all.sql openchpl_test
