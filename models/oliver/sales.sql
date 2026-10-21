
{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.firstname AS customer_first_name,
    c.lastname AS customer_last_name,
    d.date_id AS sale_date,
    d.month AS sale_month,
    d.year AS sale_year,
    s.store_name,
    s.city AS store_city,
    s.state AS store_state,
    p.product_name,
    e.firstname AS employee_first_name,
    e.lastname AS employee_last_name,
    f.quantity,
    f.unit_price,
    f.dollars_sold
FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.cust_key = c.cust_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key
