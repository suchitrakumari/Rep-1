
/*Create a query that lists each actor's full name, film release year and number of year wise released film. (join, aggregrate function, visualisation)
*/

{{ config(
           materialized='incremental'
        ) 

}}

with source  as (
    SELECT CONCAT(a.first_name,' ',a.last_name) actor_name, fa.release_year , greatest (a.last_update,fa.last_update) last_update
    FROM  {{ ref('actor') }} a
    JOIN {{ ref('film_details')}} fa ON a.film_id = fa.film_id
    {% if is_incremental()%}
        where greatest (a.last_update,fa.last_update) >= ( select max(last_update) from {{ this }})
    {% endif %}
)

SELECT  actor_name,
	COUNT(release_year) year_wise_film , max(last_update) last_update
FROM  source 
GROUP BY actor_name
ORDER BY COUNT(release_year)

