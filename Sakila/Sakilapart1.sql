use sakila;
#1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table.
SELECT film.film_id, film.title, film.description, film.rating, category.name 
FROM film INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category on film_category.category_id = category.category_id
WHERE category.name="Comedy" AND film.rating="PG-13";

#2 Find out the top 3 rented horror movies.
SELECT film.title,film.description, category.name, count(customer.customer_id) AS total_customers_rented FROM customer 
INNER JOIN rental ON customer.customer_id = rental.customer_id 
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id 
INNER JOIN film ON inventory.film_id = film.film_id 
INNER JOIN film_category ON film.film_id = film_category.film_id 
INNER JOIN category ON category.category_id = film_category.category_id 
WHERE category.name="horror" GROUP BY film.film_id ORDER BY total_customers_rented DESC LIMIT 3;

#3. Find out the list of customers from India who have rented sports movies.
SELECT DISTINCT CONCAT_WS(" ",customer.first_name,customer.last_name) as customer_name, country.country, category.name 
FROM customer INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id 
INNER JOIN country ON city.country_id = country.country_id 
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE country.country="India" and category.name = "Sports";

#4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.
SELECT DISTINCT CONCAT_WS(" ",customer.first_name,customer.last_name) as customer_name, 
CONCAT_WS(" ",actor.first_name,actor.last_name) as actor_name, country.country
FROM customer INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id 
INNER JOIN country ON city.country_id = country.country_id 
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN film_actor ON inventory.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE country.country="Canada" AND actor.first_name = "NICK" and actor.last_name="WAHLBERG";

#5. Find out the number of movies in which “SEAN WILLIAMS” acted.
SELECT CONCAT_WS(" ",actor.first_name,actor.last_name) as actor_name,count(actor.actor_id) as no_of_movies
FROM film_actor INNER JOIN actor ON film_actor.actor_id = actor.actor_id
where actor.first_name = "SEAN" AND actor.last_name= "WILLIAMS";