# Release Notes

* Add child and parent column to certified_product_search view

## Version 12.2.0
_11 September 2017_

### Table/view modification
* Migrate participants to be linked to a test task only rather than a test task+certification result. This includes a new table and next time will result in the removal of the old table.
* Add "NOT NULL" to all values of Test Tasks & Participants
* Remove unused "Age" column from Test Participants

### Data changes
* Fill in null values of Test Tasks and Test Participants
* Added ocd-1754.sql as optional report that can be run to get phantom criteria associations
* Added ocd-1755.sql as optional file to delete phantom criteria associations (report should be empty after this is run)

---

## Version 12.1.0
_14 August 2017_

### Table/view modification
* Increased ICS Code length from 1 to 2; prepended '0' in front of any codes that were previously 1 character
* Add columns to save the user-entered age range and education level of test participants.
* Add ONC report types Weekly Statistics and Questionable Activity

---

## Version 12.0.0
_31 July 2017_

### Table/view modification
* Update db field lengths to match spec
* Add constraints to db fields for unique CHPL id codes for length and content.

### Maintenance ability
* Added file to remove PROD notifications and insert QA ones

---

## Version 11.1.0
_17 July 2017_

### Table/view modification
* Create new view for developers collections; combines all developers, transparency attestation urls and acb attestations
* Create new table for pending surveillance validation messages

### Data modification
* Fix typo / extra spaces in G1/G2 Macra measures

---

## Version 11.0.1
_3 July 2017_
* Add activity concept for pending surveillance

---

## Version 11.0.0
_3 July 2017_

### Table modification
* Alter ICS column to be an integer instead of varchar

### Data modification
* Added two new report types for ICS inconsistencies

---

## Version 10.1.1
_19 June 2017_

### Data modification
* Bulk change ICSA Listings Disclosure URLs

---

## Version 10.1.0
_19 June 2017_

### Table/view modification
* Add columns to the search view: decertification date, number of meaningful use users, mandatory disclosure url (aka transparency attestation url), and api documentation

---

## Version 10.0.0
_22 May 2017_

### Table modification
* Add certification_edition_id column to test standards

### Data modification
* Update existing test standards to fix 2014 numbers/descriptions from spreadsheet and remove existing user-entered duplicates

---

## Version 9.0.0
_8 May 2017_

### Major modification
* Add a required certification edition column to test functionality.

### Table modification
* Add tables for recipients and subscriptions to different types of notifications

### Data modification
* Find any current products that have bad values for their criterions' Privacy and Security Framework
* Update values for CQMs with typos
* Find and fix any criteria pointing to test functionality from the wrong edition.

---


## Version 8.5.0
_24 April 2017_

### Changes
* Add optional contact column to the product table.
* Make surveillance requirement and surveillance nonconformity as deleted when parent surveillance is deleted.
* Make surveillance requirement have a result of "Nonconformity" when there are nonconformities.

---

## Version 8.4.0
_10 April 2017_

### Changes
* Add a new table to capture history of vendor status changes.
* Replace four surveillance boolean values in the certified_product_search_view with three values listing the counts of:
  * surveillance
  * open nonconformities, and
  * closed nonconformities

---

## Version 8.3.0
_27 March 2017_

### Changes
* Add column to surveillance for "role" of creator
* Updated text for G1/G2 Macra measures

---

## Version 8.2.0
_13 March 2017_

### Changes
* Remove ACLs for pending certified products
* Added scripts for backup/load of database

---

## Version 8.1.0
_27 February 2017_

### Changes
* Added basic search view

---

## Version 8.0.1
_21 February 2017_

### Changes
* Add new EH/CAH macra measures for 170.315 (a)(1), (2), and (3)

---

## Version 8.0.0
_7 February 2017_

### Changes
* Add tables for macra g1/g2 measures for lookup, certification results, and pending certification results
* Add Meaningful Use User Accurate table, triggers, and row of data with accurate as of date = '11/30/2016'

---

## Version 7.1.0
_23 January 2017_

### Changes
* Add new certification status for products
* Add indexes to improve performance
* Set retired to true for Transport Test Tool and Transport Testing Tool

---

## Version 7.0.2
_10 January 2017_

### Changes
* Update surveillance migration script to include top-level developer explanation and resolution fields. Change the field start date is pulled from.

---

## Version 7.0.1
_9 January 2017_

### Changes
* Update surveillance migration script to include top-level summary field.

---

## Version 7.0.0
_6 January 2017_

### Changes
* Add surveillance tables to the database
* Add pending surveillance tables to the database
* Add meaningful_use_users column to certified_product & certified_product_details
* Add 'Suspended by ONC' and 'Terminated by ONC' to certification_status table
* Replace corrective action plan with surveillance in details view for searching
* Add certification_body deleted column to certified_product_details view
* Add certification_status_event table to store certification status change history. Eliminate use of certification_event and event_type.
* Add decertification_date to certified product details view
* Create v-next.sql since some of the update files require a certain order of execution

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
