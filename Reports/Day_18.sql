### Practice Questions:
-- 1. Combine patient names and staff names into a single list.
SELECT name FROM patients
UNION ALL
SELECT staff_name FROM staff;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT * FROM patients WHERE satisfaction > 90
UNION ALL
SELECT * FROM patients WHERE satisfaction < 50;

-- 3. List all unique names from both patients and staff tables.
SELECT name FROM patients
UNION
SELECT staff_name FROM staff;

### Daily Challenge:
-- Question:
-- Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, 
-- type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services.
-- Order by type, then service, then name.
SELECT 
	patient_id AS identifier,
    name AS full_name,
    'patient' AS type,
    service AS service_name
FROM patients
WHERE service IN ('surgery', 'emergency')
UNION ALL
SELECT
	staff_id,
    staff_name,
    'Staff',
    service
FROM staff
WHERE service IN ('surgery', 'emergency')

ORDER BY type, service_name, full_name





