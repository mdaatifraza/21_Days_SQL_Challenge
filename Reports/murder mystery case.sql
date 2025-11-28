-- 1. Who entered the CEO’s Office close to the time of the murder?
SELECT
	e.*,
    kl.room,
    kl.entry_time,
    kl.exit_time
FROM employees e
JOIN keycard_logs kl
ON e.employee_id = kl.employee_id
WHERE (kl.entry_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:05:00') AND kl.room = 'CEO Office';

-- 2. Who claimed to be somewhere else but was not?
 SELECT
	a.*,
    kl.room AS actual_room,
    kl.entry_time,
    kl.exit_time
FROM alibis a
LEFT JOIN keycard_logs kl
ON a.employee_id = kl.employee_id AND (a.claim_time BETWEEN kl.entry_time AND kl.exit_time)
WHERE a.claimed_location <> kl.room OR kl.room IS NULL;

-- 3. Who made or received calls around 20:50–21:00?
SELECT 
	c.call_id,
    c.caller_id,
    ec.name AS caller_name,
    c.receiver_id,
    er.name AS receiver_name,
    c.call_time,
    c.duration_sec
FROM calls c
JOIN employees ec
ON c.caller_id = ec.employee_id
JOIN employees er
ON c.receiver_id = er.employee_id
WHERE c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';

-- 4. What evidence was found at the crime scene?
SELECT 
	*
FROM evidence
WHERE room = 'CEO Office';

-- 5. Which suspect’s movements, alibi, and call activity don’t add up?
WITH movement AS 
	(SELECT
		e.*,
		kl.room,
		kl.entry_time,
		kl.exit_time
	FROM employees e
	JOIN keycard_logs kl
	ON e.employee_id = kl.employee_id
	WHERE kl.entry_time BETWEEN '2025-10-15 20:45:00' AND '2025-10-15 21:05:00')
    
,alibi_check AS (
    SELECT
        employee_id,
        claimed_location,
        claim_time
    FROM alibis 
    WHERE claim_time  BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00')
,
calls_window AS (
    SELECT 
        DISTINCT c.caller_id AS employee_id
    FROM calls c
    WHERE 
        c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00'
    UNION
    SELECT DISTINCT c.receiver_id
    FROM calls c
    WHERE c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00'
)
SELECT 
	e.name AS murderer_name,
    m.room AS actual_room,
    m.entry_time,
    m.exit_time,
    ac.claimed_location,
    ac.claim_time
FROM employees e
LEFT JOIN movement m
ON e.employee_id = m.employee_id
LEFT JOIN alibi_check ac
ON e.employee_id = ac.employee_id
LEFT JOIN calls_window cw
ON e.employee_id = cw.employee_id
WHERE m.room <> ac.claimed_location OR m.room = 'CEO Office'
