-- dim_products base info
SELECT
	*
FROM analytics.dim_products
LIMIT 10;

-- products_unique_id count
SELECT DISTINCT COUNT (product_id) AS unique_product_id FROM analytics.dim_products;

-- products_id count
SELECT COUNT(product_id) FROM analytics.dim_products;

-- Which city has the most and least products
SELECT
	product_category_name,
	COUNT(*) AS product_count
FROM analytics.dim_products
GROUP BY product_category_name
ORDER BY product_count DESC
LIMIT 1