insert into ff4j.features (feat_uid, enable, description, strategy, expression) values
    ('listing-edit', 0, 'Provide the ability to edit a Certified Product / Listing in place, on the details page', null, null),
    ('states', 0, 'Show AngularJS state transitions. Useful for debugging', null, null),
    ('ocd2749-table', 0, 'Display Users in User Management Screens in a table, as opposed to as "cards"', null, null),
    ('complaints-flag-for-onc-review', 0, 'Hide the "Flag for ONC Review" checkbox on the Complaints form (Add and Edit) per ONC''s request to not push that feature out to Production (and STG) at this time.', null, null),
    ('role-developer', 1, 'Enable creation / log-in of users with "ROLE_DEVELOPER" abilities', null, null),
    ('complaints', 1, 'Enable ONC-ACB Users to record and store "Complaints" from the public', null, null),
    ('change-request', 1, 'Allow ROLE_DEVELOPER Users to submit "Change Requests"', null, null),
    ('surveillance-reporting', 1, 'Enable ONC-ACB Users to generate their required annual and quarterly surveillance reporting documents', null, null),
    ('effective-rule-date', 1, 'Features that should be enabled/disabled on the date the Rule becomes effective', 'org.ff4j.strategy.time.ReleaseDateFlipStrategy', 'releaseDate=2020-07-14-14:00'),
    ('effective-rule-date+1-week', 1, 'Features that should be enabled/disabled one week after the date the rule becomes effective', 'org.ff4j.strategy.time.ReleaseDateFlipStrategy', 'releaseDate=2020-07-21-14:00')
;
