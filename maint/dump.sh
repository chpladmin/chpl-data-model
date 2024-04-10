#!/bin/bash

function usage {

    cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -b VALUE    Specifies the database name                                           (default: openchpl)
  -h VALUE    Specifies the host name of the machine on which the server is running (default: localhost)
  -p VALUE    Port to connect on                                                    (default: 5432)
  -u VALUE    User name to connect as                                               (default: openchpl_dev)
  -f VALUE    File name of output                                                   (default: openchpl.backup)
  -i          Includes the logged_actions table data                                (default: false)
  -?          display help
EOM

    exit 2
}

INCLUDE=0
DB_NAME=openchpl
HOST=localhost
PORT=5432
USER=openchpl_dev
FILE=openchpl.backup

while getopts "h:p:u:f:i?" OPTION; do
    case "$OPTION" in
        b)
            DB_NAME=$OPTARG
            ;;
        h)
	    HOST=$OPTARG
            ;;
        p)
            PORT=$OPTARG
            ;;
        u)
            USER=$OPTARG
            ;;
        f)
            FILE=$OPTARG
            ;;
	i)
	    INCLUDE=1
	    ;;
        ?)
        usage
        ;;
    esac
done
shift $((OPTIND-1))

echo "b = $DB_NAME"
echo "h = $HOST"
echo "p = $PORT"
echo "u = $USER"
echo "f = $FILE"
echo "i = $INCLUDE"

if [ $INCLUDE -eq 1 ]
then
    pg_dump --host $HOST --username $USER --port $PORT --no-password --format custom --blobs --verbose --exclude-table-data=shared_store.* --exclude-table-data=quartz.* --exclude-table-data=ff4j.* --file $FILE $DB_NAME
else
    pg_dump --host $HOST --username $USER --port $PORT --no-password --format custom --blobs --verbose --exclude-table-data=shared_store.* --exclude-table-data=quartz.* --exclude-table-data=ff4j.* --exclude-table-data=openchpl.api_key_activity --exclude-table-data=audit.logged_actions --file $FILE $DB_NAME
fi
