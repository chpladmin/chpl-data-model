echo "Loading openchpl.backup into docker!"

psql -v ON_ERROR_STOP=1 --dbname openchpl --username "$POSTGRES_USER" --no-password -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'openchpl' AND pid <> pg_backend_pid();"

#drop the audit schema
psql -v ON_ERROR_STOP=1 --dbname openchpl --username "$POSTGRES_USER" --no-password -c "DROP schema if exists audit CASCADE;"

#drop openchpl schema
psql -v ON_ERROR_STOP=1 --dbname openchpl --username "$POSTGRES_USER" --no-password -c "DROP schema if exists openchpl CASCADE;"

#restore to openchpl and audit
pg_restore -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --no-password --verbose --clean --if-exists --exclude-schema=ff4j --exclude-schema=quartz --dbname openchpl /var/lib/postgresql/openchpl.backup

echo "Completed loading openchpl.backup"

