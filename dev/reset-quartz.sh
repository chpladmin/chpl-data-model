#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -lt 2 ]; then
    psql -Upostgres -c "drop schema quartz cascade" openchpl
    psql -Upostgres -f openchpl_quartz.sql openchpl
	psql -Upostgres -f openchpl_quartz_audit.sql openchpl
    psql -Upostgres -f openchpl_grant-all.sql openchpl
elif [ $# -eq 2 ]; then
    host=$1
    user=$2

    psql -h $host -U $user -c "drop schema quartz cascade" openchpl
    psql -h $host -U $user -f openchpl_quartz.sql openchpl
	psql -h $host -U $user -f openchpl_quartz_audit.sql openchpl
    psql -h $host -U $user -f openchpl_grant-all.sql openchpl
elif [ $# -eq 3 ]; then
    host=$1
    user=$2
    db=$3

    psql -h $host -U $user -c "drop schema quartz cascade" $db
    psql -h $host -U $user -f openchpl_quartz.sql $db
	psql -h $host -U $user -f openchpl_quartz_audit.sql $db
    psql -h $host -U $user -f openchpl_grant-all.sql $db
else
    echo 'This script can be run with 0, 2, or 3 arguments. Please check your input and try again.'
fi
