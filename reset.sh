#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

host=$1
user=$2

if [ $# -ne 2 ]; then
    host=localhost
    user=postgres
fi


psql -h $host -U $user -f drop-openchpl.sql openchpl
psql -h $host -U $user -f drop-openchpl.sql openchpl_test
#psql -h $host -U $user -f drop-role.sql
#psql -h $host -U $user -f openchpl_role.sql
#psql -h $host -U $user -f openchpl_database.sql
psql -h $host -U $user -f openchpl_data-model.sql openchpl
psql -h $host -U $user -f openchpl_data-model.sql openchpl_test
psql -h $host -U $user -f openchpl_audit.sql openchpl
psql -h $host -U $user -f openchpl_audit.sql openchpl_test
psql -h $host -U $user -f openchpl_views.sql openchpl
psql -h $host -U $user -f openchpl_views.sql openchpl_test
psql -h $host -U $user -f openchpl_preload.sql openchpl
psql -h $host -U $user -f openchpl_preload.sql openchpl_test
psql -h $host -U $user -f openchpl_api-key.sql openchpl
psql -h $host -U $user -f openchpl_api-key.sql openchpl_test
psql -h $host -U $user -f openchpl_grant-all.sql openchpl
psql -h $host -U $user -f openchpl_grant-all.sql openchpl_test
