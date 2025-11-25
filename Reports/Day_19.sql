### Practice Questions:
-- 1. Rank patients by satisfaction score within each service.
SELECT 
	*,
    DENSE_RANK() OVER(PARTITION BY service ORDER BY satisfaction DESC) AS rnk
FROM patients;

-- 2. Assign row numbers to staff ordered by their name.
SELECT 
	*,
    ROW_NUMBER() OVER(ORDER BY staff_name)
FROM staff;

-- 3. Rank services by total patients admitted.
SELECT
    service_name,
    total_patient_admitted,
    DENSE_RANK() OVER (ORDER BY total_patient_admitted DESC) AS rnk
FROM (
    SELECT 
        service AS service_name,
        SUM(patients_admitted) AS total_patient_admitted
    FROM services_weekly
    GROUP BY service
) AS a;


### Daily Challenge:
-- Question:
-- For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, 
-- patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
SELECT 
    *
FROM (
    SELECT 
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        DENSE_RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction DESC) AS week_rank
    FROM services_weekly
) AS A
WHERE week_rank <= 3;






