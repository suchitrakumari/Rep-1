with source_data as (

   SELECT CONCAT(a.first_name,' ',a.last_name) actor_name , actor_id, first_name, last_name
    FROM actor a

)

select * from source_data