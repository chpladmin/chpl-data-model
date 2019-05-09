
## Version 17.4.0
_Date TBD_

### View/Table Modifications
* Create table 'filter' to handle storing user's filters
* Create table 'filter_type' to indicate the type of filter
* Changed user permissions tables so users can have only one role. Old table will be removed in a future release.
  * Added column user_permission_id to user table.
  * No longer using global_user_permission_map table.
* Changed invitation tables so users can only be invited to have one role. Old table will be removed in a future release.
  * Added column user_permission_id to invited_user table.
  * No longer using invited_user_permission table.

### Data Modifications
* Migrated user permission and invitation permission data to new structure. Some users who previously had two roles may notice that their role has changed.

---
