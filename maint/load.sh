#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

# parse command line inputs
filename=openchpl.backup
host=localhost
port=5432
user=openchpl_dev

while getopts 'f:h:p:u:?' flag; do
    case "${flag}" in
        f) filename="${OPTARG}" ;;
        h) host="${OPTARG}" ;;
        p) port="${OPTARG}" ;;
        u) user="${OPTARG}" ;;
        *) printf 'Usage: %s: [-f filename ] [-h host] [-p port] [-u user]
   -f: backup file to load (default "openchpl.backup")
   -h: host IP for postgres DB (default "localhost")
   -p: host port for postgres DB (default "5432")
   -u: user performing load (default "openchpl_dev")
   -?: print this message\n' $0; exit 0 ;;
    esac
done

psql --host $host --port $port --username openchpl --no-password -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'openchpl' AND pid <> pg_backend_pid();" openchpl

#drop the audit schema
psql --host $host --port $port --username $user --no-password -c "DROP schema if exists audit CASCADE;" openchpl

#drop openchpl schema
psql --host $host --port $port --username $user --no-password -c "DROP schema if exists openchpl CASCADE;" openchpl
 
#restore to openchpl and audit
pg_restore --host $host --port $port --username $user --no-password --verbose --clean --if-exists --exclude-schema=ff4j --exclude-schema=quartz --dbname openchpl  $filename

# add users if users file exists
usersFile=users.sql
if [ -f $usersFile ]
then
    psql --host $host --port $port --username $user -f create-user.sql openchpl
    psql --host $host --port $port --username $user -f $usersFile openchpl
else
    printf 'No users file to load.'
fi
