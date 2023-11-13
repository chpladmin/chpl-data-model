# Release Notes
`
## Version 24.2.1
_13 November 2023_

### Data Changes
* Remove "unattested criteria" from Listings in data

---

## Version 24.2.0
_16 October 2023_

### Features
* Remove certification_criterion 'removed' column

### Data Changes
* Set empty string values for certified products to null

---

## Version 24.1.1
_2 October 2023_

### Data Changes
* Data cleanup for Functionality Tested

---

## Version 24.1.0
_18 September 2023_

### Features
* Add columns to Functionality Tested to support HTI-1
* remove test_tool.required_day column
* Remove 'XX' code from CHPL Prod Number calculated in view
* DEV->ACB Map excludes edition; only considers status

### Data Changes
* Add criteria start and end dates

---

## Version 24.0.0
_5 September 2023_

### Breaking Changes
* Drop tables related to unused portion of Cures Statistics Report

### Features
* Add start day, end day, and rule to criterion table

### Data Changes
* Mark GAP Medicaid g1/g2 measures as Removed
* No 2015 criteria may have test procedures

---

## Version 23.13.0
_21 August 2023_

### Features
* Allow subscriber role to be null

---

## Version 23.12.0
_7 August 2023_

### Features
* Update tables to support Test Tools and HTI-1

### Data Changes
* Add future Attestation Periods

---

## Version 23.11.0
_24 July 2023_

### Features
* Track and analyze (g)(10) Service Base URL List availability

### Data Changes
* Add test standards to certification_criterion_attribute table
* Add SED to certification_criterion_attribute table
* Add additional software to certification_criterion_attribute tbl
* Add attestation answer to certification_criterion_attribute table
* Add G2 Success to certification_criterion_attribute table
* Add G1 Success to certification_criterion_attribute table
* Add Use Cases to certification_criterion_attribute table
* Add Documentation URL to certification_criterion_attribute table
* Add export documentation to certification_criterion_attribute tbl
* Add API Documentation to certification_criterion_attribute table
* Add GAP to certification_criterion_attribute table

---

## Version 23.10.0
_3 July 2023_

### Features
* Store Change Request message with attestation responses

---

## Version 23.9.0
_26 June 2023_

### Features
* Drop accredidation_number column for ONC-ATLs
* Convert retirement_date columns from timestamp to date
* Create tables to support public user subscriptions

---

## Version 23.8.0
_12 June 2023_

### Features
* Add tables for storing url monitoring data

### Data Changes
* Remove ROLE_ONC_STAFF and related users
* Soft-delete ROLE_ATL role, ONC-ATL mappings, and users with the ROLE_ATL role

---

## Version 23.7.0
_30 May 2023_

### Features
* Create combined questionable activity view

### Data Changes
* Remove activity that has no real changes

---

## Version 23.6.0
_15 May 2023_

### Features
* Add SVAP data to listing_search view

### Data Changes
* Clean up questionable activity

---

## Version 23.5.0
_1 May 2023_

### Features
* Remove listing_modified_date from listing validation report table

---

## Version 23.4.0
_19 April 2023_

### Features
* Add reason column to activity table
* Add activity_id column to all questionable activity tables

### Data Changes
i* Rename Current Certification Date Changed Questionable Activity trigger

---

## Version 23.3.1
_3 April 2023_

### Data Changes
* Remove duplicate attestation submission data
* Add Functionalities Tested as an option for 170.315 (b)(3) Cures Update criterion

---

## Version 23.3.0
_20 March 2023_

### Features
* Insert privacy_security_framework as criteria attribute

### Data Changes
* Remove existing P&S Framework values for b10

---

## Version 23.2.1
_6 March 2023_

### Data Changes
* Remove developers that have no listings

---

## Version 23.2.0
_21 February 2023_

### Table changes
* Delete columns from ICS Errors Report that could be derived

---

## Version 23.1.0
_6 February 2023_

### Features
* Remove edition relationship from functionality tested
* Rename test_functionality tables functionality_tested

### Data Changes
* Set up Attestation data for Period 3 attestations
* Add functionality tested to criterion_attribute table

---

## Version 23.0.0
_23 January 2023_

### Breaking Changes
* Remove legacy measure mapping tables
* Remove fuzzy_choices table

### Data Changes
* Remove incorrectly uploaded Listing
* Add "Inherited Certified Status" surveillance requirement type
* Add Questionable Activity type for cures update removal
* Create ROLE_STARTUP to have permission to tomcat startup apis

### Bug Fixes
* Stop including deleted ics relationships in views

---

## Version 22.1.0
_9 January 2023_

### Features
* Stop prepending NQF- to listing_search view CQM data

### Data Changes
* Modify Surveillance Requirement and Non-conformity values

---

## Version 22.0.0
_12 December 2022_

### Breaking Changes
* Remove unused view aggregated_nonconformity_statistics
* Drop "pending" surveillance tables
* Drop table nonconformity_documents
* Remove "key" column from ehr_certification_id table

### Data Changes
* Remove extra space in complainant type name
* Update complainant type to simply be 'Other'
* Correct (c)(3) attested criteria vs CQM criteria mismatch

---

## Version 21.3.0
_28 November 2022_

### Features
* Add column for Test Data Criteria attribute and populate it
* Update ucd_process name to be 'text' instead of 200 chars
* Convert sed_testing_end from timestamp to date

### Data Changes
* Remove unsent notifications for removed properties and endpoints

---

## Version 21.2.0
_14 November 2022_

### Features
* Add new views for Surveillance Requirement & Non-Conformity Types
* Alter product ownership transfer date from timestamp to date

### Data Changes
* Add new Questionable Activity Trigger for non-active Certificate edits
* Add and modify Surveillance Requirement and Non-Conformity Types

### Bug Fixes
* Include Withdrawn by Developer Under Surveillance in decertified date calculations

---

## Version 21.1.2
_31 October 2022_

### Data Changes
* Delete developer, product and version activity events without meaningful changes

---

## Version 21.1.1
_17 October 2022_

### Data Changes
* Add 2023 eCQM versions and measures

---

## Version 21.1.0
_3 October 2022_

### Features
* Remove tables related to old Attestation format

### Data Changes
* Delete orphaned version and related activity
* Append b10, d12, d13, and g10 with "(Cures Update)" title

---

## Version 21.0.1
_19 September 2022_

### Data Changes
* Add new Questionable Activity triggers for Real World Testing updates

---

## Version 21.0.0
_6 September 2022_

### Breaking Changes
* Drop old deprecated usage tables and create new deprecated usage tracking table
* Drop all pending certified product tables that are no longer used

### Features
* Add table to support associating ONC-ACBs to change requests based on the type of change request
* Add column to attestation form table to include submission instructions

### Data Changes
* Allow SVAP to be connected to h1 and h2
* Set Attestation Period dates for Periods 2 and 3

---

## Version 20.21.0
_22 August 2022_

### New Feature
* Add tables to support Attestation Optional Responses and migrate data from original tables

### Bug Fixes
* Allow SVAP to be associated with correct criteria

---

## Version 20.20.0
_8 August 2022_

### Features
* Add script to truncate the shared_store.shared_store table

---

## Version 20.19.0
_25 July 2022_

### Data Changes
* Remove API endpoints with no more deprecated fields as of 5/15/22
* Remove deprecated response fields eligible as of 5/15/22.
* Add deprecated endpoints related to modifying attestations from previous periods

---

## Version 20.18.3
_11 July 2022_

### Data Changes
* Add deprecated field mappings for surveillance requirementName and nonconformityTypeName. Add deprecated endpoints for nonConformity document upload and delete.

---

## Version 20.18.2
_6 July 2022_

### Data Changes
* Add/Remove "Touchstone" related testing options
* Remove invalid g10 measure mapping to EC measure

---

## Version 20.18.1
_27 June 2022_

### Data Changes
* Mark /change-requests endpoint as deprecated and remove it from the deprecated_response_field_api table
* Update conformance method name from "Touchstone" to "Drummond G10+ FHIR API powered by Touchstone"

---

## Version 20.18.0
_13 June 2022_

### Table Changes
* Add removal date to Conformance Method table and give a removal date for 'NCQA eCQM Test Method'

### Data Changes
* Add "Touchstone" as an available Conformance Method
* Add deprecated response fields for developerId, productId, and versionId

---

## Version 20.17.0
_6 June 2022_

### Features
* Combine Developer Details and Website Change Request to Developer Demographics Change Request

---

## Version 20.16.1
_31 May 2022_

### Data Changes
* Remove deprecated endpoint and response fields eligible for deletion
* Remove deprecated endpoint that has always been behind a flag

---

## Version 20.16.0
_16 May 2022_

### Features
* Add schema and table to support 'shared-data'

### Data Changes
* Repair erroneous Cures update events

---

## Version 20.15.1
_2 May 2022_

### Data Changes
* Remove deprecated APIs and Response Fields that had a removal date of 4/15/22.
* Indicate deprecated Announcement API & field data

---

## Version 20.15.0
_13 April 2022_

### Features
* Add previous CHPL Product Numbers into search view
* Create table to store CHPL Product Number changes over time for each Listing

---

## Version 20.14.1
_1 April 2022_

### Data Changes
* Add Attestations Requirement value for Surveillance
* Deprecate bulk reject of pending Listings

---

## Version 20.14.0
_22 March 2022_

### Features
* Add table to support attestation period exceptions for developers 
* Add listing_search view to support /search/v2 endpoint
* Update developer_certification_body_map view to filter for 2015 and active certificates

---

## Version 20.13.0
_7 March 2022_

### Features
* Remove transparency attestation from tables and columns

---

## Version 20.12.0
_22 February 2022_

### Features
* Add tables to support new Attestation change request submission process

### Data Changes
* Deprecate original upload/confirm/reject endpoints; remove some endpoints with deprecated response fields where the endpoint itself is now deprecated

---

## Version 20.11.3
_24 January 2022_

### Data Changes
* Add data to support notifying users of deprecated Transparency Attestation response field

---

## Version 20.11.2
_10 January 2022_

### Bug Fixes
* Update unique constraint on deprecated api usage tables

---

## Version 20.11.1
_9 December 2021_

### Data Changes
* Update Test Standard to 2015 version on 2 Listings

---

## Version 20.11.0
_29 November 2021_

### Features
* Add Real World Testing Plans Url and Real World Testing Results Url to certified_product_search view

### Data Changes
* Update Optional Standards mapping and values
* Add deprecated API for /collections/certified-products

---

## Version 20.10.0
_15 November 2021_

### Features
* Remove authority/user_permission_id field from tables and views

### Data Changes
* Add new surveillance requirement type and questionable activity triggers
* Add deprecated fields to table data for authority / user permission changes

---

## Version 20.9.0
_1 November 2021_

### Features
* Add tables to support improved Cures Reporting reports new charts
* Add deprecated response field usage tables and data
* Remove the unused nonconformity_status table and related columns from the database
* Add structures to support Conformance Method

### Data Changes
* Update additional eCQM numbers and versions for 2022 reporting bundle

---

## Version 20.8.0
_18 October 2021_

### Features
* Store "estimated removal date" of deprecated API endpoints

### Data Changes
* Add Promoting Interoperability Updated by ONC-ACB as a type of Questionable Activity
* Insert approved "Optional Standards" as per ONC guidance

---

## Version 20.7.1
_5 October 2021_

### Data Changes
* Revise list of test tools to select for a 2015 Edition listing

---

## Version 20.7.0
_7 September 2021_

### Features
* Use consistent names for Quarterly Surveillance table

---

## Version 20.6.0
_31 August 2021_

### Features
* Remove Real World Testing Eligibility Year and view references
* Rename "Transparency Attestation URL" as "Mandatory Disclosures"

---

## Version 20.5.0
_23 August 2021_

### Features
* Add new NON_CONFORMITY_CLOSE_DATE field

### Data Changes
* Add new eCQM versions for 2022 reporting bundle
* Restrict Surescripts from being used as a Test Procedure for 170.315 (b)(3) Cures Update

---

## Version 20.4.0
_9 August 2021_

### Features
* Add Attestation change request table
* Add tables to track deprecated API usage
* Add status column to listing upload table

---

## Version 20.3.0
_2 August 2021_

### Features
* Add table for Pending Optional Standards
* Rename meaningful_user_user to promoting_interoperability_user

### Data Changes
* Add Questionable Activity Trigger for Real World Testing without Eligibility

---

## Version 20.2.0
_28 June 2021_

### Features
* Remove requirement for Phone Number for users
* Add support for Optional Standards

### Bug Fixes
* Remove leftover reference to openchpl.job in soft delete triggers
* Ignore deleted developer status history entries in a view

---

## Version 20.1.0
_2 June 2021_

### Features
* Update README documentation
* Add certification status event history to certified_product_search view
* Add tables to store cures-related statistics

---

## Version 20.0.0
_17 May 2021_

### Major Features
* Remove tables related to background jobs

### Features
* Add chpl product number to surveillance_basic view
* Allow criteria to have Service Base URL List data

---

## Version 19.14.0
_4 May 2021_

### Features
* Add table for holding new api key requests
* Add processing column to pending_certified_product table

### Bug Fixes
* Do not soft delete test participants if test task references multiple criteria

---

## Version 19.13.3
_19 April 2021_

### Data Changes
* Remove erroneously uploaded Listings

---

## Version 19.13.2
_5 April 2021_

### Data Changes
* Remove the v18 upload template

---

## Version 19.13.1
_22 March 2021_

### Data Changes
* Undelete Summary Statistics data for use in the attached pdf
* Allow saving of ONC-ATL report filter

---

## Version 19.13.0
_8 March 2021_

### Features
* Remove Spring 'acl_' tables
* Allow saving of HTTP METHOD in API Key activity table
* Add column to support SVAP Notice URL

### Data Changes
* Add v20 upload template (includes old b3 criterion)
* Remove export surveillance report background job types

---

## Version 19.12.0
_22 February 2021_

### Features
* Remove references to unused g1/g2 macra measure tables
* Add new table to support certification criterion attributes
* Add developer ID to certified_product_search view
* Add new table to support Listing Validation Report

### Data Changes
* Add missing mappings between g1/g2 measures and cures criteria
* Add missing removed measures for cures criteria

---

## Version 19.11.0
_8 February 2021_

### Features
* Add table to support flexible upload processing of Listings

### Data Changes
* Add missing measure mappings for Cures Updated criteria
* Remove erroneously added Listing 15.04.04.2964.Inte.18.01.1.200828

---

## Version 19.10.0
_25 January 2021_

### Features
* Add tables to support SVAP
* Add missing soft delete triggers for developer-related tables

---

## Version 19.9.0
_11 January 2021_

### Features
* Change column type of audit.logged_actions activity date

---

## Version 19.8.1
_28 December 2020_

### Data Changes
* Add Clinical Quality Measure for CMS 529

---

## Version 19.8.0
_14 December 2020_

### Features
* Move G1/G2 measures from criteria to listing level
* Make "username" optional for users

### Data Changes
* Enable ROLE_ONC_STAFF user type

---

## Version 19.7.1
_16 November 2020_

### Data Changes
* Remove friendly name from product and developer points of contact

---

## Version 19.7.0
_19 October 2020_

### Features
* Add new data elements for Real World Testing

---

## Version 19.6.1
_21 September 2020_

### Data Changes
* Add Stage 3 macra measures for (a)(1), (a)(2), and (a)(3)
* Add new CQM version and add new versions to existing CQMs for 2021 reporting bundle

---

## Version 19.6.0
_18 August 2020_

### Features
* Rename 'whitelisted' column to 'unrestricted' in api_key table

---

## Version 19.5.0
_10 August 2020_

### Features
* Add Real World Testing Eligibility Year to table and views
* Convert columns from ACB name to ACB Id

---

## Version 19.4.0
_27 July 2020_

### Features
* Update certified_product_summary view to handle status events correctly

---

## Version 19.3.4
_13 July 2020_

### Data Changes
* Fix typo in Macra Measure Description fields
* Add ability to save ONC-ACB Activity Report filter

---

## Version 19.3.3
_24 June 2020_

### Bug Fixes
* Remove invalid constraint for cert result and macra measures

---

## Version 19.3.2
_15 June 2020_

### Data Changes
* Mark some Questionable Activity concepts as removed
* Add Filter Type for Complaints search

### Bug Fixes
* Remove length limit from pending CP Source Grouping

---

## Version 19.3.1
_18 May 2020_

### Bug Fixes
* Add missing audit triggers
* Make pending fields 'text' type

---

## Version 19.3.0
_20 April 2020_

### Features
* Add table for developer details change request

### Data Changes
* Add Developer Details change request type

---

## Version 19.2.0
_8 April 2020_

### Features
* Add table to store Listing Cures Update status

### Data Changes
* Add new questionable activity trigger type for d2, d3, and d10 activity

---

## Version 19.1.0
_23 March 2020_

### Features
* Join criterion id into pending surveillance and nonconformity statistics
* Add self-developer column to pending listings

---

## Version 19.0.0
_9 March 2020_

### View Changes
* Change views to use ID instead of Number for Certification Criteria

---

## Version 18.2.1
_20 February 2020_

### Data Changes
* Add new data types for URL check job

---

## Version 18.2.0
_11 February 2020_

### Data Changes
* Add new Test Tool
* Mark the v17 2015 upload template as removed.

### Features
* Add Self-Developer element to Developer information

---

## Version 18.1.0
_27 January 2020_

### Features
* Support four new types of criterion data points

---

## Version 18.0.0
_2 January 2020_

### Features
* Remove Complaint Status Type data

---

## Version 17.16.1
_20 December 2019_

### Data Changes
* Add questionable activity triggers for adding b3 criteria

---

## Version 17.16.0
_16 December 2019_

### Data Changes
* Unretire CDC's NHSN CDA Validator and retire HL7 CDA National Health Care Surveys Validator

### Features
* Prevent duplicate rows for listing when duplicate status event exists

---

## Version 17.15.0
_2 December 2019_

### Data Changes
* Add 2020 CQM reporting bundle data

### Features
* Add removed column for macra measures; remove 'RT13 EH/CAH Stage 3'
* Add removed column to criteria table

---

## Version 17.14.0
_18 November 2019_

### Features
* Add mapping view between developers and acbs
* Add user permission to change request status

### Data Changes
* Add new filter type for API Key Management

---

## Version 17.13.1
_4 November 2019_

### Data Changes
* Add "ONC Test Method - Surescripts (Alternative)" as available Test Procedure
  * Make "Not Applicable" an option for Test Tool and Test Data
  * Restricted to 170.315 (b)(3) for Data and Procedure

---

## Version 17.13.0
_21 October 2019_

### Flagged Features
* Add ROLE_DEVELOPER User type
* Allow ROLE_DEVELOPER to create "Change Requests" to change their Organization's website

### Data Changes
* Add 2014 Listing Edit as questionable activity type

---

## Version 17.12.0
_7 October 2019_

### Features
* Add tables and views to support reporting on questionable urls
  * Add url_check_result table to store all the results of all urls that have been checked
  * Add url_type table as a lookup table of places urls can be found in the system
  * Update certified_product_summary view to have developer contact info and certification date

### Data Changes
* Add new RT 13, 14, and 15 Macra Measures

---

## Version 17.11.0
_23 September 2019_

### Features
* Add tables to support persisting Website Change Requests

---

## Version 17.10.0
_10 September 2019_

### Features
* Support storing the last logged in date with the user
* Add surveillance basic view to include open/closed nonconformity count

### Data Changes
* Add new filter type for API Key Usage report

---

## Version 17.9.0
_26 August 2019_

### Features
* Add ROLE_DEVELOPER

### Data Changes
* Create new address for addresses that are re-used by orgs

---

## Version 17.8.0
_12 August 2019_

### Table/View Modifications
* Add privileged surveillance data
  * Add lookup tables for surveillance_process_type and surveillance_outcome values
  * Add mapping table for privileged data associated with surveillance and quarterly report


### Data Changes
* Remove mistakenly uploaded listings
* Add quarterly report and annual report activity type
* Update db_version to be correct

---

## Version 17.7.1
_29 July 2019_

### Data Changes
* Add COMPLAINT as type of activity
* Remove obsolete ACL entries

---

## Version 17.7.0
_22 July 2019_

### Table/View Modifications
* Add open surveillance count, closed surveillance count, and aggregated surveillance dates to the collections view
* Create table complaint_listing_map for storing listings associated with a complaint
* Create table complaint_surveillance_map for storing surveillances associated with a complaint
* Added table quarterly_report_excluded_listing_map to associate an excluded listing with the quarterly report
* Create table complaint_criterion_map for storing criteria associated with a complaint

### Data Modifications
* Added two background job types: export quarterly surveillance and export annual surveillance
* Add Announcement Report to the filter_type table

---

## Version 17.6.0
_17 June 2019_

### View/Table modifications
* Create table complaint for storing quarterly surveillance report complaints
* Create table complaint_type for indicating type of complaint
* Create table complaint_status_type for indicating the status of complaints
* Add tables to support quarterly surveillance reporting

### Data Modifications
* Add user and user action reports to the filter_type table

---

## Version 17.5.0
_3 June 2019_

### Table modifications
* Add tables to support FF4j (feature flags)

### Technical debt
* Removed some obsolete tables

---

## Version 17.4.0
_20 May 2019_

### View/Table Modifications
* Create table 'filter' to handle storing user's filters
* Create table 'filter_type' to indicate the type of filter
* Changed user permissions tables so users can have only one role. Old table will be removed in a future release
  * Added column user_permission_id to user table
  * No longer using global_user_permission_map table
* Changed invitation tables so users can only be invited to have one role. Old table will be removed in a future release
  * Added column user_permission_id to invited_user table
  * No longer using invited_user_permission table

### Data Modifications
* Migrated user permission and invitation permission data to new structure. Some users who previously had two roles may notice that their role has changed
* Changed activity concept ATL to TESTING_LAB
* Add listing, developer, product, and version reports to the filter_type table

---

## Version 17.3.0
_8 May 2019_

### View Modifications
* Updated "acb_is_deleted" field in certified_product_details view to be "acb_is_retired"
* Created view "listings_from_banned_developers" to query when constructing the Banned Developers API response

---

## Version 17.2.1
_22 April 2019_

### View modifications
* Fixed views to handle multiple MUU records with the same effective timestamp
  * certified_products_detail
  * certified_products_search

---

## Version 17.2.0
_8 April 2019_

### Table modifications
* Add error and warning count to pending listing table

### Data modifications
* Update activity concept 'PENDING SURVEIALLNCE' to 'PENDING_SURVEILLANCE'

---

## Version 17.1.0
_1 April 2019_

### Table Modifications
* Remove the certification status id reference from the pending_certified_product table

### Data Modifications
* Mark the Pending certification status as deleted (again)

---

## Version 17.0.1
_28 March 2019_

### Data Modifications
* Mark "Pending" Certification Status as deleted

---

## Version 17.0.0
_27 March 2019_

### Table modifications
* Remove obsolete corrective_action_plan tables
* Remove unused certification_event & event_type tables
* Removed unused compliance column from user table
* Removed unused muu_accurate_as_of_date table
* Remove backup ACL tables
* Modify certified_product_summary view to improve perfomance of certification status join
* Add table user_testing_lab_map to store relationship between users and ATLs
* Create temporary backup tables for ACL data

### Data Modifications
* Mark "Pending" ACB as deleted
* Populate user_testing_lab_map based on ACL tables
* Backup ACL tables and delete those that have ATL related information

---

## Version 16.1.0
_11 March 2019_

### Table modifications
* Add table user_certification_body_map to store relationship between users and ACBs
* Create temporary backup tables for ACL data

### Data Modifications
* Populate user_certification_body_map based on ACL tables
* Backup ACL tables and delete that have ACB related information
* Changed type of columns in two "pending list" tables to support more generous upload parsing ability
* Retired Test Tool "CDC's NHSN CDA Validator"
* Added Test Tools: "NHCS IG Release 1 Validator" and "NHCS IG Release 1.2 Validator"

---

## Version 16.0.0
_25 February 2019_

### Table modifications
* Add user_permission_id column to pending_surveillance table to track the authority that owns the pending surveillance
* Updated ehr certification id with products view to not include unused columns; speeded things up
* Changed type of columns in two "pending list" tables to support more generous upload parsing ability

### Data Modifications
* Change Title & Descriptions for some G1/G2 Macra measures

---

## Version 15.3.0
_11 February 2019_

### Table Modifications
* Add "retirement date" for ACB and ATL tables

### Data Modifications
* Restore missing targeted user data
* Change InfoGard => UL LLC in preload data, but not in live data

---

## Version 15.2.0
_28 January 2019_

### Table Modifications
* Restrict participant unique id and test task id to be 20 characters

### Data Modifications
* Add ROLE_ONC to the user_permission table and convert all existing users except Ai's admin account from ROLE_ADMIN to ROLE_ONC
* Update soft delete triggers to include recently added references to certified products
* Remove ROLE_ONC_STAFF permission and convert existing ROLE_ONC_STAFF user accounts to be ROLE_ONC

---

## Version 15.1.0
_14 January 2019_

### Table Modifications
* Remove unused Contact fields
* Remove obsolete MUU table; MUU value from certified product
* Remove unused ATL references due to change to multiple ATL capability
* Remove old test functionality reference
* Change type of test task id and test participant id to be text
* Change targeted user name type to be text
* Add and populate Data-Model Version table

### Data Modifications
* Change a variety of test functionalities to correct values

---

## Version 15.0.0
_17 December 2018_

### Table Modifications
* Removed the following tables: notification_type_recipient_map, notification_recipient, notification_type_permission, and notification_type
* Add retired column for certification bodies and testing labs

### Data Modifications
* Retire ACBs and ATLs currently marked as deleted. Do not mark any as deleted

---

## Version 14.11.0
_3 December 2018_

### Table Modifications
* Rename column test_functionality.certification_criterion_id to certification_criterion_id_deleted
* Create new table test_functionality_criteria_map table allowing for many-2-many between test_functionality and certification_criterion tables
* Add column 'reason' to questionable_activity_developer table
* Add user_reset_token table to use with user reset of their password
* Add column to user table to indicate if a password change is required
* Add file_type table to inidcate the type/purpose of a saved file_type
* Add chpl_file table to store files in a byte array format

### Data Modifications
* Migrate data from test_functionality.certification_criterion_id column to new table test_functionality_criteria_map
* Add data to test_functionality_criteria_map to restrict available functinality tests based on criterion

---

## Version 14.10.1
_20 November 2018_

### Data Modifications
* Marked incorrectly uploaded Listing as deleted

---

## Version 14.10.0
_19 November 2018_

### Data Modifications
* CQM Criterion table
  * Add new versions to 70 existing CQMs
  * Add 2 new CQMs

---

## Version 14.9.2
_5 November 2018_

### View Modification
* Properly handle developer status history in certified_product_details view
  * When there was a deleted developer status history that occured at the exact same time, a duplicate row was in the view

---

## Version 14.9.1
_24 October 2018_

### Bugs Fixed
* Include listings without MUU counts in certified_product_summary view

---

## Version 14.9.0
_22 October 2018_

### Table Modifications
* Add meaningful_use_user table to capture current and historical muu counts per listing
* Modified all views that calculate meaningful_use_users

### Data Modifications
* Migrated data from certified_product meaningful_use_users column into new meaningful_use_user table

---

## Version 14.8.0
_8 October 2018_

### Table Modifications
* API Key table
  * Add column delete_warning_sent_date
  * Add column last_used_date
  * Add trigger to set delete_warning_sent_date = null when last_used_date is updated
* Add Developer status to search results view

---

## Version 14.7.1
_24 September 2018_

### Data modifications
* Test Standards
  * Consolidated some duplicates
  * Expanded some multi-rows
  * Removed invalid one
* Criteria modifications
  * Added Privacy & Security Framework values for missing 170.315 (a)(7) criteria
  * Added Test Tools for missing 170.314 (c)(1) criteria

---

## Version 14.7.0
_10 September 2018_

### Table Additions
* Add whitelist column to api key table
* Use "full name" and "friendly name" for users/contacts
* Add reason for developer ban

### Data Modifications
* Updated UI display values for select G1G2 Macra Measures
* Added new G1G2 Macra Measures

---

## Version 14.6.0
_27 August 2018_

### Table Addition
* Add table for inherited certification status errors report
* Add table for broken surveillance rules report data

---

## Version 14.5.0
_16 August 2018_

### Table Addition
* Add new nonconformity statistics table
* Add new summary statistics table
* Add new view for certified products summary

---

## Version 14.4.1
_16 July 2018_

### Data modifications
* Marked 269 Listings as "Withdrawn by Developer"

---

## Version 14.4.0
_5 July 2018_

### Table changes
* Added column to relate test functionality to practice type
* Added column to relate test functionality to certification criteria

### Data modifications
* Updated 2014 test functionalities to have appropriate practice types and certification criterion

---

## Version 14.3.0
_18 June 2018_

## Schema changes
* Create new schema for Quartz Scheduler

### Data modifications
* Remove "cache status age app" notification type; replaced by Quartz trigger

---

## Version 14.2.0
_4 June 2018_

### Table changes
* Create table to hold "new" vs "incumbent" Developer statistics
* Create table to hold number of products and developers with active listings by edition

### Data Modifications
* Consolidation/rename of test tools
  * "Direct Certificate Discovery Tool" + "2015 Direct Certificate Discovery Tool" = "Direct Certificate Discovery Tool"
  * "HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool" + "HL7 v2 Electronic Laboratory Reporting Validation Tool" = "HL7 v2 Electronic Laboratory Reporting (ELR) Validation Tool"
  * "Electronic Prescribing" + "ePrescribing Validation Tool" = "Electronic Prescribing"
  * "Transport Test Tool" + "Transport Testing Tool" = "Transport Testing Tool"
  * "Healthcare Associated Infections (HAI) Validator" -> CDC's NHSN CDA Validator
  * "Edge Test Tool" -> "Edge Testing Tool"
* Add activity concept for legacy corrective action plans to distinguish from certified product activities
* Update InfoGard listings Public Test Summary Report and UCD URLs

---

## Version 14.1.0
_21 May 2018_

### Table Modifications
* Added table to support criterion/product chart statistics

### View Modifications
* Update `certified_product_search` to respect deleted certification_status_events when getting "latest" status name
* Update `certified_product_details` to respect deleted certification_status_events when calculating certification_date and decertification_date columns

### Data Modifications
* Update g1 and g2 macra measures to their new mappings
* Add two "lost" Listings from legacy CHPL

---

## Version 14.0.1
_7 May 2018_

### Data modifications
* Add 2 new testing tools

---

## Version 14.0.0
_23 April 2018_

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
* dump.sh - Changed to not include logged_actions table by default.  Can use the -i options if you want the table included
* load.sh - Changed to kill existing processes in the DB before DROPing the schema

---

## Version 13.5.1
_9 April 2018_

### Data modifications
* Mark one Listing as deleted. Duplicate due to bug in upload process

---

## Version 13.5.0
_26 March 2018_

### Table Modifications
* Added tables to support statistics related to SED Participant demographics:
  * Gender
  * Age
  * Education Type
  * Experience Levels

---

## Version 13.4.0
_12 March 2018_

### Table modifications
* Add sed_participant_statistics_count table

### Data modifications
* Mark three Listings as deleted

---

## Version 13.3.1
_26 February 2018_

### Data modifications
* Modified certified product questionable activity trigger description
* Added two new types of certified product questionable activity trigger descriptions
* Mark 2015 v11 upload template as deleted

---

## Version 13.3.0
_12 February 2018_

### Table modifications
* Add reason column to some questionable activity tables that can result from listing update
* Add fuzzy_choices table
* Add FK from pending_certified_product to certified_product table to track listings from pending to confirmed
* Add reason for status change column to questionable activity listing table

### Data modifications
* Cleanup of QMS Standards, Accessibility Standards, UCD Processes
* Add 3 "duplicate" missing CMS IDs

---

## Version 13.2.1
_29 January 2018_

### Data modifications
* Insert some CMS IDs that were lost due to database issues

---

## Version 13.2.0
_17 January 2018_

### Table alterations
* Add reason column to certification status event table
* Add has qms column to to pendingCertifiedProduct table
* Remove certification status column from certified product table and related references in views. Certification status is now inferred from the most recent entry in the certification status event table for any listing

### Data changes
* Add new surveillance upload job type
* Deprecate 2015 v11 Upload Template
* Added new grouping of CQMs

---

## Version 13.1.0
_2 January 2018_

### Table changes
* Add 'deleted' column to 'ehr_certification_id_product_map' table
* Add triggers to cascade soft-deletes (and un-deletes)

### Data changes
* Marked deprecated upload templates as deleted
* Make some changes to Listings related to improper uploads
  * Set Transparency URLs
  * Delete improperly uploaded Listings

---

## Version 13.0.0
_18 December 2017_

### Table modifications
* Rename all test_procedure_temp tables and keys to their final state

### Data changes
* ROLE consolidation
  * Change ROLE_ACB_ADMIN to ROLE_ACB
  * Change ROLE_ATL_ADMIN to ROLE_ATL
  * Remove ROLE_ACB_STAFF
  * Remove ROLE_ATL_STAFF
* Mark duplicate ucd processes and qms standards as deleted; point criteria and listings to the appropriate non-deleted record

---

## Version 12.6.0
_5 December 2017_

### Table modification
* Add test_data and test_procedure_temp tables along with criteria mapping tables for each
* Change test data version and test procedure version character limits to 50
* Point certification result tables to new test data and test procedure foreign keys

### Data changes
* Add v12 2015 upload template

---

## Version 12.5.1
_20 November 2017_

### Data changes
* Update "new" 2014 upload template to have correct "available_as_of_date"
* Add new view to use for faster API searches
* Remove users.sql file. It is now in Bamboo for anyone who wants a copy

---

## Version 12.5.0
_6 November 2017_

### Table modification
* Add tables for questionable activity records

### Data changes
* Add New 2014 CHPL Upload Template v2 to upload_template_version

---

## Version 12.4.0
_23 October 2017_

### Table modification
* Add tables for upload version templates and pending ICS family data

### Data changes
* Update allowable 2015 'Measures Successfully Tested for G1/G2 values

---

## Version 12.3.1
_10 October 2017_

### Data changes
* Added `openchpl_dev` user to role-template
* Change ownership of openchpl database to openchpl_dev user

---

## Version 12.3.0
_25 September 2017_

### Table/view modification
* Add child and parent column to certified_product_search view
* Remove tables not referenced by API, and with no data
  * `acb_contact_map`
  * `atl_contact_map`
  * `experience_type`
  * `newer_standards_met`
  * `standards_met`
  * `test_event_details`
  * `test_result_summary_version`
  * `test_task_result`
  * `utilized_test_tool`
* Add background job processing tables

---

## Version 12.2.0
_11 September 2017_

### Table/view modification
* Migrate participants to be linked to a test task only rather than a test task+certification result. This includes a new table and next time will result in the removal of the old table
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
* Add columns to save the user-entered age range and education level of test participants
* Add ONC report types Weekly Statistics and Questionable Activity

---

## Version 12.0.0
_31 July 2017_

### Table/view modification
* Update db field lengths to match spec
* Add constraints to db fields for unique CHPL id codes for length and content

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
* Add a required certification edition column to test functionality

### Table modification
* Add tables for recipients and subscriptions to different types of notifications

### Data modification
* Find any current products that have bad values for their criterions' Privacy and Security Framework
* Update values for CQMs with typos
* Find and fix any criteria pointing to test functionality from the wrong edition

---

## Version 8.5.0
_24 April 2017_

### Changes
* Add optional contact column to the product table
* Make surveillance requirement and surveillance nonconformity as deleted when parent surveillance is deleted
* Make surveillance requirement have a result of "Nonconformity" when there are nonconformities

---

## Version 8.4.0
_10 April 2017_

### Changes
* Add a new table to capture history of vendor status changes
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
* Update surveillance migration script to include top-level developer explanation and resolution fields. Change the field start date is pulled from

---

## Version 7.0.1
_9 January 2017_

### Changes
* Update surveillance migration script to include top-level summary field

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
* Add certification_status_event table to store certification status change history. Eliminate use of certification_event and event_type
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
* Modified certification status names previously known as Terminated, Suspended, and Withdrawn. Changed views as necessary
* Added view to merge certification_id, date created, and columns necessary to formulate the CHPL product id
* Remove terms_of_use_url from data model and views
* Added script to find Certified Products with improper CHPL Product Number Code components
* Add retired boolean to test_tool tables and retired Transport Test[ing] Tool
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
* Add ROLE_CMS_STAFF as an available role in the system
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
* Change many of the description values for test functionality and standards

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
* Remove errant space from a test functionality row

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
* Removed smart quotes from the preloaded education types
* Changed gender column to accommodate 100 characters instead of 1 character
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
* Added terms of use and api documentation to the certified product data model
* Added ATL information
* Added vendor-to-ACB mapping to store transparancyAttestation field

New and improved features
* Added terms of use and api documentation to the certified product data model
* Added ATL information
* Added vendor-to-ACB mapping to store transparancyAttestation field

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
