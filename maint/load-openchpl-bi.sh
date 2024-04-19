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
  -w VALUE    User name to connect to the destination database for admin			(default: openchpl_bi_admin)    
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
DEST_ADMIN_USER=openchpl_bi_admin
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
# Destination database must exist and be owned by the ADMIN user

# Dump data that Power BI needs from the source database
echo "Dumping data from openchpl database on $SOURCE_HOST"
pg_dump --host $SOURCE_HOST --port $SOURCE_PORT --username $SOURCE_USER --no-password --format custom --blobs --verbose --exclude-schema=shared_store --exclude-schema=quartz --exclude-schema=ff4j --exclude-table-data=audit.* --exclude-table-data=openchpl.api_key_activity  --exclude-table-data=openchpl.activity --exclude-table-data=openchpl.activity_concept --exclude-table-data=openchpl.questionable_activity_certification_result --exclude-table-data=openchpl.questionable_activity_developer --exclude-table-data=openchpl.questionable_activity_listing --exclude-table-data=openchpl.questionable_activity_product --exclude-table-data=openchpl.questionable_activity_trigger --exclude-table-data=openchpl.questionable_activity_version --exclude-table-data=openchpl.complaint --exclude-table-data=openchpl.complainant_type --exclude-table-data=openchpl.complaint_criterion_map --exclude-table-data=openchpl.complaint_listing_map --exclude-table-data=openchpl.complaint_surveillance_map --file $FILE openchpl
echo "Completed dumping data from openchpl database on $SOURCE_HOST into $FILE"

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


