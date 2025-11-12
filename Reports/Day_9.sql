### Practice Questions:
-- 1. Extract the year from all patient arrival dates.
SELECT 	
	*,
    YEAR(arrival_date) AS Year    -- EXTRACT(YEAR from arrival_date) AS _Year,
FROM patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT 
	*,
    DATEDIFF(departure_date, arrival_date) AS Total_Days_admitted
FROM patients;

-- 3. Find all patients who arrived in a specific month.
SELECT
	date_format(arrival_date, "%Y %M") Month_Year,
	GROUP_CONCAT(name) AS patients
FROM patients
GROUP BY date_format(arrival_date, "%Y %M");

### Daily Challenge:
-- Question:
-- Calculate the average length of stay (in days) for each service, showing only services where the 
-- average  stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT 
	service,
    COUNT(patient_id) AS Total_Patients,
    AVG(DATEDIFF(departure_date, arrival_date)) AS average_stay
FROM patients
GROUP BY service
HAVING AVG(DATEDIFF(departure_date, arrival_date)) > 7
ORDER BY AVG(DATEDIFF(departure_date, arrival_date)) DESC






