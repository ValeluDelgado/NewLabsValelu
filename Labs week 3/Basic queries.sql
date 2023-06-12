USE sakila;

#excercise 1: show all tables. 

SHOW TABLES;

#2: Retrieve all the data from the tables actor, film and customer.
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;

#Retrieve the following columns from their respective tables:
#3.1 3.1 Titles of all films from the film table
SELECT title FROM film;
#3.2. List of languages used in films, with the column aliased as language from the language table
SELECT name AS language FROM language;
#3.3 List of first names of all employees from the staff table
SELECT first_name FROM staff;
#4. Retrieve unique release years.
SELECT DISTINCT RELEASE_YEAR FROM film;
#Counting records for database insights:
#5.1 Determine the number of stores that the company has.
SELECT COUNT(store_id) FROM store;
#5.2 Determine the number of employees that the company has.
SELECT COUNT(staff_id) FROM staff;
#5.3 Determine how many films are available for rent and how many have been rented.
SELECT COUNT(rental_id) FROM rental;
SELECT COUNT(inventory_id) FROM inventory;
#5.4 Determine the number of distinct last names of the actors in the database.
SELECT DISTINCT last_name FROM actor;
#6.longest 10 films 
SELECT title, length FROM film ORDER BY length DESC LIMIT 10;
#Use filtering techniques in order to:
#7.1 Retrieve all actors with the first name "SCARLETT".
SELECT * FROM actor WHERE first_name = 'SCARLETT';
#7.2 Retrieve all movies that have ARMAGEDDON in their title and have a duration longer than 100 minutes.
SELECT * FROM film WHERE title LIKE "Armageddon%" AND length > 100;
#Hint: use LIKE operator. More information here.
#7.3 Determine the number of films that include Behind the Scenes content
SELECT COUNT(special_features) from film;






