-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.
SELECT 
	patient_id, 
	name, 
    age, 
    satisfaction 
FROM patients
WHERE (service = 'surgery' AND satisfaction < 70)


