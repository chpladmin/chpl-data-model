#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

if [ $# -ne 2 ]; then
    pg_dump --host localhost --username openchpl --no-password --format custom --blobs --verbose --file openchpl.backup openchpl
else
    host=$1
    user=$2

    pg_dump --host $host --username $user --no-password --format custom --blobs --verbose --file openchpl.backup openchpl
fi
