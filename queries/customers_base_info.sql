-- dim_customers base info
SELECT
	*
FROM analytics.dim_customers
LIMIT 10;

-- customer_unique_id count
SELECT COUNT(customer_unique_id) FROM analytics.dim_customers;

-- customer_id count
SELECT COUNT(customer_id) FROM analytics.dim_customers;

-- Which city has the most and least customers
SELECT
	customer_city,
	COUNT(*) AS customer_count
FROM analytics.dim_customers
GROUP BY customer_city
ORDER BY customer_count ASC
LIMIT 1

