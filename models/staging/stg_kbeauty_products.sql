select
    product_id,
    product_name,
    brand,
    category,
    price_brl,
    rating,
    in_stock,
    key_ingredients,
    has_missing_price,
    has_missing_rating

from {{ source('kbeauty', 'kbeauty_silver_products') }}