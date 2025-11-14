### Practice Questions:
-- 1. List all unique services in the patients table.
SELECT 
	DISTINCT(service) as service_name
FROM patients;

-- 2. Find all unique staff roles in the hospital.
SELECT 
	DISTINCT role AS staff_role
FROM staff;

-- 3. Get distinct months from the services_weekly table.
SELECT 
	DISTINCT month
FROM services_weekly;

### Daily Challenge:
-- Question:
-- Find all unique combinations of service and event type from the services_weekly table where events are 
-- not null or none, along with the count of occurrences for each combination. Order by count descending.
SELECT 
    service AS service_name,
    event AS  event_type,
    COUNT(*) AS total_count
FROM services_weekly
WHERE 
    event IS NOT NULL 
    AND event <> 'none'
GROUP BY service, event 
ORDER BY total_count DESC


