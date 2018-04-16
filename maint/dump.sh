#!/bin/bash

function usage {

    cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE    Specifies the host name of the machine on which the server is running (default: localhost)
  -u VALUE    User name to connect as                                               (default: openchpl_dev)
  -f VALUE    File name of output                                                   (default: openchpl.backup)
  -i          Includes the logged_actions table data                                (default: false)
  -h          display help
EOM

    exit 2
}

INCLUDE=0
HOST=localhost
USER=openchpl_dev
FILE=openchpl.backup

while getopts ":h:u:f:i" OPTION; do
    case "$OPTION" in
        h)
	    HOST=$OPTARG
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

echo "h = $HOST"
echo "u = $USER"
echo "f = $FILE"
echo "i = $INCLUDE"

if [ $INCLUDE -eq 1 ]
then
    pg_dump --host $HOST --username $USER --no-password --format custom --blobs --verbose --file $FILE openchpl
else
    pg_dump --host $HOST --username $USER --no-password --format custom --blobs --verbose --exclude-table-data=audit.logged_actions --file $FILE openchpl
fi
