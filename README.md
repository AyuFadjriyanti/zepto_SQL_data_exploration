# 🛒 Zepto SQL Inventory & Pricing Analysis

## 📌 Project Summary

This project demonstrates end-to-end SQL data processing, from raw inventory data to a structured, dashboard-ready dataset.

The objective was to clean, transform, and analyze product inventory data to generate actionable business insights related to pricing strategy, revenue performance, and stock monitoring.

## 🎯 Business Objective

The dataset was stored in raw format and not ready for reporting.
There was no centralized view to monitor:

- Revenue contribution by category
- Discount effectiveness
- Stock availability performance
- Product value comparison
  
This project builds a structured SQL reporting layer to improve performance monitoring and decision-making.

## 🛠 Technical Skills Demonstrated

- Database schema design
- Data cleaning using SQL (DELETE, UPDATE)
- Data validation & NULL checking
- Aggregation & KPI calculation
- CASE statements & conditional logic
- Revenue modeling
- Price normalization (paise → rupees)
- Derived metrics (price per gram, discount amount)
- Business-oriented SQL analysis

## 🧹 Data Preparation

- Removed invalid records (MRP = 0)
- Converted currency to standard format
- Checked duplicates and missing values
- Validated stock and quantity data
  
Result: Clean and analysis-ready product dataset.

## 📊 Analytical Deliverables

### 1️⃣ Revenue & Category Analysis
- Estimated revenue by category
- Total inventory weight contribution
- Category-level discount comparison

### 2️⃣ Pricing Strategy Analysis
- Top 10 highest discounted products
- Premium products with low discount
- Average discount by category

### 3️⃣ Inventory Monitoring
- Out-of-stock percentage
- High-value out-of-stock detection
- Stock status classification

### 4️⃣ Value Analysis
- Price per gram calculation
- Weight-based segmentation (Low / Medium / Bulk)

## 📈 KPI Dashboard Dataset

Final SQL query produces a consolidated dataset including:

- Stock status label
- Estimated revenue per product
- Discount amount
- Price per gram
- Weight category
- Core KPI metrics
  
This dataset is optimized for BI tools such as Power BI, Tableau, or Looker Studio.

## 🗂 Project Structure

zepto-sql-project/
│

├── 01_schema.sql

├── 02_data_cleaning.sql

├── 03_business_analysis.sql

├── 04_kpi_summary.sql

├── 05_final_dashboard_query.sql

└── README.md

## 🚀 Key Outcome

Built a structured SQL reporting system that transforms raw inventory data into a performance-focused analytical dataset suitable for business intelligence dashboards.

