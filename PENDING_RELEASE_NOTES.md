
## Version 17.0.0
_Date TBD_

### Table modifications
* Add table user_certification_body_map to store relationship between users and ACBs
* Create temporary backup tables for ACL data
* Remove obsolete corrective_action_plan tables
* Remove unused certification_event & event_type tables
* Removed unused compliance column from user table
* Removed unused muu_accurate_as_of_date table

### Data Modifications
* Populate user_certification_body_map based on ACL tables
* Backup ACL tables and delete that have ACB related information
* Changed type of columns in two "pending list" tables to support more generous upload parsing ability
* Retired Test Tool "CDC's NHSN CDA Validator"
* Added Test Tools: "NHCS IG Release 1 Validator" and "NHCS IG Release 1.2 Validator"
* Mark "Pending" ACB as deleted

---
