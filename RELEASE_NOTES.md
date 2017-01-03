# Release Notes

## Version TBD
_Date TBD_

### Changes
* Add surveillance tables to the database
* Add pending surveillance tables to the database
* Add add meaningful_use_users column to certified_product & certified_product_details
* Add 'Suspended by ONC' and 'Terminated by ONC' to certification_status table
* Replace corrective action plan with surveillance in details view for searching 
* Add certification_body deleted column to certified_product_details view
* Add certification_status_event table to store certification status change history. Eliminate use of certification_event and event_type.
* Add decertification_date to certified product details view
* Create v-next.sql since some of the update files require a certain order of execution 
* Add new certification status for products

---

## Version 6.0.0
_15 November 2016_

### Changes
* Added script to remove three specific duplicate certified products
* Added product owner history relationship

---

## Version 5.2.0
_21 October 2016_

### Changes
* Added vendor_status table and new status foreign key in the vendor table
* Changed testing tool name from 'HL7 v2 Immunization Information System (IIS) Reporting Validation' to 'HL7 v2 Immunization Information System (IIS) Reporting Validation Tool'
* Added ONC Staff role to user_permission table

---

## Version 5.1.1
_4 October 2016_

### Bugs fixed
* Updated version file to only have one 'modification' to certified_product_details view

---

## Version 5.1.0
_4 October 2016_

### Changes
* Modified certification status names previously known as Terminated, Suspended, and Withdrawn. Changed views as necessary.
* Added view to merge certification_id, date created, and columns necessary to formulate the CHPL product id
* Remove terms_of_use_url from data model and views.
* Added script to find Certified Products with improper CHPL Product Number Code components
* Add retired boolean to test_tool tables and retired Transport Test[ing] Tool.
* Added creation_date to certifiedProductDetails view for OCD-897

---

## Version 5.0.0
_19 September 2016_

### Changes
* Add two new views: product_certification_statuses and developer_certification_statuses
* Added view for faster /developers call

---

## Version 4.0.0
_30 August 2016_

### Changes
* Add ROLE_CMS_STAFF as an available role in the system.
* Update legacy CMS IDs with CreationDate

---

## Version 3.0.0
_10 August 2016_

### Changes
* Remove visible on chpl (breaks bakcwards compatibility)
  * Might need to re-run dev/openchpl_grant-all.sql

---

## Version 2.0.0
_2 August 2016_

### Changes
* Bulk update of certification statuses of ICSA products (already loaded)
* Re-populate test functionality table since some values have been edited
* Change many of the description values for test functionality and standards.

---

## Version 1.7.0
_25 July 2016_

### Changes
* Changed available education types
* Added SED Task Rating Standard Deviation

---

## Version 1.6.0
_16 June 2016_

### Features Added
* Add ``Suspended`` Certification Status
* Change Certification Status ``Decertified`` to ``Terminated``
* Add task rating standard deviation to pending and regular tables

### Bugs fixed
* Do not re-use test procedure versions

---

## Version 1.5.1
_13 June 2016_

### Bugs fixed
* Add vendor address and contact to certified product view

---

## Version 1.5.0
_24 May 2016_

### Features added
* Allowed SED Test Participants to have age ranges
* Drummond transparency updates as of 19 May
* ICSA Labs transparency updates as of 19 May

---

## Version 1.4.0
_16 May 2016_

### Features Added
* Added ehr_certification_id table and associated triggers, sequences
* Added ehr_certification_id_product_map table and associated triggers, sequences
* Added new CQM CMS Versions IAW
  * eCQMs for Eligible Professionals Table April 2016
  * eCQMs for Eligible Hospitals Table April 2016

### Bugs Fixed
* Remove errant space from a test functionality row.

---

## Version 1.3.0
_27 April 2016_

### Changes
* Added new columns to corrective action plans for non-certification criteria based nonconformities

---

## Version 1.2.0
_20 April 2016_

### Changes
* Added ACLs for system user to ACB/ATL
* Uploaded ICSA k1/k2 attestations

---

## Version 1.1.0
_12 April 2016_

### Changes
* Removed non-admin accounts
* Moved & chmod -x all scripts / sql files to avoid resetting database
* Added audit/timestamp triggers to tables missing them
* Updated data model diagram

---

## Version 1.0.0
_30 March 2016_

### Changes
* Removed smart quotes from the preloaded education types.
* Changed gender column to accommodate 100 characters instead of 1 character.
* Added items to preload script
* Allowed `null` for first names of contacts in ACB

---

## Version 0.5.0
_25 March 2016_

### Features added
* Updated to conform with 2015 upload rules
  * Additional software grouping
  * API Documentation, Privacy & Security
  * SED Tasks & Participants
* Added SQL file for k1/k2 transparency insert/updates
* Added CCHIT as ATL

---

## Version 0.4.0
_14 March 2016_

### Changes
* Cleaned up unused Certified Product fields
* Changed Transparency Attestation to ENUM / URL to per product
* Added "Targeted Users"

---

## Version 0.3.2
_29 February 2016_

### Features added
* Updated data model to support new 2014 upload fields

---

## Version 0.3.0
_18 February 2016_

### New and improved freatures
* Added vendor website to vendor information
* Combined surveillance and corrective action plans
* Allowed search on corrective action plan statuses
* Removed Additional Software from CQMs
* Updated data model with respect to new 2014 upload

---

## Version 0.2.0
_3 February 2016_

No significant data model changes

---

## Version 0.1.1
_12 January 2016_

No significant data model changes

---

## Version 0.1.0
_5 January 2016_

New and improved features
* Added terms of use and api documentation to the certified product data model.
* Added ATL information
* Added vendor-to-ACB mapping to store transparancyAttestation field.

New and improved features
* Added terms of use and api documentation to the certified product data model.
* Added ATL information
* Added vendor-to-ACB mapping to store transparancyAttestation field.

---

## Version 0.0.2
_7 December 2015_

New and improved features
* Updated data model to reflect required changes in API

Bugs Fixed
* Fixed bug where incorrect CQM counts were reported

---

## Version 0.0.1
_13 November 2015_

First release
