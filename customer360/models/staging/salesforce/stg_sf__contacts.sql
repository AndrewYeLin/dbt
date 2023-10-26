
with source as (
    select * from {{ source('salesforce','contacts') }}
),

renamed as (
    select
        id,
        username,
        name,
        gender,
        address, 
        mail,
        birthdate,
        _loaded_at_utc,
        row_number() over (partition by id order by _loaded_at_utc desc) as row_num
    from source     
),

renamed_refined as (
    select
        id,
        username as user_name,
        name,
        gender,
        address, 
        mail as email_address,
        birthdate as birth_date,
        _loaded_at_utc
    from renamed  
    where row_num = 1
)

select * from renamed_refined

