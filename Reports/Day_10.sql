### Practice Questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT 
    patient_id,
    name,
    satisfaction,
    CASE 
        WHEN satisfaction < 71 THEN 'Low'
        WHEN satisfaction BETWEEN 71 AND 85 THEN 'Medium'
        ELSE 'High'
    END AS satisfaction_level
FROM patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT 
	*,
    CASE
		WHEN role in ('doctor', 'nurse') THEN 'Medical'
        WHEN role = 'nursing_assistant' THEN 'Support'
	END AS role_type
FROM staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT
	*,
    CASE
		WHEN age BETWEEN 0 AND 18 THEN '0-18'
        WHEN age BETWEEN 19 AND 40 THEN '19-40'
        WHEN age BETWEEN 41 AND 65 THEN '41-65'
        ELSE '65+'
	END AS age_groups
FROM patients;

### Daily Challenge:
-- Question:
-- Create a service performance report showing service name, total patients admitted, and a performance
-- category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' 
-- if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
SELECT 
	service AS service_name,
    SUM(patients_admitted) AS total_patients_admitted,
    ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction,
    CASE
		WHEN ROUND(AVG(patient_satisfaction), 2) >= 85 THEN 'Excellent'
        WHEN ROUND(AVG(patient_satisfaction), 2) >= 75 THEN 'Good'
        WHEN ROUND(AVG(patient_satisfaction), 2) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
	END AS avg_satisfaction_category
FROM services_weekly
GROUP BY service
ORDER BY avg_satisfaction DESC












