CREATE DATABASE hospital;

use hospital;

select `County Name` from hospitaldata;

#1.How many hospitals are in the dataset?

SELECT COUNT(*) AS Total_Hospital
FROM hospitaldata;

#2. List all unique states where hospitals are located.

SELECT distinct State
FROM hospitaldata
ORDER BY State;

#3. Count the number of hospitals in each state.

SELECT State, COUNT(*) AS hospitaldata
FROM hospitaldata
GROUP BY state
ORDER BY hospitaldata DESC;

#4. Find the top 5 states with the highest number of hospitals.
SELECT State, COUNT(*) AS hospitaldata
FROM hospitaldata
GROUP BY state
ORDER BY hospitaldata DESC
LIMIT 5;

#5. Retrieve the details of hospitals with "General" in their name.
SELECT * FROM hospitaldata;

SELECT *
FROM hospitaldata
WHERE 'Hospital Name' LIKE '%General%';

#6. Count the number of hospitals with emergency services.

SELECT COUNT(*) AS Emergency_Hospital_count
FROM hospitaldata
WHERE 'Emergency_Services' = 'Yes';

#7. Identify hospitals that do not meet the criteria for meaningful use of EHRs.

SELECT *
FROM hospitaldata 
WHERE 'Meets criteria for meaningful use of EHRs' = 'NO';







