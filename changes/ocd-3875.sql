UPDATE openchpl.deprecated_api
SET deleted = true 
WHERE removal_date = '2022-04-15';

-- deprecate /activity/users/{id}

-- deprecate /activity/user_activities/{id}

-- Question: Do we need to deprecate all of the /activity/metadata/beta endpoints in favor of adding additional endpoints that don't have "beta"?