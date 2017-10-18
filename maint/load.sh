#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

# parse command line inputs
env=local
filename=openchpl.backup
host=localhost
user=openchpl_dev

while getopts 'e:f:h:u:' flag; do
    case "${flag}" in
        e) env="${OPTARG}" ;;
        f) filename="${OPTARG}" ;;
        h) host="${OPTARG}" ;;
        u) user="${OPTARG}" ;;
        *) printf 'Usage: %s: [-e environment] [-f filename ] [-h host] [-u user]
   -e: environment [local|dev|stg] (default "local")
   -f: backup file to load (default "openchpl.backup")
   -h: host IP for postgres DB (default "localhost")
   -u: user performing load (default "openchpl_dev")
   -?: print this message\n' $0; exit 0 ;;
    esac
done

psql --host $host --username $user --no-password -c "drop schema if exists audit cascade;" openchpl
psql --host $host --username $user --no-password -c "drop schema if exists openchpl cascade;" openchpl
pg_restore --host $host --username $user --no-password --verbose --clean --if-exists --dbname openchpl $filename

case $env in
    stg)
        psql --host $host --username $user -f users.sql openchpl
        psql --host $host --username $user -f subscriptions.sql openchpl
        ;;
    dev|local)
        printf 'Not loading users or subscriptions\n'
        ;;
    *)
        printf 'Environment not found\n'; exit 1 ;;
esac
