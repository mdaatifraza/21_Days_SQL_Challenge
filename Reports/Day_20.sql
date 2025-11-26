### Practice Questions:
-- 1. Calculate running total of patients admitted by week for each service.
SELECT 
	service,
    week,
    patients_admitted,
    SUM(patients_admitted) OVER(PARTITION BY service ORDER BY week ASC) AS running_total
FROM services_weekly;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT
	*,
	ROUND(AVG(avg_satisfaction) OVER(ORDER BY week ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS moving_avg_4_weeks
FROM
	(SELECT 
		week,
		ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
	FROM services_weekly
	GROUP BY week) AS a;

-- 3. Show cumulative patient refusals by week across all services.
SELECT 
	*,
    SUM(total_patients_refused) OVER(ORDER BY week ASC) AS cumulative_patient
FROM
	(SELECT 
		week,
		SUM(patients_refused) AS total_patients_refused
	FROM services_weekly
	GROUP BY week) AS a;

### Daily Challenge:
-- Question:
-- Create a trend analysis showing for each service and week: week number, patients_admitted, running total 
-- of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior 
-- weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 
-- only.
SELECT 
	service,
	week,
	patients_admitted,
    SUM(patients_admitted) OVER(partition by service ORDER BY week) AS running_total_patients_admitted,
    patient_satisfaction,
    ROUND(AVG(patient_satisfaction) OVER(PARTITION BY service ORDER BY week ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS _3days_moving_avg_satisfaction,
    ROUND((patients_admitted - Service_avg), 2) AS Diff_week_patient_service_avg
FROM
	(SELECT 
		service,
		week,
		patients_admitted,
        patient_satisfaction,
        (SELECT AVG(patients_admitted) avg_p_a FROM services_weekly s1 WHERE s1.service = s.service) AS Service_avg
	FROM services_weekly s
	WHERE week between 10 and 20) AS a



