#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 2 ]; then
    host=localhost
    user=openchpl_dev
else
    host=$1
    user=$2
fi
psql --host $host --username $user --no-password -c "drop schema if exists audit cascade;" openchpl
psql --host $host --username $user --no-password -c "drop schema if exists openchpl cascade;" openchpl
pg_restore --host $host --username $user --no-password --verbose --clean --if-exists --dbname openchpl openchpl.backup
