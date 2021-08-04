#!/bin/bash
#(set -o igncr) 2>/dev/null
set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

#Exit on failure
set -e

HOST=localhost
USER=openchpl_dev
DUMMY=true

function helpFunction {
    echo ""
    echo "Connection options:"
    echo -e "\t-d do not load dummy data.  Default: [load dummy data]"
    echo -e "\t-h database server host or socket directory.  Default: [localhost]"
    echo -e "\t-u database user name.  Default: [openchpl_dev]"
    exit 1 # Exit script after printing help
}

while getopts 'dh:u:?' flag; do
    case "${flag}" in
        d) DUMMY=false ;;
        h) HOST="${OPTARG}" ;;
        u) USER="${OPTARG}" ;;
        *) helpFunction ;;
    esac
done

# Print helpFunction in case parameters are empty
if [ -z "$HOST" ] || [ -z "$USER" ]
then
    echo "Some or all of the parameters are empty";
    echo Host: $HOST
    echo User: $USER
    helpFunction
fi

COUNT_CHANGES_FILES=` find ./changes/ -maxdepth 1 -name 'ocd-????.sql' | wc -l`
if [ $COUNT_CHANGES_FILES -gt 0 ]
then
    echo "Executing updates"
    for FILE in ./changes/ocd-????.sql; do
        echo $FILE;
        psql -U $USER -h $HOST -f $FILE openchpl;
    done
fi
COUNT_CHANGES_FILES=` find ./changes/ -maxdepth 1 -name 'ocd-????-dummy-data.sql' | wc -l`
if [ $COUNT_CHANGES_FILES -gt 0 ] && [ $DUMMY = true ]
then
    echo "Loading dummy data"
    for FILE in ./changes/ocd-????-dummy-data.sql; do
        echo $FILE;
        psql -U $USER -h $HOST -f $FILE openchpl;
    done
fi

psql -U $USER -h $HOST -f dev/openchpl_soft-delete.sql openchpl
psql -U $USER -h $HOST -f dev/openchpl_views.sql openchpl
psql -U $USER -h $HOST -f dev/openchpl_grant-all.sql openchpl
