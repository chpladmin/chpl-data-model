#!/bin/bash

function usage {

	cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE    Specifies the host name of the machine on which the server is running
  -u VALUE    User name to connect as
  -i          Includes the logged_actions table data
  -h          display help
EOM

	exit 2
}

INCLUDE=0
HOST=localhost
USER=openchpl_dev

while getopts ":h:u:i" OPTION; do
    case "$OPTION" in
        h)
			HOST=$OPTARG
            ;;
        u)
            USER=$OPTARG
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
echo "i = $INCLUDE"

if [ $INCLUDE -eq 1 ]  
then
	pg_dump --host $HOST --username $USER --no-password --format custom --blobs --verbose --file openchpl.backup openchpl 
else
	pg_dump --host $HOST --username $USER --no-password --format custom --blobs --verbose --exclude-table-data=audit.logged_actions --file openchpl.backup openchpl 
fi
