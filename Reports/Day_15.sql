### Practice Questions:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT 
	*
FROM patients p
JOIN staff s
ON p.service = s.service
LEFT JOIN staff_schedule sc
ON s.staff_id = sc.staff_id;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT 
	*
FROM services_weekly sw
JOIN staff s
ON sw.service = s.service
LEFT JOIN staff_schedule sc
ON s.staff_id = sc.staff_id;

-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT 
	*
FROM services_weekly sw
JOIN staff s
ON sw.service = s.service
LEFT JOIN staff_schedule sc
ON s.staff_id = sc.staff_id;
	
### Daily Challenge:
-- Question:
-- Create a comprehensive service analysis report for week 20 showing: service name, total patients 
-- admitted that week, total patients refused, average patient satisfaction, count of staff assigned to 
-- service, and count of staff present that week. Order by patients admitted descending.
WITH CTE1 AS (
SELECT 
	week,
	service AS service_name,
    SUM(patients_admitted) AS total_patient_admitted,
    SUM(patients_refused) AS total_patient_refused,
    ROUND(AVG(patient_satisfaction), 2) AS Avg_patient_satisfaction
FROM services_weekly
WHERE week = 20
GROUP BY week, service)
,
CTE2 AS(
select 
	sc.week,
    s.service,
    count(distinct s.staff_id) AS total_staff_assigned,
    sum(sc.present) AS total_staff_present
from staff s
left join staff_schedule sc
on s.staff_id = sc.staff_id
where sc.week = 20
group by sc.week, s.service
)

SELECT
	c1.*,
    c2.total_staff_assigned,
    c2.total_staff_present
FROM CTE1 c1
JOIN CTE2 c2
ON c1.service_name = c2.service



