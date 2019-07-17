
## Version 17.7.0
_Date TBD_

### Table/View Modifications
* Add open surveillance count, closed surveillance count, and aggregated surveillance dates to the collections view
* Create table complaint_listing_map for storing listings associated with a complaint
* Create table complaint_surveillance_map for storing surveillances associated with a complaint
* Added table quarterly_report_excluded_listing_map to associate an excluded listing with the quarterly report.
* Create table complaint_criterion_map for storing criteria associated with a complaint

### Data Modifications
* Added two background job types: export quarterly surveillance and export annual surveillance.
* Add Announcement Report to the filter_type table

---
