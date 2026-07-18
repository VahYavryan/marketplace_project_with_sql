#

## 📊 Customer Insights (dim_customers)

This section contains key insights and metrics derived from the `analytics` schema after the data migration process.

---

### 👥 Customer Insights (`dim_customers`)

This table stores unique customers information, including their geographic location.

### 📋 Key Metrics

-**Total Unique Customers:** 95,128
-**Total Records:** 95,128
-**Primary Key:** customer_id

### 🌍 Geographic Distribution

Below are the cities with the highest and lowest customer concentration.

| Metric | City | Customer Count |
| :--- | :--- | :--- |
| **Most Customers** | 🇧🇷 Sao Paulo | 14,811 |
| **Least Customers** | 🚩 Alvorada do Gurgueia | 1 |

---

## 📦 Product Insights (`dim_products`)

This table contains detailed information about each unique product sold in the marketplace.

### 📝 Key Metrics

- **Total Unique Products:** 31,625
- **Total Records:** 31,625
- **Primary Key:** `product_id`
  
### 🏷️ Product Categories

Analysis of the most and least popular product categories based on variety.

| Metric | Category Name | Unique Product Count |
| :--- | :--- | :--- |
| **Most Popular Category** | 🛏️ cama_mesa_banho | 2,990 |
| **Least Popular Category** | 💿 cds_dvds_musicais | 1 |

---

## 🧑‍🔬 Seller Insight (`dim_sellers`)

This table stores unique sellers information, including their geographic location.

### 📃 Key Metrics

- **Total Unique Sellers:** 2,914
- **Total Records:** 2,914
- **Primary Key:** `seller_id`
  
### 🌏 Geographic Distribution

| Metric | City | Seller Count |
| :--- | :--- | :--- |
| **Most Customers** | 🇧🇷 Sao Paulo | 647 |
| **Least Customers** | 📍 Monteiro Lobato | 1 |

---

## 🔭 Fact Order Insight (`fact_orders`)

This central fact table forms the core of the star schema, capturing granular transactional data for every marketplace order line item. It serves as the primary foundation for generating business intelligence and tracking key performance indicators (KPIs).

### 📔 Key Metrics

- **Primary/Composite Key:** Combined grain of `order_id` and `order_item_id` to ensure absolute record uniqueness.
- **Transactional Grains:** Tracks numerical financial dimensions including `price` and `freight_value` for exact financial auditing.
- **Temporal Dimensions:** Stores critical operational milestones such as `order_purchase_timestamp`, `order_approved_at`, `order_delivered_carrier_date`, and `order_delivered_customer_date` to monitor fulfillment lifecycle pipelines.

---

## 📊 Advanced SQL Queries

### 1. Window Function: Monthly Revenue Growth Trends and Running Total

This analytical query performs time-series financial analysis directly within the database. It leverages PostgreSQL Window Functions to aggregation-level sales data, tracks how monthly revenue changes over time, and calculates the exact Month-over-Month (MoM) growth percentage alongside the cumulative business revenue (Running Total) to evaluate corporate scaling velocity.

### 2. Spatial Analytics: Inter-State Delivery Distance and Fulfillment Metrics

Leveraging PostGIS spatial computing capabilities, this query dynamically measures the exact geodesic distance in kilometers between cross-functional network nodes. By linking customer and seller geospatial points via spatial queries, it calculates the average fulfillment distance per state to identify logistics bottlenecks and optimize supply chain distribution networks.

---

## 📐 Design Decisions & Spatial Architecture

### 1. Normalization & Schema Strategy

The database is modeled using a **Star Schema** optimized for analytical performance:

- **Fact Table:** `analytics.fact_orders` contains transactional grains (price, freight, timestamps).
  
- **Dimension Tables:** `dim_customers`, `dim_products`, `dim_sellers`, and `dim_geolocation` isolate descriptive attributes, enforcing referential integrity.

### 2. Spatial Modeling (PostGIS)

- Transformed raw coordinates into native spatial objects using `GEOMETRY(Point, 4326)`.
- Indexed geography columns using **GiST indexes** (`idx_geolocation_geom`) to optimize spatial joins (`ST_Distance`) and geometric calculations.
