-- 2.1) What are the Top 25 schools (.edu domains)?
SELECT email_domain, COUNT(*) 
FROM users
GROUP BY 1
ORDER BY 2 DESC
LIMIT 25;

-- 2.2) How many .edu learners are located in New York?
SELECT city, COUNT(*)
FROM users
WHERE city = 'New York';

-- 2.3) The mobile_app column contains either mobile-user or NULL. How many of these Codecademy learners are using the mobile app?
SELECT mobile_app, COUNT(*)
FROM users
WHERE mobile_app IS NOT NULL;

-- 3) Query for the sign up counts for each hour 
SELECT signup_at, strftime ('%H', signup_at),
COUNT (*) AS 'Sign Up Counts for Each Hour'
FROM users
GROUP BY 2
ORDER BY 3 DESC;

--4) Join the two tables using JOIN
SELECT *
FROM users
JOIN progress
ON users.user_ID = progress.user_id;

--4) Do different schools (.edu domains) prefer different courses? What courses are the New Yorkers students taking? What courses are the Chicago students taking?
WITH joined_table AS 
(SELECT *
FROM users
LEFT JOIN progress
  ON users.user_id = progress.user_id)
SELECT city, 
COUNT(CASE WHEN learn_sql IN ('completed', 'started') THEN 1 END), 
COUNT(CASE WHEN learn_cpp IN ('completed', 'started') THEN 1 END), 
COUNT(CASE WHEN learn_html IN ('completed', 'started') THEN 1 END),
COUNT(CASE WHEN learn_javascript IN ('completed', 'started') THEN 1 END),
COUNT(CASE WHEN learn_java IN ('completed', 'started') THEN 1 END)
FROM joined_table
GROUP BY city
HAVING city IN ('New York', 'Chicago');



