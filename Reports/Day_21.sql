### Practice Questions:
-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
    SELECT
        service,
        SUM(available_beds) AS total_available_beds,
        SUM(patients_request) AS total_requests,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        ROUND(SUM(patients_admitted) * 100.0/ SUM(patients_request), 2) AS admission_rate_pct,
        ROUND(SUM(patients_refused) * 100.0/ SUM(patients_request), 2) AS refusal_rate_pct,
        ROUND(SUM(patients_admitted) * 100.0/ SUM(available_beds), 2) AS bed_utilization_rate_pct,
        ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction,
        ROUND(AVG(staff_morale), 2) AS avg_staff_morale
    FROM services_weekly
    GROUP BY service
)

SELECT *
FROM service_stats
ORDER BY service;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
-- 3. Build a CTE for staff utilization and join it with patient data.
 SELECT
        week,
        service,
        COUNT(distinct staff_id) AS total_staff,
        SUM(present) AS staff_present,
        ROUND(SUM(present) * 100.0/ COUNT(*), 2) AS staff_utilization_rate_pct
    FROM staff_schedule
    GROUP BY week, service
    order by service;

### Daily Challenge:
-- Question:
-- Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics 
-- (total admissions, refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks 
-- present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a 
-- final report showing service name, all calculated metrics, and an overall performance score 
-- (weighted average of admission rate and satisfaction). Order by performance score descending.
WITH service_level AS 
(SELECT
	service,
    SUM(patients_admitted) AS total_patient_admitted,
    SUM(patients_refused) AS total_patient_refused,
    ROUND(SUM(patients_admitted)*100.0/(SUM(patients_admitted)+SUM(patients_refused)), 2) AS admission_rate,
    ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM services_weekly
GROUP BY service)
,
staff_weeks AS (
    SELECT
        service,
        staff_id,
        SUM(present) AS weeks_present 
    FROM staff_schedule
    GROUP BY service, staff_id
)
,
service_matrics AS
(SELECT
    service,
    COUNT(DISTINCT staff_id) AS total_staff,              
    ROUND(AVG(weeks_present), 2) AS avg_weeks_present 
FROM staff_weeks
GROUP BY service)
,
patient_stats AS(
SELECT 
	service,
    ROUND(AVG(age), 2) AS avg_age,
    count(distinct patient_id) AS total_patient
FROM patients
GROUP BY service)

SELECT 
	sl.*,
    sm.total_staff,
    sm.avg_weeks_present,
    ps.avg_age,
    ROUND((sl.admission_rate + sl.avg_satisfaction) / 2.0,2) AS performance_score,
    ps.total_patient
FROM service_level sl
JOIN service_matrics sm
ON sl.service = sm.service
JOIN patient_stats ps
ON sl.service = ps.service