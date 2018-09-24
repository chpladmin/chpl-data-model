
## Version 14.8.0
_Date TBD_

### Table Modifications
* API Key table
  * Add column delete_warning_sent_date
  * Add column last_used_date
  * Add trigger to set delete_warning_sent_date = null when last_used_date is updated

---
