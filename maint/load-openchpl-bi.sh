#!/bin/bash

function usage {

    cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE    Specifies the host name of the postgres destination database machine 		(default: localhost)
  -p VALUE    Port to connect on the destination database machine						(default: 5432)
  -u VALUE    User name to connect to the destination database for queries				(default: openchpl_bi)
  -v VALUE    User name to connect to the destination database for admin				(default: openchpl_bi_admin)    
  -d VALUE    Database name on the destination system									(default: openchpl_bi)    
  -f VALUE    File name to load                                                   		(default: openchpl.bi.backup)
  -?          display help
EOM

    exit 2
}

DEST_HOST=localhost
DEST_PORT=5432
DEST_QUERY_USER=openchpl_bi
DEST_ADMIN_USER=openchpl_bi_admin
DEST_DB=openchpl_bi
FILE=openchpl.bi.backup

while getopts "h:p:u:v:d:f?" OPTION; do
    case "$OPTION" in
        h)
			DEST_HOST=$OPTARG
            ;;
        p)
            DEST_PORT=$OPTARG
            ;;
        u)
            DEST_QUERY_USER=$OPTARG
            ;;			
        v)
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

echo "h = $DEST_HOST"
echo "p = $DEST_PORT"
echo "u = $DEST_QUERY_USER"
echo "v = $DEST_ADMIN_USER"
echo "d = $DEST_DB"
echo "f = $FILE"

# We probably need two user accounts on the destination:
#	1. An ADMIN type of user that has permission to drop and create tables and delete data, and
#	2. A user that we will connect to Power BI with that can read all the tables, views etc
# This should mimic the openchpl_role sql that we use when creating other databases. 
# It is not checked into this file because creating the users includes assigning a password.
# The destination users must exist before running this script. 
# Destination database must exist and be owned by the ADMIN user

# Clearing the tables in the destination db
echo "Clearing $DEST_DB database on $DEST_HOST"
psql --host $DEST_HOST --port $DEST_PORT --username $DEST_ADMIN_USER --no-password -c "DROP schema IF EXISTS openchpl CASCADE;" $DEST_DB
echo "Completed clearing $DEST_DB database on $DEST_HOST"

# Load data for Power BI into the destination database
echo "Loading $FILE into $DEST_DB database on $DEST_HOST"
pg_restore --host $DEST_HOST --port $DEST_PORT --username $DEST_ADMIN_USER --no-password --verbose --clean --if-exists --dbname $DEST_DB $FILE
echo "Completed loading $FILE into $DEST_DB database on $DEST_HOST"

# Set read-only privileges for the destination query user
echo "Setting privileges for $DEST_QUERY_USER on $DEST_DB database"
psql --host $DEST_HOST --port $DEST_PORT -c "GRANT USAGE ON SCHEMA openchpl TO $DEST_QUERY_USER;" --username $DEST_ADMIN_USER --dbname $DEST_DB
psql --host $DEST_HOST --port $DEST_PORT -c "GRANT SELECT ON ALL TABLES IN SCHEMA openchpl TO $DEST_QUERY_USER;" --username $DEST_ADMIN_USER --dbname $DEST_DB
psql --host $DEST_HOST --port $DEST_PORT -c "GRANT SELECT ON ALL SEQUENCES IN SCHEMA openchpl TO $DEST_QUERY_USER;" --username $DEST_ADMIN_USER --dbname $DEST_DB
psql --host $DEST_HOST --port $DEST_PORT -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA openchpl TO $DEST_QUERY_USER;" --username $DEST_ADMIN_USER --dbname $DEST_DB
echo "Completed setting privileges for $DEST_QUERY_USER on $DEST_DB database"

####
# Modify the data/views in some way that is TBD in a future ticket
#  - delete+cascade soft-deleted data
#  - create views for BI users
####


