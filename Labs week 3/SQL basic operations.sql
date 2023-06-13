USE sakila;

#As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;
#1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT floor(avg(length)) FROM film;
SELECT CONCAT(FLOOR(AVG(length) / 60), ' hours ', ROUND(AVG(length) % 60), ' minutes') AS average_duration
FROM film;
#We need to use SQL to help us gain insights into our business operations related to rental dates:
#2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, rental_date,
       MONTH(rental_date) AS rental_month, 
       WEEKDAY(rental_date) AS rental_weekday
FROM rental
LIMIT 20;
#2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT rental_id, rental_date,
       CASE 
           WHEN DAYOFWEEK(rental_date)<6 THEN 'workday'
           ELSE 'weekend'
       END AS DAY_TYPE
FROM rental;

#3. Retrieve null values and replace with not available, then sort in ascending order the film titles. 

SELECT title, ifnull(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#Concatenate the first and las names, first three characters and order them in ascending order by the last name:
SELECT CONCAT(first_name, ' ', last_name) AS full_name, LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;

#Challenge 2: 
#1. The total number of films that have been released
SELECT COUNT(film_id) from film;

#1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

#1.3 sort the results in descending order of the number of films. 
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

#2. Using the rental table, determine the number of rentals processed by each employee.
SELECT staff_id, COUNT(*) AS rental_count
FROM rental
GROUP BY staff_id;

#3. The mean film duration for each rating, and sort the results in descending order of the mean duration.

SELECT rating, ROUND(AVG(length), 2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

#3.Identify which ratings have a mean duration of over two hours
SELECT rating
FROM film
WHERE length > 120
GROUP BY rating;

#4.Determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;




