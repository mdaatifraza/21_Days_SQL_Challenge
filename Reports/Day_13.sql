### Practice Questions:
-- 1. Join patients and staff based on their common service field (show patient and staff who work in 
-- same service).
SELECT 
	p.name AS patient_name,
    s.staff_name AS staff_name,
    p.service AS service_name
FROM patients p
JOIN staff s
ON p.service = s.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT 
    *
FROM services_weekly sw
JOIN staff s
ON sw.service = s.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT 
	p.*,
    sc.staff_name
FROM patients p
join staff_schedule sc
ON p.service = sc.service;

### Daily Challenge:
-- Question:
-- Create a comprehensive report showing patient_id, patient name, age, service, and the total number of 
-- staff members available in their service. Only include patients from services that have more than 5 
-- staff members. Order by number of staff descending, then by patient name.
WITH staff_more_than_5 AS (
SELECT
	service,
	COUNT(*) AS total_staff
FROM staff
GROUP BY service
HAVING COUNT(*) > 5)

SELECT 
	p.patient_id,
    p.name AS patient_name,
    p.age AS patient_age,
    p.service,
    s.total_staff AS total_staff_service
FROM patients p
JOIN staff_more_than_5 s 
ON p.service = s.service
ORDER BY s.total_staff DESC, p.name








