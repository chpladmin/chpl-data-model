
## Version 16.0.0
_Date TBD_

### Table modifications
* Updated ehr certification id with products view to not include unused columns; speeded things up 
* Add table user_certification_body_map to store relationship between users and ACBs
* Create temporary backup tables for ACL data

### Data Modifications
* Populate user_certification_body_map based on ACL tables
* Backup ACL tables and delete that have ACB related information
* Changed type of columns in two "pending list" tables to support more generous upload parsing ability

---
