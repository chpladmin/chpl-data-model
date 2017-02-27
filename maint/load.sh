#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 3 ]; then
    pg_restore --host localhost --port 5432 --username "openchpl" --role "openchpl" --no-password --verbose --clean --dbname "openchpl" "openchpl.backup"
else
    host=$1
    user=$2
    role=$3

    pg_restore --host $host --port 5432 --username "$user" --role "$role" --no-password --verbose --clean --dbname "openchpl" "openchpl.backup"
fi
