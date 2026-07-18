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

---

## 📐 Design Decisions & Spatial Architecture

### 1. Normalization & Schema Strategy

The database is modeled using a **Star Schema** optimized for analytical performance:

- **Fact Table:** `analytics.fact_orders` contains transactional grains (price, freight, timestamps).
  
- **Dimension Tables:** `dim_customers`, `dim_products`, `dim_sellers`, and `dim_geolocation` isolate descriptive attributes, enforcing referential integrity.

### 2. Spatial Modeling (PostGIS)

- Transformed raw coordinates into native spatial objects using `GEOMETRY(Point, 4326)`.
- Indexed geography columns using **GiST indexes** (`idx_geolocation_geom`) to optimize spatial joins (`ST_Distance`) and geometric calculations.
