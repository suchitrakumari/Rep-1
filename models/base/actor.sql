{{ config(materialized='ephemeral', sort='actor_id') }}

with source_data as (

   SELECT CONCAT(a.first_name,' ',a.last_name) actor_name , a.actor_id, first_name, last_name
       , fa.film_id ,  greatest(a.last_update, fa.last_update) last_update
    FROM actor  a
    JOIN film_actor fa ON fa.actor_id = a.actor_id

)

select * from source_data