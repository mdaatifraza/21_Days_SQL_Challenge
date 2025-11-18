### Practice Questions:
-- 1. Show all staff members and their schedule information (including those with no schedule entries).
SELECT
  s.*,
  ss.week,
  ss.present
FROM staff AS s
LEFT JOIN staff_schedule AS ss
  ON s.staff_id = ss.staff_id
ORDER BY s.staff_name, ss.week;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff 
-- assigned).
SELECT 
	sw.service,
    sc.*
FROM services_weekly sw
LEFT JOIN staff_schedule sc
ON sw.service = sc.service
ORDER BY sw.service, sc.week;

-- 3. Display all patients and their service's weekly statistics (if available).
WITH cte AS (
SELECT
	*,
    week(arrival_date, 1) as arrival_week,
    month(arrival_date) as arrival_month
FROM patients)

SELECT
	C.*,
    sw.available_beds,
    sw.patients_request,
    sw.patients_admitted,
    sw.patients_refused,
    sw.patient_satisfaction,
    sw.staff_morale,
    sw.event
FROM cte c
LEFT JOIN services_weekly sw
ON c.arrival_week = sw.week
AND c.arrival_month = sw.month
AND c.service = sw.service;

### Daily Challenge:
-- Question:
-- Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and 
-- the count of weeks they were present (from staff_schedule). Include staff members even if they have no 
-- schedule records. Order by weeks present descending.
WITH present_weeks AS (
  SELECT
    staff_id,
    COUNT(DISTINCT week) AS weeks_present
  FROM staff_schedule
  WHERE present = 1
  GROUP BY staff_id)
  
SELECT
	s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COALESCE(pw.weeks_present, 0) AS weeks_present
FROM staff s
LEFT JOIN present_weeks pw
ON s.staff_id = pw.staff_id
ORDER BY weeks_present DESC
