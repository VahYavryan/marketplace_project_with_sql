-- Window Function (Ամսական վաճառքի աճի դինամիկան և Running Total)
WITH monthly_revenue AS (
	SELECT
		DATE_TRUNC('month', order_purchase_timestamp) AS order_month,
			ROUND(SUM(price)::numeric, 2) AS monthly_sales
		FROM analytics.fact_orders
		GROUP BY 1
)
SELECT
	order_month,
	monthly_sales,
	-- Running Total
	ROUND(SUM(monthly_sales) OVER (ORDER BY order_month)::numeric, 2) AS cumulative_sales,
	-- Month-over-Month Growth
	ROUND(
		((monthly_sales - LAG(monthly_sales) OVER (ORDER BY order_month)) / 
		LAG(monthly_sales) OVER (ORDER BY order_month) * 100)::numeric, 2
	) AS mom_growth_percent
	FROM monthly_revenue
	ORDER BY order_month;


-- Spatial Analytics (Առաքման հեռավորության վերլուծություն)
SELECT
	c.customer_state,
	ROUND(AVG(ST_Distance(cg.geom::geography, sg.geom) /1000)::numeric, 2) AS avg_delivery_distance_km,
	COUNT(DISTINCT f.order_id) AS total_orders
FROM analytics.fact_orders f
JOIN analytics.dim_customers c ON f.customer_id = c.customer_id
JOIN analytics.dim_sellers s ON f.seller_id = s.seller_id
-- Միացնում ենք աշխարհագրությունը zip_code-երով
JOIN analytics.dim_geolocation cg ON c.customer_zip_code_prefix::integer = cg.zip_code_prefix
JOIN analytics.dim_geolocation sg ON s.seller_zip_code_prefix::integer = sg.zip_code_prefix
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;


	