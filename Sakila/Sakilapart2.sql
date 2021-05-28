use sakila;
#1. Find out the number of documentaries with deleted scenes.
SELECT count(film.film_id) as documentaries_with_del_scenes, category.name 
FROM film INNER JOIN film_category ON film.film_id=film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
where category.name="Documentary" and film.special_features like "%Deleted Scenes%";

#2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
SELECT DISTINCT count(film_category.film_id) AS no_of_sci_fi_movies, CONCAT_WS(" ",staff.first_name, staff.last_name) AS manager_name
FROM film_category INNER JOIN category ON film_category.category_id=category.category_id
INNER JOIN inventory ON film_category.film_id = inventory.film_id
INNER JOIN store ON store.store_id = inventory.store_id
INNER JOIN staff ON store.manager_staff_id = staff.staff_id 
WHERE category.name="Sci-Fi" AND staff.first_name="Jon" AND staff.last_name="Stephens";


#3. Find out the total sales from Animation movies.
SELECT * FROM sales_by_film_category WHERE category='Animation';


#4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.
SELECT category.name, count(customer.customer_id) AS NO_OF_MOVIES FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE customer.first_name = 'PATRICIA' AND customer.last_name = 'JOHNSON'
GROUP BY category.name ORDER BY NO_OF_MOVIES DESC LIMIT 3;


#5. Find out the number of R rated movies rented by “SUSAN WILSON”.
SELECT COUNT(film.rating) AS NO_OF_R_RATED_MOVIES FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer ON customer.customer_id = rental.customer_id
WHERE customer.first_name = 'SUSAN' AND customer.last_name = 'WILSON' AND film.rating = 'R';