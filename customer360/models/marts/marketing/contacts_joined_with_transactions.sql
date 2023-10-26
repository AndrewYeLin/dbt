SELECT 
    contacts.*,
    transactions.id AS transaction_id,
    transactions.transaction_date,
    transactions.amount,
    transactions.item_count,
    transactions.category
FROM  {{ ref('stg_web__transactions') }} AS transactions 
INNER JOIN {{ ref('stg_sf__contacts') }} AS contacts 
ON contacts.id = transactions.contact_id
