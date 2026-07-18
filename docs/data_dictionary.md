# 📖 Data Dictionary: analytics.fact_orders

This dictionary defines the technical attributes and storage metrics implemented inside the core analytical transaction layer.

## 1. Primary and Foreign Keys

- **order_unique_id:** Text identifier serving as the analytical logical trace for individual orders.
- **order_id:** Text attribute referencing the distinct marketplace invoice system identifier.
- **order_item_id:** Integer sequence displaying the exact line-item number within a single order grouping.
- **customer_id:** Text identifier establishing the relational foreign key link to the customer dimension table.
- **product_id:** Text hash identifier mapping the transactional record directly to the product catalog warehouse.
- **seller_id:** Text key defining the structural ownership link to the specific fulfillment supplier record.

## 2. Monetary and Operational Dimensions

- **payment_type:** Text attribute capturing the customer choice of transaction settlement method.
- **price:** Numeric field recording the base financial cost of the purchased marketplace items.
- **freight_value:** Numeric calculation tracking the exact logistical shipping fee assigned to the transaction row.
- **payment_value:** Numeric metrics detailing the aggregate capital captured from the consumer per payment channel.
- **order_purchase_timestamp:** Native timestamp configuration tracking the entry point of the placement into the server system.
  