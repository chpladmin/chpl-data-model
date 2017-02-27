#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 3 ]; then
    pg_dump --host localhost --port 5432 --username "openchpl" --role "openchpl" --no-password --format custom --blobs --verbose --file "openchpl.backup" "openchpl"
else
    host=$1
    user=$2
    role=$3

    pg_dump --host $host --port 5432 --username "$user" --role "$role" --no-password --format custom --blobs --verbose --file "openchpl.backup" "openchpl"
fi
