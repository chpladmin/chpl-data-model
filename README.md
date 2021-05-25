# Data Model for Open Data CHPL

This is the Data Model for the Open Data CHPL.

The data model diagram is such: ![data model diagram](data-model.png)

The data flow diagram is here: ![data flow diagram](data-flow.png)

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
* Create new file or append canges to existing `changes/ocd-XXXX.sql` which corresponds to the ticket the change is associated to
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
Rename `dev/openchpl_role-template.sql` to `dev/openchpl_role.sql` and set the password for the `openchpl` role. These instructions assume the role/username used for the openchpl database is `openchpl`, and that the password in `openchpl_role.sql`, currently recorded as "change this password" will be update to match your installation. If the installer chooses to change the username/role, make sure it's also changed in the `openchpl.sql` file wherever the role is used.

Next, run the script `dev/reset.sh` or `dev/reset.bat` from the `/dev` directory. These two scripts remove any previous OpenCHPL data model installation, with the associated roles, then recreate the required roles and databases, as well as fill out some of those database schemas with some required information.

Next, follow the `maint/procedure.md` file to load the CHPL with data.
