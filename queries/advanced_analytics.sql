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


--- RFM Segmentation
WITH customer_rfm AS (
	SELECT
		customer_id,
		-- Recency
		(SELECT MAX(order_purchase_timestamp) FROM analytics.fact_orders) :: date - MAX(order_purchase_timestamp)::date AS recency,
		-- Frequency
		COUNT(DISTINCT order_id) AS frequency,
		-- Monetary
		ROUND(SUM(price)::numeric, 2) AS monetary
		FROM analytics.fact_orders
		GROUP BY customer_id
),
rfm_scores AS (
	SELECT
		customer_id,
        recency,
        frequency,
        monetary,
		-- 1-ից 5 միավորների բաշխում
		NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
		NTILE(5) OVER (ORDER BY frequency) AS f_score,
		NTILE(5) OVER (ORDER BY monetary) AS m_score
	FROM customer_rfm
)
SELECT
	customer_id,
    recency,
    frequency,
    monetary,
    (r_score * 100 + f_score * 10 + m_score) AS rfm_combined_score,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'VIP Power User'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk / Drifting Account'
        WHEN r_score >= 4 AND f_score = 1 THEN 'New Customer'
        WHEN r_score <= 1 AND f_score <= 2 THEN 'Churned Customer'
        ELSE 'Regular Customer'
    END AS customer_segment
FROM rfm_scores
ORDER BY monetary DESC;