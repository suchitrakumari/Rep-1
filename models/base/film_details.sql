{{ config(materialized='ephemeral') }}

with source_data as (

	select f.film_id , f.title, f.description, f.release_year
	 	, l.name language, f.rating, f. special_features
		, c.name category_name
        , greatest(greatest(f.last_update, l.last_update), greatest(fc.last_update, c.last_update)) last_update
	
	 from film f 
	join language l on l.language_id=f.language_id
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id

)

select * from source_data

