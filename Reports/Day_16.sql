### Practice Questions:
-- 1. Find patients who are in services with above-average staff count.
SELECT
	p.name AS patients_name,
	a.service AS  service_name,
    a.total_staff,
    a.avg_staff
FROM
	(SELECT
		service,
		count(distinct staff_id) as total_staff,
		ROUND(avg(count(distinct staff_id)) over(),2) as avg_staff 
	FROM staff_schedule
	group by service) AS a
JOIN patients p
ON a.service = p.service
WHERE total_staff > avg_staff;

-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT
	DISTINCT ss.staff_id,
    ss.staff_name,
    ss.service AS service_name
FROM staff_schedule ss
where ss.service IN (
					SELECT
						DISTINCT service
					FROM services_weekly
					WHERE patient_satisfaction < 70
                    )
	
-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT 
	p.patient_id,
    p.name AS patient_name,
    p.service AS service_name
FROM patients p
WHERE p.service IN (
					SELECT
						service
					FROM services_weekly
					GROUP BY service
					HAVING SUM(patients_admitted) > 1000
                    )

### Daily Challenge:
-- Question:
-- Find all patients who were admitted to services that had at least one week where patients were refused 
-- AND the average patient satisfaction for that service was below the overall hospital average 
-- satisfaction. Show patient_id, name, service, and their personal satisfaction score.


SELECT
	p.patient_id,
    p.name,
    p.service,
    p.satisfaction
FROM patients p
WHERE p.service IN 
		(SELECT
			DISTINCT sw.service
		FROM services_weekly sw
        WHERE patients_refused > 0
        )
	  AND 
      (
		SELECT
			AVG(pssw.satisfaction)
		FROM patients pssw
        WHERE p.service = pssw.service
      ) < 
      (
		SELECT 
			AVG(p_all.satisfaction)
		FROM patients p_all
      )
      


