USE hospital;

#1. Find the average hospital rating for each state.

SELECT
    State,
	AVG("Hospital overall rating") AS average_rating 
FROM 
    hospitaldata
WHERE 
    "Hospital overall rating" IS NOT NULL
GROUP BY 
     State
ORDER BY 
      average_rating DESC;
      
#2. Count the number of hospitals owned by each type of ownership (e.g., government, private).
      
SELECT "Hospital Ownership", COUNT(*) AS hospital_count
FROM hospitaldata
GROUP BY "Hospital Ownership"
ORDER BY hospital_count DESC;

#3. Find hospitals that have a "Better than the National Average" mortality comparison.

SELECT "Hospital Name", "City", "State", "Mortality national comparison"
FROM hospitaldata 
WHERE "Mortality national comparison" = 'Better than the National Average'
ORDER BY "State", "Hospital Name";

#4. Identify hospitals with poor patient experience ratings.

SELECT "Provider ID", "Hospital Name", "City", "State", "PAtient experience national comparison"
FROM hospitaldata 
WHERE "Patient experience national comparison" = 'Worse than the National Average'
ORDER BY "State", "Hospital Name";

#5. Count how many hospitals have the highest safety ratings.

SELECT COUNT(*) AS High_Safety_Rating_Hospital_Count
FROM hospitaldata
WHERE "Safety of care national cpmparison" = 'Better than the National Average';

#6. Find the state with the best average patient experience rating.

SELECT "State",
AVG( CASE "Patient experience national comparison"
           WHEN 'Better than the National Average' THEN 3
           WHEN 'Same as the National Average' THEN 2
           WHEN 'Worse than the National Average' THEN 1
           ELSE NULL
		END
	) AS Avg_Patient_Experience_Score
FROM hospitaldata
GROUP BY "State"
ORDER BY Avg_Patient_Experience_Score DESC
Limit 1;

#7. Identify hospitals where the readmission rate is worse than the national average.

SELECT "Provider ID", "Hospital Name", "City", "State", "Readmission national comparison"
FROM hospitaldata
WHERE "Readmission national comparison" = 'Worse than the National Average'
ORDER BY "State", "Hospital Name";


