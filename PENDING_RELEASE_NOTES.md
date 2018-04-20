
## Version 14.0.0
_Date TBD_

### Table modifications
* Added indexes to listing_to_listing_map for improved performance
* Added tables to support multiple ATLs
  * Added functions to retrieve CHPL ID
  * Added mapping tables
  * Migrated data to fill mapping table
  * Added Questionable Activity trigger
* Added indexes to listing_to_listing_map for improved performance

### View Modifications
* Modified certified_product_details view to respect certification_status_event deleted flag
* Modified certified_product_details view for improved performance
* Modified certified_product_search view for improved performance

### Data modifications
* Mark ~1300 Listings as "Withdrawn by Developer"
* Add "Cache Status Age Warning" notification type

### Script Modifications
* dump.sh - Changed to not include logged_actions table by default.  Can use the -i options if you want the table included.

---
