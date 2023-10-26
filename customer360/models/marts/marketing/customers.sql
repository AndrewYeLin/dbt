SELECT
    id,
    gender,
    {{ age_in_years('birth_date') }} AS age,
    SUM(amount) OVER (PARTITION BY id) AS total_expense,
    MIN(transaction_date) OVER (PARTITION BY id) AS first_purchase_date,
    MAX(transaction_date) OVER (PARTITION BY id) AS last_purchase_date,
    SUM(CASE WHEN category = 'Apps & Games' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS app_and_games_amount,
    SUM(CASE WHEN category = 'Beauty' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS beauty_amount,
    SUM(CASE WHEN category = 'Books' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS books_amount,
    SUM(CASE WHEN category = 'Clothing, Shoes & Accessories' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS clothing_shoes_accessories_amount,
    SUM(CASE WHEN category = 'Movies & TV' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS movies_tv_amount,
    SUM(CASE WHEN category = 'Sports, Fitness & Outdoors' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS sports_fitness_outdoors_amount,
    SUM(CASE WHEN category = 'Kitchen' THEN amount ELSE 0 END) OVER (PARTITION BY id) AS kitchen_amount
FROM {{ ref('contacts_joined_with_transactions') }}

