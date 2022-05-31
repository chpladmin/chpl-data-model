#!/bin/bash

if [ $# -lt 2 ]; then
    psql -Upostgres -c "TRUNCATE shared_store.shared_store;" openchpl
elif [ $# -eq 2 ]; then
    host=$1
    user=$2

    psql -h $host -U $user -c "TRUNCATE shared_store.shared_store;" openchpl
elif [ $# -eq 3 ]; then
    host=$1
    user=$2
    db=$3

    psql -h $host -U $user -c "TRUNCATE shared_store.shared_store;" $db
else
    echo 'This script can be run with 0, 2, or 3 arguments. Please check your input and try again.'
fi





