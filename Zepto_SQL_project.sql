CREATE SCHEMA zepto_project;

DROP TABLE IF EXISTS product;

CREATE TABLE zepto_project.product (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

SELECT * FROM zepto_project.product;

-- Data Exploration

-- Counts of rows
SELECT COUNT(*) FROM zepto_project.product;

SELECT COUNT(DISTINCT sku_id) FROM zepto_project.product;


SELECT
COUNT(*) AS total,
COUNT(DISTINCT sku_id) AS distinct_id
FROM zepto_project.product;

-- Sample data
SELECT * 
FROM zepto_project.product
LIMIT 10;

-- NULL values
SELECT * 
FROM zepto_project.product
WHERE category  IS NULL
OR
name IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
availablequantity IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category 
FROM zepto_project.product
ORDER BY category;

-- products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) 
FROM zepto_project.product
GROUP BY outOfStock;

-- product names present multiple times
SELECT name, COUNT(sku_id) AS number_of_sku
FROM zepto_project.product
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

-- Data Cleaning

-- products with price = 0
SELECT * FROM zepto_project.product
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto_project.product
WHERE mrp = 0;

-- convert paise to rupees
UPDATE zepto_project.product
SET mrp = mrp / 100.0,
discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT mrp, discountedSellingPrice FROM zepto_project.product;

-- Data Anlaysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_project.product
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp
FROM zepto_project.product
WHERE outOfStock = TRUE
AND mrp > 300
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_project.product
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_project.product
WHERE mrp > 500
AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_project.product
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice, ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto_project.product
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE 
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto_project.product;

-- Q8. Total Inventory Weight Per Category 
SELECT category, SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_project.product
GROUP BY category
ORDER BY total_weight; 

-- Q9. KPI – Business Performance
SELECT
COUNT(*) AS total_products,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue,
AVG(discountPercent) AS avg_discount,
SUM(CASE WHEN outOfStock=TRUE THEN 1 ELSE 0 END)*100.0/COUNT(*) AS outstock_pct
FROM zepto_project.product;

-- Q10. Which products offer the best value for customers based on price per gram
SELECT sku_id, name, category, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_project.product
WHERE weightInGms >= 100;

-- 	Query Final
SELECT
    sku_id,
    category,
    name,
    mrp,
    discountedSellingPrice,
    discountPercent,
    availableQuantity,
    quantity,
    outOfStock,
    weightInGms,

CASE
    WHEN outOfStock = TRUE THEN 'Out of Stock'
    ELSE 'In Stock'
END AS stock_status,

CASE
    WHEN outOfStock = TRUE THEN 0
    ELSE COALESCE(discountedSellingPrice,0)
       * COALESCE(availableQuantity,0)
END AS estimated_revenue,

(mrp - discountedSellingPrice) AS discount_amount,

ROUND(
     discountedSellingPrice / NULLIF(weightInGms,0),
     2
) AS price_per_gram,

CASE 
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category

FROM zepto_project.product;
