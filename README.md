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

## Data model load

Rename `openchpl_role-template.sql` to `openchpl_role.sql` and set the password for the `openchpl` role. These instructions assume the role/username used for the openchpl database is `openchpl`, and that the password in `openchpl_role.sql`, currently recorded as "change this password" will be update to match your installation. If the installer chooses to change the username/role, make sure it's also changed in the `openchpl.sql` file wherever the role is used.

Next, run the script `reset.sh` or `reset.bat`. These two scripts remove any previous OpenCHPL data model installation, with the associated roles, then recreate the required roles and databases, as well as fill out some of those database schemas with some required information.
