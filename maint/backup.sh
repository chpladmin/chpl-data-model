#!/bin/bash
#(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

# Generates dump files, outputting them into ./backups directory
# Then deletes all files older than $numdays (defaulted to 14)
# Place into crontab with something like
# 15 5 * * * cd /some-directory/chpl-data-model/maint && ./backup.sh
# This will run it at 0515 UTC, which (depending on DST) is 0015 EST

# parse command line inputs
#   default to 14 days and localhost
host=localhost
numdays=14

while getopts 'H:n:h?' flag; do
    case "${flag}" in
        H) host="${OPTARG}" ;;
        n) numdays="${OPTARG}" ;;
        *) printf 'Usage: %s: [-H hostname] [-n numdays]
   -H: hostname of the database
   -n: number of days to keep
   -h, -?: print this message\n' $0; exit 0 ;;
    esac
done

TIMESTAMP=$(date "+%Y.%m.%d-%H.%M.%S")

pg_dump --host $host --username openchpl_dev --no-password --format custom --blobs --verbose --file backups/openchpl.$TIMESTAMP.backup openchpl

expression=".*openchpl.*backup"

# execute
find backups/ -type f -mtime +$numdays -regex $expression \
     -delete
