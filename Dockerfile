# Use the official PostgreSQL 15 image as the base
FROM postgres:15

# Set environment variables for PostgreSQL
# These variables are used when the container is first initialized
ENV POSTGRES_USER=postgres
#This configures PostgreSQL's pg_hba.conf file to use trust authentication for all local connections, effectively allowing the postgres user (and any other user connecting locally) to connect without a password.
ENV POSTGRES_HOST_AUTH_METHOD=trust

# The official PostgreSQL Docker image automatically executes any .sql, .sql.gz, or .sh files placed within the /docker-entrypoint-initdb.d/ directory when the container is first started
# The docker-entrypoint-initdb.d scripts only run on the first startup of a new, empty data volume. If you already have data in your volume, these scripts will not execute again.
# The scripts are run in alphabetical order (and sql first, sh second) so their naming is reflective of that
COPY ./dev/openchpl_role.sql /docker-entrypoint-initdb.d/01-create-role.sql
COPY ./dev/openchpl_database.sql /docker-entrypoint-initdb.d/02-create-database.sql
# load.sh and load-pending-changes.sh must be mounted as well but they are in another location
COPY ./changes/ /docker-entrypoint-initdb.d/changes/
COPY ./dev/openchpl_ff4j.sql /docker-entrypoint-initdb.d/dev/openchpl_ff4j.sql
COPY ./dev/openchpl_ff4j_audit.sql /docker-entrypoint-initdb.d/dev/openchpl_ff4j_audit.sql
COPY ./dev/openchpl_quartz.sql /docker-entrypoint-initdb.d/dev/openchpl_quartz.sql
COPY ./dev/openchpl_quartz_audit.sql /docker-entrypoint-initdb.d/dev/openchpl_quartz_audit.sql
COPY ./dev/openchpl_soft-delete.sql /docker-entrypoint-initdb.d/dev/openchpl_soft-delete.sql
COPY ./dev/openchpl_views.sql /docker-entrypoint-initdb.d/dev/openchpl_views.sql
COPY ./dev/openchpl_grant-all.sql /docker-entrypoint-initdb.d/dev/openchpl_grant-all.sql

# Install dos2unix
RUN apt-get update && apt-get install -y dos2unix
# Convert all files in the postgres init location
RUN find /docker-entrypoint-initdb.d -type f -print0 | xargs -0 dos2unix 
RUN find /docker-entrypoint-initdb.d/changes -type f -print0 | xargs -0 dos2unix 
RUN find /docker-entrypoint-initdb.d/dev -type f -print0 | xargs -0 dos2unix 


# Expose the default PostgreSQL port
EXPOSE 5432