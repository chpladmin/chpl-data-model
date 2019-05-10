#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 2 ]; then
    psql -Uopenchpl -f drop-openchpl.sql openchpl
    psql -Uopenchpl -f drop-openchpl.sql openchpl_test
    psql -Uopenchpl -f openchpl_data-model.sql openchpl
    psql -Uopenchpl -f openchpl_data-model.sql openchpl_test
    psql -Uopenchpl -f openchpl_audit.sql openchpl
    psql -Uopenchpl -f openchpl_audit.sql openchpl_test
    psql -Uopenchpl -f openchpl_soft-delete.sql openchpl
    psql -Uopenchpl -f openchpl_soft-delete.sql openchpl_test
    psql -Uopenchpl -f openchpl_views.sql openchpl
    psql -Uopenchpl -f openchpl_views.sql openchpl_test
    psql -Uopenchpl -f openchpl_preload.sql openchpl
    psql -Uopenchpl -f openchpl_preload.sql openchpl_test
    psql -Uopenchpl -f openchpl_api-key.sql openchpl
    psql -Uopenchpl -f openchpl_api-key.sql openchpl_test
    psql -Uopenchpl -f openchpl_quartz.sql openchpl
    psql -Uopenchpl -f openchpl_quartz.sql openchpl_test
	psql -Uopenchpl -f openchpl_ff4j.sql openchpl
    psql -Uopenchpl -f openchpl_ff4j.sql openchpl_test
    psql -Uopenchpl -f openchpl_grant-all.sql openchpl
    psql -Uopenchpl -f openchpl_grant-all.sql openchpl_test
else
    host=$1
    user=$2

    psql -h $host -U $user -f drop-openchpl.sql openchpl
    psql -h $host -U $user -f drop-openchpl.sql openchpl_test
    psql -h $host -U $user -f openchpl_data-model.sql openchpl
    psql -h $host -U $user -f openchpl_data-model.sql openchpl_test
    psql -h $host -U $user -f openchpl_audit.sql openchpl
    psql -h $host -U $user -f openchpl_audit.sql openchpl_test
    psql -h $host -U $user -f openchpl_soft-delete.sql openchpl
    psql -h $host -U $user -f openchpl_soft-delete.sql openchpl_test
    psql -h $host -U $user -f openchpl_views.sql openchpl
    psql -h $host -U $user -f openchpl_views.sql openchpl_test
    psql -h $host -U $user -f openchpl_preload.sql openchpl
    psql -h $host -U $user -f openchpl_preload.sql openchpl_test
    psql -h $host -U $user -f openchpl_api-key.sql openchpl
    psql -h $host -U $user -f openchpl_api-key.sql openchpl_test
    psql -h $host -U $user -f openchpl_quartz.sql openchpl
    psql -h $host -U $user -f openchpl_quartz.sql openchpl_test
	psql -h $host -U $user -f openchpl_ff4j.sql openchpl
    psql -h $host -U $user -f openchpl_ff4j.sql openchpl_test
    psql -h $host -U $user -f openchpl_grant-all.sql openchpl
    psql -h $host -U $user -f openchpl_grant-all.sql openchpl_test
fi
