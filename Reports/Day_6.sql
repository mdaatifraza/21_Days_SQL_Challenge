### Practice Questions:
-- 1. Count the number of patients by each service.
SELECT
	service,
	COUNT(patient_id) as Total_number_of_patient
FROM patients
GROUP BY service
ORDER BY Total_number_of_patient DESC

-- 2. Calculate the average age of patients grouped by service.
SELECT 
	service,
    ROUND(AVG(age),2) AS Avg_age_of_patients
FROM patients
GROUP BY service

-- 3. Find the total number of staff members per role.
SELECT 
	role,
    count(staff_id) as Total_number_of_staff
FROM staff
GROUP BY role

### Daily Challenge:
-- Question:
-- For each hospital service, calculate the total number of patients admitted, total patients refused, 
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT 
    service,
    SUM(patients_admitted) AS Total_Patients_Admitted,
    SUM(patients_refused) AS Total_Patients_Refused,
    SUM(patients_request) AS Total_Patients_Request,
    ROUND((SUM(patients_admitted) * 100.0 / SUM(patients_request)),2) AS Admission_Rate
FROM services_weekly
GROUP BY service
ORDER BY Admission_Rate DESC


