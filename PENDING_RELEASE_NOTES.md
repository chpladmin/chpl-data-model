
## Version 17.4.0
_Date TBD_

### Table Modifications
* Changed user permissions tables so users can have only one role. Old table will be removed in a future release.
  * Added column user_permission_id to user table.
  * No longer using global_user_permission_map table.
* Changed invitation tables so users can only be invited to have one role. Old table will be removed in a future release.
  * Added column user_permission_id to invited_user table.
  * No longer using invited_user_permission table.

### Data Modifications
* Migrated user permission and invitation permission data to new structure. Some users who previously had two roles may notice that their role has changed.

---
