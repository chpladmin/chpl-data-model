#code to put in catalina.sh, immediately below 'touch "CATALINA_OUT"' in the 'start' section
# while loop will loop as long as the database server isn't accessible, with a 5 second spin time

    #ensure database is up
    while : ; do
        (psql -hIP_ADDRESS -Uopenchpl -l) >> /dev/null 2>&1
        if [ $? -eq 0 ]; then
            break
        fi
        echo 'No DB connection at: ' $(date "+%Y.%m.%d-%H.%M.%S") >> "$CATALINA_OUT"
        sleep 5
    done
    echo 'DB connection found at: ' $(date "+%Y.%m.%d-%H.%M.%S") >> "$CATALINA_OUT"
