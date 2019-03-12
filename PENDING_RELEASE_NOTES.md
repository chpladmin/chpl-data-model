
## Version 17.0.0
_Date TBD_

### Table modifications
* Remove obsolete corrective_action_plan tables
* Remove unused certification_event & event_type tables
* Removed unused compliance column from user table
* Removed unused muu_accurate_as_of_date table
* Remove backup ACL tables
* Add table user_testing_lab_map to store relationship between users and ATLs
* Create temporary backup tables for ACL data

### Data Modifications
* Mark "Pending" ACB as deleted
* Populate user_testing_lab_map based on ACL tables
* Backup ACL tables and delete that have ATL related information

---
