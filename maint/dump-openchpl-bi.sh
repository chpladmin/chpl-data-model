#!/bin/bash

function usage {

    cat <<EOM
Usage: $(basename "$0") [OPTION]...

  -h VALUE    Specifies the host name of the postgres source database machine 		(default: localhost)
  -p VALUE    Port to connect on the source database machine						(default: 5432)
  -u VALUE    User name to connect to the source database 							(default: openchpl_dev)    
  -d VALUE    Database name on the source system									(default: openchpl)    
  -f VALUE    File name of output                                                   (default: openchpl.bi.backup)
  -?          display help
EOM

    exit 2
}

SOURCE_HOST=localhost
SOURCE_PORT=5432
SOURCE_USER=openchpl_dev
SOURCE_DB=openchpl
FILE=openchpl.bi.backup

while getopts "h:p:u:d:f?" OPTION; do
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
        d)
            SOURCE_DB=$OPTARG
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
echo "d = $SOURCE_DB"
echo "f = $FILE"

# Dump data that Power BI needs from the source database
echo "Dumping data from $SOURCE_DB database on $SOURCE_HOST"
pg_dump --host $SOURCE_HOST --port $SOURCE_PORT --username $SOURCE_USER --no-password --format custom --blobs --verbose --exclude-schema=shared_store --exclude-schema=quartz --exclude-schema=ff4j --exclude-table-data=audit.* --exclude-table-data=openchpl.api_key_activity  --exclude-table-data=openchpl.activity --exclude-table-data=openchpl.activity_concept --exclude-table-data=openchpl.questionable_activity_certification_result --exclude-table-data=openchpl.questionable_activity_developer --exclude-table-data=openchpl.questionable_activity_listing --exclude-table-data=openchpl.questionable_activity_product --exclude-table-data=openchpl.questionable_activity_trigger --exclude-table-data=openchpl.questionable_activity_version --exclude-table-data=openchpl.complaint --exclude-table-data=openchpl.complainant_type --exclude-table-data=openchpl.complaint_criterion_map --exclude-table-data=openchpl.complaint_listing_map --exclude-table-data=openchpl.complaint_surveillance_map --file $FILE $SOURCE_DB
echo "Completed dumping data from $SOURCE_DB database on $SOURCE_HOST into $FILE"



