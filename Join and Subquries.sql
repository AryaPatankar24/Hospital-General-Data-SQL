USE hospital;

#1. Find hospitals that have both the best mortality and best patient experience ratings.

SELECT 'Hospital Name', 'City', 'State', 'Hospital overall rating', 'Mortality national comparison', 'Patient experience national comparison'
FROM hospitaldata
WHERE 'Mortality national comparison' = 'Above the national average'
AND 'Patient experience national comparison' = 'Above the national average';

#2. List hospitals that have the worst ratings in at least two categories.

SELECT 
    `Hospital Name`, 
    `City`, 
    `State`, 
    `Hospital overall rating`,
    `Mortality national comparison`, 
    `Safety of care national comparison`,
    `Readmission national comparison`,
    `Patient experience national comparison`,
    `Effectiveness of care national comparison`,
    `Timeliness of care national comparison`,
    `Efficient use of medical imaging national comparison`
FROM 
    hospitaldata
WHERE 
    (
        (`Mortality national comparison` = 'Below the national average') +
        (`Safety of care national comparison` = 'Below the national average') +
        (`Readmission national comparison` = 'Below the national average') +
        (`Patient experience national comparison` = 'Below the national average') +
        (`Effectiveness of care national comparison` = 'Below the national average') +
        (`Timeliness of care national comparison` = 'Below the national average') +
        (`Efficient use of medical imaging national comparison` = 'Below the national average')
    ) >= 2;
    
#3. Identify hospitals with both emergency services and a high overall rating.
    
SELECT 'Hospital Name', 'City', 'State', 'Hospital Type', 'Hospital Ownership', 'Hospital overall rating', 'Emergency Services'
FROM hospitaldatA
WHERE 'Emergency Services' = 'Yes'
AND CAST('Hospital overall rating' AS UNSIGNED) >= 4;

#4. Retrieve hospitals that have below-average effectiveness and timeliness of care.

SELECT 'Hospital Name', 'City', 'State', 'Hospital overall rating', 'Effectivness of care national comparison', 'Timeliness of care national comparison'
FROM hospitaldata
WHERE 'Effectiveness of care national comparison' = 'Worse than the national average'
AND 'Timelines of care national comparison' = 'Worse than the national average'
ORDER BY 'State', 'Hospital Name';

#5. Find hospitals that are performing well in all measured categories.

SELECT 'Hospital Name', 'City', 'State', 'Mortality national comparison', 'Safety of care national comparison', 'Readmission national comparison', 'Patient experience national comparison', 'Effectiveness of care national comparison', 'Timeliness of care national comparison'
FROM hospitaldata
WHERE 'Mortality national comparison'='Better than the National Average'
AND 'Safety of care national comparison'= 'Better than the National AVerage'
AND 'Readmission national comparison' = 'Better than the National AVerage'
AND 'Patient experience national comparison' = 'Better than the National AVerage'
AND 'Effectiveness of care national comparison' = 'Better than the National AVerage'
AND 'Timeliness of care national comparison' = 'Better than the National AVerage'
ORDER BY 'State', 'Hospital Name';