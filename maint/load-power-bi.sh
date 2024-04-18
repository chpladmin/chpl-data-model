#!/bin/bash

function usage {

    cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE    Specifies the host name of the postgres source database machine 		(default: localhost)
  -p VALUE    Port to connect on the source database machine						(default: 5432)
  -u VALUE    User name to connect to the source database 							(default: openchpl_dev)
  -i VALUE    Specifies the host name of the postgres destination database machine 	(default: localhost)
  -q VALUE    Port to connect on the destination database machine					(default: 5432)
  -v VALUE    User name to connect to the destination database for queries			(default: openchpl_bi)  
  -w VALUE    User name to connect to the destination database for admin			(default: openchpl_dev)    
  -d VALUE    Database name on the destination system								(default: openchpl_bi)    
  -f VALUE    File name of output                                                   (default: openchpl.powerbi.backup)
  -?          display help
EOM

    exit 2
}

SOURCE_HOST=localhost
SOURCE_PORT=5432
SOURCE_USER=openchpl_dev
DEST_HOST=localhost
DEST_PORT=5432
DEST_QUERY_USER=openchpl_bi
DEST_ADMIN_USER=openchpl_dev
DEST_DB=openchpl_bi
FILE=openchpl.powerbi.backup

while getopts "h:p:u:i:q:v:w:d:f?" OPTION; do
    case "$OPTION" in
        h)
			SOURCE_HOST=$OPTARG
            ;;
        p)
            SOURCE_PORT=$OPTARG
            ;;
        u)
            SOURCE_USER=$OPTARG
            ;;			
        i)
			DEST_HOST=$OPTARG
            ;;
        q)
            DEST_PORT=$OPTARG
            ;;		
        v)
            DEST_QUERY_USER=$OPTARG
            ;;		
        w)
            DEST_ADMIN_USER=$OPTARG
            ;;				
        d)
            DEST_DB=$OPTARG
            ;;						
        f)
            FILE=$OPTARG
            ;;
        ?)
        usage
        ;;
    esac
done
shift $((OPTIND-1))

echo "h = $SOURCE_HOST"
echo "p = $SOURCE_PORT"
echo "u = $SOURCE_USER"
echo "i = $DEST_HOST"
echo "q = $DEST_PORT"
echo "v = $DEST_QUERY_USER"
echo "w = $DEST_ADMIN_USER"
echo "d = $DEST_DB"
echo "f = $FILE"

# We probably need two user accounts on the destination:
#	1. An ADMIN type of user that has permission to drop and create tables and delete data, and
#	2. A user that we will connect to Power BI with that can read all the tables, views etc
# The destination users must exist before continuing. 
# This should mimic the openchpl_role sql that we use when creating other databases. 
# It is not checked into this file because creating the users includes assigning a password.

# Dump data that Power BI needs from the source database
pg_dump --host $SOURCE_HOST --port $SOURCE_PORT --username $SOURCE_USER --no-password --format custom --blobs --verbose --exclude-table-data=shared_store.* --exclude-table-data=quartz.* --exclude-table-data=ff4j.* --exclude-table-data=audit.*  --exclude-table-data=openchpl.api_key_activity  --exclude-table-data=openchpl.activity --file $FILE openchpl

# Create the destination database if it does not exist
psql -h $DEST_HOST -c "DROP DATABASE IF EXISTS openchpl_bi;" -U$DEST_ADMIN_USER -qtAX
psql -h $DEST_HOST -c "CREATE DATABASE openchpl_bi WITH OWNER = $DEST_ADMIN_USER ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1;" -U$DEST_ADMIN_USER -qtAX

# Load data for Power BI into the destination database
pg_restore --host $DEST_HOST --port $DEST_PORT --username $DEST_ADMIN_USER --no-password --verbose --clean --if-exists --dbname $DEST_DB $FILE

# Set read-only privileges for the destination query user
psql -h $DEST_HOST -c "GRANT USAGE ON SCHEMA openchpl TO $DEST_QUERY_USER;" -U$DEST_ADMIN_USER -qtAX
psql -h $DEST_HOST -c "GRANT SELECT ON ALL TABLES IN SCHEMA openchpl TO $DEST_QUERY_USER;" -U$DEST_ADMIN_USER -qtAX
psql -h $DEST_HOST -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA openchpl TO $DEST_QUERY_USER;" -U$DEST_ADMIN_USER -qtAX
psql -h $DEST_HOST -c "GRANT SELECT ON ALL FUNCTIONS IN SCHEMA openchpl TO $DEST_QUERY_USER;" -U$DEST_ADMIN_USER -qtAX

####
# Modify the data/views in some way that is TBD in a future ticket
#  - delete+cascade soft-deleted data
#  - create views for BI users
####

