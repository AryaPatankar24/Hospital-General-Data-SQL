USE hospital;

#1. Determine the percentage of hospitals with emergency services per state.

SELECT 'Provider ID', 'Hospital Name', 'City', 'State', 'Mortality national comparison', 'Safety of care national comparison', 'Readmission national comparison', 'Patient experience national comparison', 'Effectiveness of care national comoarison', 'Timeliniess of care national comparison'
FROM hospitaldata
WHERE 'Mortality national comparison' = 'Better than the National Average'
AND 'Safety of care national compariosn' = 'Better than the National Average'
AND 'Readmission national comparison' = 'Better than the National Average'
AND 'Patient experience national comparison' = 'Better than the National Average'
AND 'Effectiveness of care national comparison' = 'Better than the National Average'
AND 'Timeliness of care national comparison' = 'Better than the National Average'
ORDER BY 'State', 'Hospital Name';

#2. Compare the average ratings of government-owned vs. private hospitals.

SELECT 
CASE 
WHEN 'Hospital Ownership' LIKE '%Government%' THEN 'Government'
WHEN 'Hospital Ownership' LIKE '%Government%' THEN 'Private'
ELSE 'Other'
END AS Ownership_Type,
COUNT(*) AS Hospital_Count,
ROUND(AVG(CAST('Hospital ovverall rating' AS DECIMAL)),2) AS Average_Rating
FROM hospitaldata
WHERE 'Hospital overall rating' IS NOT NULL
GROUP BY Ownership_Type;

#3. Identify counties with the highest concentration of top-rated hospitals.

SELECT 'County Name', 'State', 
COUNT(*) AS Top_Rated_Hospital_Count
FROM hospitaldata
WHERE 'Hospital overall rating' = '5'
GROUP BY 'County Name', 'State'
ORDER BY Top_Rated_Hospital_Count DESC
LIMIT 10;

#4. Find hospitals that have improved their ratings over time (if historical data is available).

WITH rating_change AS (
    SELECT 
        `Provider ID`,
        `Hospital Name`,
        MIN(Year) AS Start_Year,
        MAX(Year) AS End_Year,
        MIN(CAST(`Hospital overall rating` AS UNSIGNED)) AS Initial_Rating,
        MAX(CAST(`Hospital overall rating` AS UNSIGNED)) AS Latest_Rating
    FROM hospitaldata
    WHERE `Hospital overall rating` IS NOT NULL
    GROUP BY `Provider ID`, `Hospital Name`
)
SELECT *
FROM rating_change
WHERE Latest_Rating > Initial_Rating
ORDER BY Latest_Rating - Initial_Rating DESC;

#5. Identify hospitals with inconsistent ratings (e.g., high patient experience but low safety).

SELECT 'Hospital Name', 'City', 'State', 
'Patient experience national comparison' AS Patient_Experience,
'Safety of care national comparison' AS Safety_of_Care
FROM hospitaldata
WHERE 'Patient experience national comparison' = 'Above the national average'
AND 'Safety of care national comparison' = 'Below the national average';

#6. Find correlations between hospital ownership and quality measures.

SELECT 'Hospital Ownership', 'Mortality national comparison',
COUNT(*) AS Count
FROM hospitaldata
WHERE 'Mortality national comparison' IN ('Above the national average', 'Same as the national average', 'Below the national average')
GROUP BY 'Hospital Ownership', 'Mortality national comparison'
ORDER BY 'Hospital Ownership', Count DESC;

#7. Analyze which states have the most efficient medical imaging usage.

SELECT 
    State,
    SUM(CASE WHEN `Efficient use of medical imaging national comparison` = 'Above the national average' THEN 1 ELSE 0 END) AS Above_Avg,
    SUM(CASE WHEN `Efficient use of medical imaging national comparison` = 'Same as the national average' THEN 1 ELSE 0 END) AS Same_Avg,
    SUM(CASE WHEN `Efficient use of medical imaging national comparison` = 'Below the national average' THEN 1 ELSE 0 END) AS Below_Avg,
    COUNT(*) AS Total_Hospitals,
    ROUND(
        100.0 * SUM(CASE WHEN `Efficient use of medical imaging national comparison` = 'Above the national average' THEN 1 ELSE 0 END) 
        / COUNT(*), 
        2
    ) AS Percent_Efficient
FROM hospitaldata
WHERE `Efficient use of medical imaging national comparison` IS NOT NULL
GROUP BY State
ORDER BY Percent_Efficient DESC
LIMIT 10;

#8. Compare readmission rates among different types of hospital ownership.

SELECT 
    `Hospital Ownership`,
    SUM(CASE WHEN `Readmission national comparison` = 'Above the national average' THEN 1 ELSE 0 END) AS Above_Avg,
    SUM(CASE WHEN `Readmission national comparison` = 'Same as the national average' THEN 1 ELSE 0 END) AS Same_Avg,
    SUM(CASE WHEN `Readmission national comparison` = 'Below the national average' THEN 1 ELSE 0 END) AS Below_Avg,
    COUNT(*) AS Total_Hospitals,
    ROUND(
        100.0 * SUM(CASE WHEN `Readmission national comparison` = 'Above the national average' THEN 1 ELSE 0 END) 
        / COUNT(*), 
        2
    ) AS Percent_Above_Avg_Readmission -- Higher is worse
FROM hospitaldata
WHERE `Readmission national comparison` IS NOT NULL
GROUP BY `Hospital Ownership`
ORDER BY Percent_Above_Avg_Readmission DESC;

#9. Create a query to segment hospitals into performance tiers (e.g., Excellent, Good, Average, Poor).

SELECT 
    `Hospital Name`,
    `City`,
    `State`,
    `Hospital overall rating`,
    CASE
        WHEN `Hospital overall rating` = '5' THEN 'Excellent'
        WHEN `Hospital overall rating` = '4' THEN 'Good'
        WHEN `Hospital overall rating` = '3' THEN 'Average'
        WHEN `Hospital overall rating` IN ('1', '2') THEN 'Poor'
        ELSE 'Not Rated'
    END AS Performance_Tier
FROM hospitaldata;


