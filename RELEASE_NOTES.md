# Release Notes

## Next version
_Date TBD_

### Changes
* Removed non-admin accounts
* Moved & chmod -x all scripts / sql files to avoid resetting database
* Added audit/timestamp triggers to tables missing them
* Updated data model diagram

## Version 1.0.0
_30 March 2016_

### Changes
* Removed smart quotes from the preloaded education types.
* Changed gender column to accommodate 100 characters instead of 1 character.
* Added items to preload script
* Allowed `null` for first names of contacts in ACB

## Version 0.5.0
_25 March 2016_

### Features added
* Updated to conform with 2015 upload rules
  * Additional software grouping
  * API Documentation, Privacy & Security
  * SED Tasks & Participants
* Added SQL file for k1/k2 transparency insert/updates
* Added CCHIT as ATL

## Version 0.4.0
_14 March 2016_

### Changes
* Cleaned up unused Certified Product fields
* Changed Transparency Attestation to ENUM / URL to per product
* Added "Targeted Users"

## Version 0.3.2
_29 February 2016_

### Features added
* Updated data model to support new 2014 upload fields

## Version 0.3.0
_18 February 2016_

### New and improved freatures
* Added vendor website to vendor information
* Combined surveillance and corrective action plans
* Allowed search on corrective action plan statuses
* Removed Additional Software from CQMs
* Updated data model with respect to new 2014 upload

## Version 0.2.0
_3 February 2016_

No significant data model changes

## Version 0.1.1
_12 January 2016_

No significant data model changes

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

## Version 0.0.2
_7 December 2015_

New and improved features
* Updated data model to reflect required changes in API

Bugs Fixed
* Fixed bug where incorrect CQM counts were reported

## Version 0.0.1
_13 November 2015_

First release
