
## Version 14.7.1
_Date TBD_

### Table Modifications
* API Key table
  * Add column delete_warning_sent_date
  * Add column last_used_date
  * Add trigger to set delete_warning_sent_date = null when last_used_date is updated

### Data modifications
* Test Standards
  * Consolidated some duplicates
  * Expanded some multi-rows
  * Removed invalid one
* Criteria modifications
  * Added Privacy & Security Framework values for missing 170.315 (a)(7) criteria
  * Added Test Tools for missing 170.314 (c)(1) criteria

  ---
