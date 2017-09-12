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

As the CHPL is now running in production, any changes to the data-model must be done in such a way that they do not negatively impact the live data. For development purposes, that file needs to be able to be executed multiple times, but at the end of any execution the database must be in the correct "target" state. The files in the `/dev` subdirectory should describe the live data-model as well; this means that any change done to the live database must be implemented in the "model" files as well.

Every time you make a change to the `dev/openchpl_views.sql` or `dev/openchpl_data-model.sql` files you must put those
changes in either a `chpl-data-model/OCD-XXXX.sql` file or the `chpl-data-model/v-next.sql` if the change will be deployed at the next deployment to production. The v-next.sql should be able to run multiple times without problems. If you are creating a table, `DROP TABLE IF EXISTS`. If you are dropping a table, `DROP TABLE IF EXISTS`. If you are altering a table, `DROP COLUMN IF EXISTS`. If data must be added or removed, ensure it is only added once, and removal removes only the correct data.

Every time a you pull down changes that affect the database run v-next.sql to get the latest database model. If you are running a specific OCD branch you might also need to run an OCD-XXXX.sql file to get the correct database.

If the changes made for development include the addition of a table, view, trigger, or any other thing that has ownership, check to see if you should have `--re-run grants \i dev/openchpl_grant-all.sql` at the end of the end of whatever script makes the changes.

During a production push, the "ready to go live" `v-next.sql` file will be renamed to match the Version of the database that is going live, using an adaptation of the Semantic Versioning methodology. Later development will create a new `v-next.sql` file.

## Data model load

Rename `dev/openchpl_role-template.sql` to `dev/openchpl_role.sql` and set the password for the `openchpl` role. These instructions assume the role/username used for the openchpl database is `openchpl`, and that the password in `openchpl_role.sql`, currently recorded as "change this password" will be update to match your installation. If the installer chooses to change the username/role, make sure it's also changed in the `openchpl.sql` file wherever the role is used.

Next, run the script `dev/reset.sh` or `dev/reset.bat` from the `/dev` directory. These two scripts remove any previous OpenCHPL data model installation, with the associated roles, then recreate the required roles and databases, as well as fill out some of those database schemas with some required information.

Next, follow the `maint/procedure.md` file to load the CHPL with data.
