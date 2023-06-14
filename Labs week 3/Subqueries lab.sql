
USE sakila;

#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT count(*) as Copies
FROM inventory
WHERE film_id = (SELECT film_id
					FROM film
					WHERE title = 'Hunchback Impossible');
                    
 
 
#2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
				FROM film);
                

#3. Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT first_name, last_name 
FROM actor
WHERE actor_id in (SELECT actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id
									FROM film
                                    WHERE title = 'Alone trip')); 
                                    
#4. Sales have been lagging among young families, and you want to target family movies for a promotion. 
#Identify all movies categorized as family films.

SELECT title 
FROM film
WHERE film_id  in (SELECT film_id
					FROM film_category
					WHERE category_id = (SELECT category_id
                                    FROM category 
                                    WHERE name = 'Family'));
                                    
#5. Retrieve the name and email of customers from Canada using both subqueries and joins. 
#To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT first_name, email
FROM customer
WHERE address_id in (SELECT address_id
					FROM address
                    WHERE city_id in (SELECT city_id
									FROM city 
                                    WHERE country_id = (SELECT country_id
														FROM country
                                                        WHERE country = 'Canada')));

#6. 




 