
-- Use the `ref` function to select from other models
with source  as (
    SELECT CONCAT(a.first_name,' ',a.last_name) actor_name, f.release_year
    FROM  {{ ref('my_first_dbt_model') }} a
    JOIN film_actor fa ON fa.actor_id = a.actor_id
    JOIN film f ON f.film_id = fa.film_id

)

SELECT  actor_name,
	COUNT(release_year) year_wise_film
FROM  source 
GROUP BY actor_name
ORDER BY COUNT(release_year)