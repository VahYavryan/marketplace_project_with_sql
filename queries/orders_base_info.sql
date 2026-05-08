-- dim_sellers base info
SELECT
	*
FROM analytics.dim_sellers
LIMIT 10;

-- sellers_unique_id count
SELECT DISTINCT COUNT (seller_id) AS unique_product_id FROM analytics.dim_sellers;

-- seller_id count
SELECT COUNT(seller_id) FROM analytics.dim_sellers;

-- Which seller has the most and least sellers
SELECT
	seller_state,
	COUNT(*) AS seller_count
FROM analytics.dim_sellers
GROUP BY seller_state
ORDER BY seller_count DESC
LIMIT 1