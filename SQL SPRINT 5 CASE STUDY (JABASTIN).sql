-- case study work

use sakila;
-- TASK 1 DISPLAY THE FIRST NAMES, LAST NAMES, ACTOR IDS AND THE DETAILS OF THE LAST UPDATED COLUMN
select first_name, last_name, actor_id, last_update from actor;

-- TASK 2 a) DISPLAY THE FULL NAMES OF ALL ACTORS
select concat(first_name,'', last_name) as full_name from actor;

-- b) DISPLAY THE FIRST NAMES OF ACTORS ALONG WITH THE COUNT OF REPEATED FIRST NAMES
select first_name, count(*) as name_count
from actor
group by first_name;

-- c) DISPLAY THE LAST NAMES OF ACTORS ALONG WITH THE COUNT OF REPEATED LAST NAMES
 select last_name, count(*) as name_count
from actor
group by last_name;

-- TASK 3 DISPLAY THE COUNT OF MOVIES GROUPED BY THE RATING
select rating, count(*) as movie_count from film 
group by rating;

-- TASK 4 CALCULATE AND DISPLAY THE AVERAGE RENTAL RATES BASED ON THE MOVIE RATINGS
select rating, avg(rental_rate) as average_rental_rate from film
group by rating;

-- TASK 5 a) DISPLAY THE MOVIE TITLES WHERE THE REPLACEMENT COST IS UPTO $9
-- USING SUBQUERY
select title from film
where film_id in (select film_id  
                   from film 
                       where replacement_cost <=9);

-- USING QUERY
select title from film where replacement_cost <=9;

-- b) DISPLAY THE MOVIE TITLE WHERE THE REPLACEMENT COST IS BETWEEN $15 AND $20
select title from film where replacement_cost between 15 and 20;

-- c) DISPLAY THE MOVIE TITLE WITH THE HIGHEST REPLACEMENTCOST AND THE LOWEST RENTAL COST
select title from film where replacement_cost = 
(select max(replacement_cost) from film) and 
rental_rate = ( select min(rental_rate) from film);
 
 -- TASK 6 THE MANAGEMENT NEEDS TO KNOW THE LIST ALL THE MOVIES ALONG WITH THE NUMBER OF ACTORS LISTED FOR EACH MOVIE
select film.title, count(actor.actor_id) as actor_count
from film
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
group by film.film_id;

-- TASK 7 DISPLAY THE MOVIE TITLE STARTING WITH THE LETTERS 'K' AND 'Q'
select title from film where title like 'K%' or title like 'Q%'
order by title;

-- TASK 8 THE MOVIE 'AGENT TRUMAN' HAS BEEN A GREAT SUCCESS. DISPLAY THE FIRST NAMES AND LAST NAMES OF ALL ACTORS WHO ARE A PART OF THIS MOVIE
select actor.first_name, actor.last_name from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id
where film.title = 'AGENT TRUMAN';

-- TASK 9 IDENTIFY AND DISPLAY THE NAMES OF THE MOVIES IN THE FAMILY CATEGORY
select title from film 
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
 where category.name = 'family';
 
 
 -- TASK 10 DISPLAY THE NAMES OF THE MOST FREQUENTLY RENTED MOVIES IN DESCENDING ORDER, SO THAT THE MANAGEMENT CAN MAINTAIN MORE COPIES OF SUCH MOVIES
 select film.title, count(*) as rental_count from film 
 join inventory on inventory.film_id = film.film_id
 join rental on rental.inventory_id = inventory.inventory_id
 group by film.film_id
 order by rental_count desc;
 
 -- TASK 11 DISPLAY THE NUMBER OF MOVIE CATEGORIES WHERE THE AVERAGE DIFFERENCE BETWEEN THE MOVIE REPLACEMENT COST AND THE RENTAL RATE IS GREATER THAN $15
 select count(*) as category_count from (
 select category.category_id from category
 join film_category on category.category_id = film_category.category_id
 join film on film_category.film_id = film.film_id
 group by category.category_id
 having avg (film.replacement_cost - film.rental_rate) > 15) as category_count;
 
 -- TASK 12 DISPLAY THE NAMES OF THESE CATEGORIES/GENRES AND THE NUMBER OF MOVIES PER CATEGORY/GENRE, SORTED BY THE NUMBER OF MOVIES
 select category.name, count(*) as movie_count from category
 join film_category on film_category.category_id = category.category_id
 group by category.category_id
 having movie_count between 60 and 70
 order by movie_count;