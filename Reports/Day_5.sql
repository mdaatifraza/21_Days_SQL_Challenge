### Practice Questions:
-- 1. Count the total number of patients in the hospital.
SELECT 
	COUNT(patient_id) as total_Patients
FROM patients

-- 2. Calculate the average satisfaction score of all patients.
SELECT 
	ROUND(AVG(satisfaction),2) as Avg_Satisfaction
FROM patients

-- 3. Find the minimum and maximum age of patients.
SELECT 
	MAX(age) as max_age,
    MIN(age) as min_age
FROM patients

### Daily Challenge:
-- Question:
-- Calculate the total number of patients admitted, total patients refused, and the average patient 
-- satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
SELECT 
	SUM(patients_admitted) as total_patients_admitted,
    SUM(patients_refused) as total_patients_refused,
    ROUND(AVG(patient_satisfaction),2) as Avg_patient_satisfaction
FROM services_weeklys;
