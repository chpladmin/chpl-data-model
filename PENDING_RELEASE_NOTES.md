
## Version 17.4.0
_Date TBD_

### View/Table modifications
>>>>>>> development
* Create table 'filter' to handle storing user's filters
* Create table 'filter_type' to indicate the type of filter

### View Modifications
* Updated "acb_is_deleted" field in certified_product_details view to be "acb_is_retired".
* Created view "listings_from_banned_developers" to query when constructing the Banned Developers API response.

### Data Modifications
* Changed activity concept ATL to TESTING_LAB.
* Add listing, developer, product, and version reports to the filter_type table

---
