### Practice Questions:
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT
	patient_id,
    name,
    service,
    satisfaction,
    (
		SELECT 
        AVG(satisfaction) 
        FROM patients P2
        WHERE P1.service = p2.service
	) AS service_wise_avg_satisfaction
FROM patients P1;

-- 2. Create a derived table of service statistics and query from it.
SELECT 
	service_stats.*,
    overall.hospital_avg_satisfaction,
    CASE 
		WHEN service_stats.service_avg_satisfaction > overall.hospital_avg_satisfaction then 'Above Average'
        ELSE 'Below Average'
	END AS performance
FROM (
		SELECT 
			service,
            SUM(available_beds) AS total_available_beds,
            SUM(patients_request) AS total_patients_request,
            SUM(patients_admitted) AS total_patients_admitted,
            SUM(patients_refused) AS total_patient_refused,
            ROUND(AVG(patient_satisfaction), 2) AS service_avg_satisfaction,
            (ROUND(SUM(patients_admitted) * 100.0 / SUM(patients_request), 2)) AS Admission_rate,
            (ROUND(SUM(patients_refused) * 100.0 / SUM(patients_request), 2)) AS Refusal_rate
		FROM services_weekly
        GROUP BY service
	) as service_stats
    CROSS JOIN
    (SELECT AVG(patient_satisfaction) as hospital_avg_satisfaction FROM services_weekly) AS overall;
    

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT
	distinct staff_id,
    staff_name,
    service,
    (
		SELECT
			COUNT(DISTINCT patient_id)
		FROM patients p
        WHERE s.service = p.service
    ) AS service_wise_total_patients
FROM staff s

### Daily Challenge:
-- Question:
-- Create a report showing each service with: service name, total patients admitted, the difference between 
-- their total admissions and the average admissions across all services, and a rank indicator 
-- ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT 
	service_stats.*,
    overall.Avg_admission,
    (service_stats.total_patients_admitted -  overall.Avg_admission) AS diff_adm_avg,
    CASE 
		WHEN total_patients_admitted > Avg_admission THEN 'Above Average'
		WHEN total_patients_admitted = Avg_admission THEN 'Average'
    ELSE 'Below Average'
END AS admission_rank
FROM (
		SELECT 
			service AS service_name,
            SUM(patients_admitted) AS total_patients_admitted
		FROM services_weekly
        GROUP BY service
	) as service_stats
    CROSS JOIN
    (SELECT ROUND(AVG(p_admitted), 2) AS Avg_admission FROM (SELECT 
										SUM(patients_admitted) as p_admitted
										FROM services_weekly 
                                        GROUP BY service) AS service_wise
                                        ) overall;







