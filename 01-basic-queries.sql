queries/01-basic-queries.sql

# Duplicated data
SELECT title, release
_year, language
id, rental_duration, COUNT(*)
FROM film
GROUP BY title, release_year, language
id, rental_duration
HAVING COUNT(*) > 1;

# Non uniform data
SELECT DISTINCT title FROM film;
SELECT DISTINCT release
_year FROM film;
id FROM film;
SELECT DISTINCT language
SELECT DISTINCT rental
duration FROM film;

# Missing values
SELECT *
FROM film
WHERE film
id IS NULL
OR title IS NULL
OR description IS NULL
OR release_year IS NULL
OR language_id IS NULL 
OR rental_duration IS NULL 
OR rental_rate IS NULL
OR length IS NULL 
OR replacement_cost IS NULL 
OR rating IS NULL 
OR last_update IS NULL 
OR special_features IS NULL 
OR fulltext IS NULL

# Non uniform data 

SELECT DISTINCT customer_id FROM customer;
SELECT DISTINCT first_name FROM customer;
SELECT DISTINCT last_name FROM customer;
SELECT DISTINCT email FROM customer;
SELECT DISTINCT address_id FROM customer;

# Missing values

SELECT *
FROM customer
WHERE customer_id IS NULL
OR first_name IS NULL
OR last_name IS NULL
OR email IS NULL
OR address_id IS NULL
OR store_id IS NULL;
