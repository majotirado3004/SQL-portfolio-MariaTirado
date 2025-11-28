# Find the average amount paid by the top 5 customers

WITH top_customers AS
(SELECT 
      B.customer_id,
      B.first_name,
      B.last_name,
      E.country,
      D.city,
      SUM(A.amount) AS total_amount_paid
  FROM payment A
  INNER JOIN customer B ON A.customer_id = B.customer_id
  INNER JOIN address  C ON B.address_id = C.address_id
  INNER JOIN city     D ON C.city_id   = D.city_id
  INNER JOIN country  E ON D.country_id = E.country_id
  WHERE D.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Caleya', 'So Leopoldo')
AND E.country IN ('United States', 'Mexico', 'China', 'India', 'Japan', 'Brazil', 'Russian Federation', 'Philliphines', 'Turkey', 'Indonesia')
     GROUP BY B.customer_id, B.first_name, B.last_name, E.country, D.city
  ORDER BY total_amount_paid DESC
  LIMIT 5)
  SELECT AVG(total_amount_paid) AS average_amount_paid
  FROM top_customers

# Find out how many of the top 5 customers you identified in step 1 are based within each country

WITH top_5_customers_within_countries AS (
  SELECT 
      B.customer_id,
      B.first_name,
      B.last_name,
      E.country,
      D.city,
      SUM(A.amount) AS total_amount_paid
  FROM payment A
  INNER JOIN customer B ON A.customer_id = B.customer_id
  INNER JOIN address  C ON B.address_id = C.address_id
  INNER JOIN city     D ON C.city_id   = D.city_id
  INNER JOIN country  E ON D.country_id = E.country_id
  WHERE D.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Caleya', 'So Leopoldo')
    AND E.country IN ('United States', 'Mexico', 'China', 'India', 'Japan', 'Brazil', 'Russian Federation', 'Philliphines', 'Turkey', 'Indonesia')
  GROUP BY B.customer_id, B.first_name, B.last_name, E.country, D.city
  ORDER BY total_amount_paid DESC
  LIMIT 5
)
SELECT D.country,
  COUNT(DISTINCT A.customer_id) AS all_customer_count,
  COUNT(DISTINCT T.customer_id) AS top_customer_count
FROM customer A
JOIN address  B ON A.address_id = B.address_id
JOIN city     C ON B.city_id    = C.city_id
JOIN country  D ON C.country_id = D.country_id
LEFT JOIN top_5_customers_within_countries T
  ON T.country = D.country
GROUP BY D.country
ORDER BY all_customer_count DESC, top_customer_count DESC;
