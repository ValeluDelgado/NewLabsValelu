
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

#6. Determine which films were starred by the most prolific actor in the Sakila database. 
#A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

CREATE OR REPLACE VIEW prolific AS
(SELECT actor_id, COUNT(actor_id)
FROM film_actor
GROUP BY actor_id
ORDER BY 2 DESC
LIMIT 1);

SELECT title FROM film 
WHERE film_id IN (
					(SELECT film_id FROM film_actor
							WHERE actor_id = 
											(SELECT actor_id FROM prolific)));

#Another way to do it: 

SELECT film.title
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
JOIN actor 
ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id = (SELECT actor_id
						FROM film_actor
						GROUP BY actor_id
                        ORDER BY count(actor_id) DESC
                        LIMIT 1);



#7. Find the films rented by the most profitable customer in the Sakila database. 
#You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
 
CREATE OR REPLACE VIEW profitable AS (
SELECT customer_id,SUM(amount) FROM payment
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 1);

SELECT title FROM film
WHERE film_id IN (
					SELECT film_id FROM inventory
						WHERE inventory_id IN (SELECT inventory_id 
							FROM rental
								WHERE customer_id = 
												(SELECT customer_id FROM profitable)));
                                                

#8. Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
#You can use subqueries to accomplish this.

SELECT customer_id, sum(amount) as total_amount_spent
FROM payment 
GROUP BY customer_id
HAVING sum(amount) > (SELECT avg(customer_total) from
						SELECT sum(amount) as customer_total from payment
                        group by customer_id) as a);



CREATE OR REPLACE VIEW sum_amount_client AS (
SELECT customer_id,(SUM(amount)) AS sum_amount FROM payment
GROUP BY 1);

CREATE OR REPLACE VIEW avg_amount_client AS (
SELECT avg(sum_amount) AS avg_amount FROM sum_amount_client);

SELECT c.customer_id,c.first_name,c.last_name, SUM(amount) AS total_amount_spent
FROM payment p
LEFT JOIN customer c ON p.customer_id=c.customer_id
GROUP BY 1,2,3

HAVING SUM(amount) > (
						SELECT AVG(avg_amount) 	
							FROM avg_amount_client)
ORDER BY 2	

 