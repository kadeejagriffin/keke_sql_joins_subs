-- Week5 Wednesday Homework--

-- Question 1: List all the customers who live in Texas (Use JOINs)
SELECT *
FROM customer c ;

SELECT *
FROM address a;


--Join 
SELECT c.customer_id, c.first_name, c.last_name, a.district 
FROM customer c
JOIN address a 
ON c.address_id = a.address_id
WHERE a.district = 'Texas';


-- Question 2: List all payments of more than $7.00 with the customer's first and last name
SELECT *
FROM payment p;

SELECT *
FROM customer c;

--Join
SELECT c.first_name, c.last_name, p.amount 
FROM payment p 
JOIN customer c 
ON p.customer_id = c.customer_id
WHERE amount > 7;



--Question 3: Show all customer names who have made over $175 in payments (use subqueries)
SELECT *
FROM payment p;

SELECT *
FROM customer c;
--step 1: Find all payments over $175
SELECT customer_id, c.first_name, c.last_name, c.email, c.activebool, c.create_date   
FROM customer c 
WHERE c.customer_id IN (
	SELECT customer_id 
	FROM payment p 
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
);

-- Question 4: List all customers that live in Argentina (use the city table)
SELECT *
FROM customer c;

SELECT *
FROM city;

SELECT *
FROM country c; 

--Join-- customer -> address -> city -> country
SELECT c.first_name, c.last_name, a.district, c2.city, c3.country
FROM customer c
JOIN address a 
ON c.address_id = a.address_id 
JOIN city c2 
ON a.city_id = c2.city_id
JOIN country c3 
ON c2.country_id = c3.country_id
WHERE c3.country = 'Argentina';



--Question 5: Show all the film categories with their count in descending order
SELECT *
FROM category c;


SELECT fc.category_id, c.name, COUNT(*) AS num_movies_in_cat
FROM film_category fc
JOIN category c 
ON fc.category_id = c.category_id 
GROUP BY fc.category_id, "name" 
ORDER BY num_movies_in_cat DESC;


-- Question 6: What film had the most actors in it(show film info)
SELECT *
FROM film f; 

SELECT *
FROM film_actor fa; 


SELECT f.film_id, f.title, COUNT(*) AS num_actors
FROM film_actor fa
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY f.film_id, f.title 
ORDER BY num_actors DESC 
LIMIT 1;



--Question 7: Which actor has been in the least movies?
SELECT *
FROM actor a ;

SELECT * 
FROM film f;

--Join
SELECT *
FROM actor a 
WHERE actor_id = (
	SELECT actor_id 
	FROM film_actor fa 
	GROUP BY actor_id 
	ORDER BY COUNT(*) DESC 
	LIMIT 1
);

-- Question 8: Which country has the most cities?
SELECT *
FROM country c; 

SELECT *
FROM city c;

-- Join
SELECT ci.country_id, c.country, COUNT(*)
FROM city ci
JOIN country c 
ON ci.country_id = c.country_id 
GROUP BY ci.country_id, c.country 
ORDER BY COUNT(*) DESC
LIMIT 1;

--Question 9:
SELECT *
FROM film_actor fa; 

SELECT *
FROM actor a; 

--Join
SELECT fa.actor_id, first_name, last_name, COUNT(*)
FROM film_actor fa 
JOIN actor a
ON fa.actor_id = a.actor_id 
GROUP BY fa.actor_id, first_name, last_name 
HAVING COUNT(*) BETWEEN 20 AND 25;






