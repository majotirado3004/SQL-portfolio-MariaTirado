queries/02-joins.sql
 
# Top 10 countries for Rockbuster in terms of customer numbers

 SELECT D.country,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

# top 10 cities that fall within the top 10 countries you identified in step 1

SELECT C.city,
       D.country,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN (
    SELECT D2.country
    FROM customer A2
    INNER JOIN address B2 ON A2.address_id = B2.address_id
    INNER JOIN city C2 ON B2.city_id = C2.city_id
    INNER JOIN country D2 ON C2.country_id = D2.country_id
    GROUP BY D2.country
    ORDER BY COUNT(A2.customer_id) DESC
    LIMIT 10
)
GROUP BY C.city, D.country
ORDER BY customer_count DESC
LIMIT 10;

# Top 5 customers from the top 10 cities who’ve paid the highest total amounts to Rockbuster

SELECT 
    B.customer_id,
    B.first_name,
    B.last_name,
    E.country,
    D.city,
    SUM(A.amount) AS total_amount_paid
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id = E.country_id
WHERE D.city IN (
    SELECT D2.city
    FROM payment A2
    INNER JOIN customer B2 ON A2.customer_id = B2.customer_id
    INNER JOIN address C2 ON B2.address_id = C2.address_id
    INNER JOIN city D2 ON C2.city_id = D2.city_id
    GROUP BY D2.city
    ORDER BY SUM(A2.amount) DESC
    LIMIT 10
)
GROUP BY B.customer_id, B.first_name, B.last_name, E.country, D.city
ORDER BY total_amount_paid DESC
LIMIT 5;

