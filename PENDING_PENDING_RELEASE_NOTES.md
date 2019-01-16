
## Version 15.2.0
_Date TBD_

### Data Modifications
* Add ROLE_ONC to the user_permission table and convert all existing users except Ai's admin account from ROLE_ADMIN to ROLE_ONC.
* Update soft delete triggers to include recently added references to certified products.
* Add user_permission_id column to pending_surveillance table to track the authority that owns the pending surveillance.

---
