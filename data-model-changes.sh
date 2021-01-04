#!/bin/bash
#(set -o igncr) 2>/dev/null
set -o igncr; # this comment is required to trick cygwin into dealing with windows vs. linux EOL characters

function helpFunction {
   echo ""
   echo "Connection options:"
   echo -e "\t-h database server host or socket directory"
   echo -e "\t-u database user name"
   exit 1 # Exit script after printing help
}

while getopts 'h:u:?' flag; do
    case "${flag}" in
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

#Exit on failure
set -e

for FILE in ./changes/ocd-????.sql; do
   echo $FILE;
   psql -U $USER -h $HOST -f $FILE;
done

psql -U $USER -h $HOST -f dev/openchpl_soft-delete.sql
psql -U $USER -h $HOST -f dev/openchpl_views.sql
psql -U $USER -h $HOST -f dev/openchpl_grant-all.sql
