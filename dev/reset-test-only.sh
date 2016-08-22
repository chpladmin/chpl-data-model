#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 2 ]; then
    psql -Upostgres -f drop-openchpl.sql openchpl_test
    psql -Upostgres -f openchpl_data-model.sql openchpl_test
    psql -Upostgres -f openchpl_audit.sql openchpl_test
    psql -Upostgres -f openchpl_views.sql openchpl_test
    psql -Upostgres -f openchpl_preload.sql openchpl_test
    psql -Upostgres -f openchpl_api-key.sql openchpl_test
    psql -Upostgres -f openchpl_grant-all.sql openchpl_test
else
    host=$1
    user=$2

    psql -h $host -U $user -f drop-openchpl.sql openchpl_test
    psql -h $host -U $user -f openchpl_data-model.sql openchpl_test
    psql -h $host -U $user -f openchpl_audit.sql openchpl_test
    psql -h $host -U $user -f openchpl_views.sql openchpl_test
    psql -h $host -U $user -f openchpl_preload.sql openchpl_test
    psql -h $host -U $user -f openchpl_api-key.sql openchpl_test
    psql -h $host -U $user -f openchpl_grant-all.sql openchpl_test
fi
