select
    category,
    count(*) as total_products,
    round(avg(price_brl), 2) as avg_price_brl,
    round(avg(rating), 2) as avg_rating,
    round(
        avg(
            case
                when in_stock = true then 1
                else 0
            end
        ) * 100,
        2
    ) as in_stock_percentage

from {{ ref('stg_kbeauty_products') }}

group by category