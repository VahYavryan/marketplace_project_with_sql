SELECT
	*
FROM analytics.fact_orders
LIMIT 100;

-- order_unique_id counts
SELECT
	COUNT(order_unique_id) AS unique_id_count
FROM analytics.fact_orders

-- order_id counts
SELECT
	COUNT(order_id)
FROM analytics.fact_orders

-- order items id
SELECT
	DISTINCT order_item_id
FROM analytics.fact_orders

-- pyment_type
SELECT
	DISTINCT (payment_type)
FROM analytics.fact_orders

-- COUNT
SELECT
	DISTINCT (payment_type)
FROM analytics.fact_orders

-- COUNT boleto type
SELECT
	COUNT(payment_type)
FROM analytics.fact_orders
WHERE payment_type LIKE 'voucher'

-- Price
SELECT
	MIN(price) AS min_price,
	AVG(price) AS avg_price,
	MAX(price) AS max_price,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
FROM analytics.fact_orders;

