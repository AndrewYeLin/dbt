SELECT
    id,
    gender,
    {{ age_in_years('birth_date') }} AS age,
    SUM(amount) AS total_expense,
    MIN(transaction_date) OVER (PARTITION BY id) AS first_purchase_date,
    MAX(transaction_date) OVER (PARTITION BY id) AS last_purchase_date
FROM {{ ref('contacts_joined_with_transactions') }}
GROUP BY
    1,2,3