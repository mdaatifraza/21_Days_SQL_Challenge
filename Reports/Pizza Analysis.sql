## Phase 1: Foundation & Inspection
-- List all unique pizza categories (DISTINCT).
SELECT 
	DISTINCT category AS pizza_categories
FROM pizza_types;

-- Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". 
-- Show first 5 rows.
SELECT 
	pizza_type_id, 
    name,
    COALESCE(ingredients, 'Missing Data') AS ingredients
FROM pizza_types
LIMIT 5;

-- Check for pizzas missing a price (IS NULL).
SELECT 
	*
FROM pizzas
WHERE price IS NULL;

## Phase 2: Filtering & Exploration
-- Orders placed on '2015-01-01' (SELECT + WHERE).
SELECT 
	od.*,
    o.date,
    o.time,
    p.pizza_type_id,
    p.size,
    p.price,
    pt.name,
    pt.category,
    pt.ingredients
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE o.date = '2015-01-01';

-- List pizzas with price descending.
SELECT
	pt.*,
    p.size,
    p.price
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC;

-- Pizzas sold in sizes 'L' or 'XL'.
SELECT
	pt.*,
    p.size,
    p.price
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
WHERE p.size in ('L', 'XL');

-- Pizzas priced between $15.00 and $17.00.
SELECT
	pt.*,
    CONCAT('$', p.price) AS price
FROM pizza_types pt
JOIN pizzas p
ON pt.pizza_type_id = p.pizza_type_id
WHERE p.price BETWEEN 15.00 AND 17.00;

-- Pizzas with "Chicken" in the name.
SELECT
	*
FROM pizza_types
WHERE name LIKE '%Chicken%';

-- Orders on '2015-02-15' or placed after 8 PM.
SELECT 
	od.*,
    o.date,
    o.time,
    p.pizza_type_id,
    p.size,
    p.price,
    pt.name,
    pt.category,
    pt.ingredients
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE o.date = '2015-02-15' OR time >= '20:00:00';

## Phase 3: Sales Performance
-- Total quantity of pizzas sold (SUM).
SELECT
	SUM(quantity) AS total_quantity_of_pizzas
FROM order_details;

-- Average pizza price (AVG).
SELECT
	ROUND(AVG(price), 2) AS Avg_pizza_price
FROM pizzas;

-- Total order value per order (JOIN, SUM, GROUP BY).
SELECT
	od.order_id,
    SUM(quantity * price) AS order_value
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY od.order_id;

-- Total quantity sold per pizza category (JOIN, GROUP BY).
SELECT
	pt.category,
    SUM(od.quantity) AS total_qty_sold
FROM order_details od
JOIN pizzas p 
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- Categories with more than 5,000 pizzas sold (HAVING).
SELECT
    pt.category,
    SUM(od.quantity) AS total_qty_sold
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
HAVING SUM(od.quantity) > 5000;

-- Pizzas never ordered (LEFT/RIGHT JOIN).
SELECT 
	p.pizza_id,
    p.pizza_type_id,
    pt.name,
    pt.category,
    p.size,
    p.price
FROM pizzas p
LEFT JOIN order_details od
ON p.pizza_id = od.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
WHERE od.order_id IS NULL;

-- Price differences between different sizes of the same pizza (SELF JOIN).
SELECT
	p1.pizza_type_id,
    p1.price AS price_1,
    p2.price AS price_2,
    concat(p1.size, ' vs ', p2.size) AS size_comparision,
    (p1.price - p2.price) AS price_difference
FROM pizzas p1
JOIN pizzas p2
ON p1.pizza_type_id = p2.pizza_type_id
AND P1.price > p2.price
ORDER BY p1.pizza_type_id
