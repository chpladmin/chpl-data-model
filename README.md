# Installation

## Getting the code

```sh
$ git clone https://github.com/chpladmin/chpl-data-model.git
$ cd openchpl-sql
```

## Data model development process

Since the CHPL is running in production, any changes to the data-model must be done in such a way that they do not negatively impact the live data. For development purposes, DML and DDL scripts must be able to be executed multiple times, where at the end of any execution the database must be in the correct "target" state. The files in the `/dev` subdirectory should describe the live data-model as well; this means that any change done to the live database must be implemented in the "model" files as well.

### Updating Soft Deletes and Views
To update the soft delete triggers, update the `dev/openchpl_soft-delete.sql` script to include updates.
To update the views in the CHPL database, update the `dev/openchpl_views.sql` script to include updates.

These scripts are run each time the database is updated.  These scripts will drop all database objects associated with the script and recreate the objects.

### Updating/Adding Tables and Data
To update or add a new table to the CHPL database:
* Create new file or append changes to existing `changes/ocd-XXXX.sql` which corresponds to the ticket the change is associated to
* Add necessary `ALTER` statements, ensuring that the script can be run multiple times based on requirements
  * `IF EXISTS`, `IF NOT EXISTS` clauses should be used to determine if the statement will be executed

To update data in tables
* Create a new file or append changes to an existing `changes/ocd-XXXX.sql` file which corresponds to the ticket the change is associated to
* Add necessary `INSERT`, `UPDATE` statements, ensuring the script can be run multiple times based on requirements
  * Using `WHERE NOT EXISTS` can often be used to help with determining if the statement should be executed

Sometimes database changes may require scripting not defined here to perform the required changes. Those situations should be handled on a case by case basis.

## Updating your local data to match another environment
To update your local database to match a particular environment, pull the code associated with that environment.
`git pull upstream/qa` for example.

Run the `load-pending-changes.sh` script.  This will execute:
* All `ocd-XXXX.sql` scripts in the `/changes` directory
* The `dev/openchpl_soft-delete.sql` script
* The `dev/openchpl_views.sql` script
* The `dev/openchpl_grant-all.sql` script (set permissions for all database objects)

## Data model load
CHPL currently recommends using Postgres version 14 running on the standard port of 5432.
1. Create the necessary roles in our database
    * Create a new file `dev/openchpl_role.sql` based on `dev/openchpl_role-template.sql` and set the password for the `openchpl` and `openchpl_dev` roles in the new file. The password is recorded as "change this password" in the template file.
   ```sh
   psql -Upostgres -f dev/openchpl_role.sql
   ```
1. Create the openchpl database
   ```sh
   psql -Upostgres -f dev/openchpl_database.sql
   ```
1. Download the latest backup file from Bamboo and load it
   * The artifact name in Bamboo is openchpl.final.backup. It should be downloaded and copied into the `maint` directory as `openchpl.backup`.
   ```sh
   maint/load.sh
   ```
1. Run scripts to add tables for all other schemas
   ```sh
   psql -Uopenchpl_dev -f dev/openchpl_ff4j.sql openchpl
   psql -Uopenchpl_dev -f dev/openchpl_ff4j_audit.sql openchpl
   psql -Uopenchpl_dev -f dev/openchpl_quartz.sql openchpl
   psql -Uopenchpl_dev -f dev/openchpl_quartz_audit.sql openchpl

   # The shared store schema does have its single table loaded during the load of the prod backup.
   # I would have expected the above schemas to also have their tables loaded and am not sure why they do not.
   # psql -Upostgres -f openchpl_shared_store.sql
   ```
1. Load the latest data model code from the staging branch or relevant feature branch
   ```sh
   ./load-pending-changes.sh
   ```
1. Start Tomcat
   * The FF4j data does not come with the production data dump by default. You will need to add the current set of feature flags via the FF4j UI.
