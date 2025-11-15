-- Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status 
-- ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. 
-- Order by average patient satisfaction descending.

WITH per_week AS (
  SELECT
   week AS week_num,
    CASE WHEN MAX(CASE WHEN event <> 'none' THEN 1 ELSE 0 END) = 1 THEN 'With Event' ELSE 'No Event' END AS event_status,
    AVG(patient_satisfaction) AS avg_patient_satisfaction,
    AVG(staff_morale) AS avg_staff_morale
  FROM services_weekly     
  GROUP BY week
)
SELECT
  event_status,
  COUNT(*) AS week_count,
  ROUND(AVG(avg_patient_satisfaction),2) AS avg_patient_satisfaction,
  ROUND(AVG(avg_staff_morale),2)       AS avg_staff_morale
FROM per_week
GROUP BY event_status
ORDER BY avg_patient_satisfaction DESC;