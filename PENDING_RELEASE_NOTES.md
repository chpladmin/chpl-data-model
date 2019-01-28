
## Version 15.2.0
_Date TBD_

### Data Modifications
* Add ROLE_ONC to the user_permission table and convert all existing users except Ai's admin account from ROLE_ADMIN to ROLE_ONC.
* Update soft delete triggers to include recently added references to certified products.
* Add user_permission_id column to pending_surveillance table to track the authority that owns the pending surveillance.
* Remove ROLE_ONC_STAFF permission and convert existing ROLE_ONC_STAFF user accounts to be ROLE_ONC.
* Restrict participant unique id and test task id to be 20 characters

---
