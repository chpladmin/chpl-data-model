#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -lt 2 ]; then
    psql -Upostgres -f drop-openchpl.sql openchpl_test
    psql -Upostgres -f openchpl_data-model.sql openchpl_test
    psql -Upostgres -f openchpl_audit.sql openchpl_test
    psql -Upostgres -f openchpl_soft-delete.sql openchpl_test
    psql -Upostgres -f openchpl_views.sql openchpl_test
    psql -Upostgres -f openchpl_preload.sql openchpl_test
    psql -Upostgres -f openchpl_api-key.sql openchpl_test
    psql -Upostgres -f openchpl_quartz.sql openchpl_test
    psql -Upostgres -f openchpl_grant-all.sql openchpl_test
    psql -Upostgres -f openchpl_preload-test-only.sql openchpl_test
elif [ $# -eq 2 ]; then
	host=$1
    user=$2

    psql -h $host -U $user -f drop-openchpl.sql openchpl_test
    psql -h $host -U $user -f openchpl_data-model.sql openchpl_test
    psql -h $host -U $user -f openchpl_audit.sql openchpl_test
    psql -h $host -U $user -f openchpl_soft-delete.sql openchpl_test
    psql -h $host -U $user -f openchpl_views.sql openchpl_test
    psql -h $host -U $user -f openchpl_preload.sql openchpl_test
    psql -h $host -U $user -f openchpl_api-key.sql openchpl_test
    psql -h $host -U $user -f openchpl_quartz.sql openchpl_test
    psql -h $host -U $user -f openchpl_grant-all.sql openchpl_test
    psql -h $host -U $user -f openchpl_preload-test-only.sql openchpl_test
elif [ $# -eq 3 ]; then
    host=$1
    user=$2
	db=$3
	
	psql -h $host -U postgres -c "DROP DATABASE IF EXISTS $db;"
	psql -h $host -U postgres -c "CREATE DATABASE $db WITH OWNER = openchpl_dev ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;";
    psql -h $host -U $user -f drop-openchpl.sql $db
    psql -h $host -U $user -f openchpl_data-model.sql $db
    psql -h $host -U $user -f openchpl_audit.sql $db
    psql -h $host -U $user -f openchpl_soft-delete.sql $db
    psql -h $host -U $user -f openchpl_views.sql $db
    psql -h $host -U $user -f openchpl_preload.sql $db
    psql -h $host -U $user -f openchpl_api-key.sql $db
    psql -h $host -U $user -f openchpl_quartz.sql $db
    psql -h $host -U $user -f openchpl_grant-all.sql $db
    psql -h $host -U $user -f openchpl_preload-test-only.sql $db
else
	echo 'This script can be run with 0, 2, or 3 arguments. Please check your input and try again.'
fi
