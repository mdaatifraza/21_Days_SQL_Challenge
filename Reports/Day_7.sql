### Practice Questions:
-- 1. Find services that have admitted more than 500 patients in total.
SELECT
	service,
	SUM(patients_admitted) AS Total_Patient_Admitted
FROM services_weekly
GROUP BY service
HAVING Total_Patient_Admitted > 500

-- 2. Show services where average patient satisfaction is below 75.
SELECT 
	service,
    avg(satisfaction) as avg_satisfaction
FROM patients
GROUP BY service
HAVING avg(satisfaction) < 75

-- 3. List weeks where total staff presence across all services was less than 50.
SELECT 
	week,
    SUM(present) AS Total_Staff_Present
FROM staff_schedule
GROUP BY week
HAVING SUM(present) < 50

### Daily Challenge:
-- Question: Identify services that refused more than 100 patients in total and had an average patient 
-- satisfaction below 80. Show service name, total refused, and average satisfaction
SELECT 
	service,
	SUM(patients_refused) Total_Patient_Refused,
    AVG(patient_satisfaction) Avg_patient_satisfaction
FROM services_weekly
GROUP BY service
HAVING SUM(patients_refused) > 100 AND AVG(patient_satisfaction) < 80







