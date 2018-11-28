
## Version 14.11.0
_Date TBD_

### Table Modifications
* Rename column test_functionality.certification_criterion_id to certification_criterion_id_deleted
* Create new table test_functionality_criteria_map table allowing for many-2-many between test_functionality and certification_criterion tables
* Add column 'reason' to questionable_activity_developer table
* Add user_reset_token table to use with user reset of their password
* Add column to user table to indicate if a password change is required
* Add file_type table to inidcate the type/purpose of a saved file_type
* Add chpl_file table to store files in a byte array format 

### Data Modifications
* Migrate data from test_functionality.certification_criterion_id column to new table test_functionality_criteria_map
* Add data to test_functionality_criteria_map to restrict available functinality tests based on criterion

---
