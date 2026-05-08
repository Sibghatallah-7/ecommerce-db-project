-- ============================================================
-- E-Commerce Database System
-- 04_queries.sql — Joins, Subqueries, Aggregation Functions
-- ============================================================


-- ===================== JOINS =====================

-- Q1. INNER JOIN: Display all orders with customer name and order status
SELECT o.order_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       o.order_date,
       o.total_amount,
       o.order_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Q2. INNER JOIN (3-way): Display order items with product name and category
SELECT oi.item_id,
       o.order_id,
       p.product_name,
       cat.category_name,
       oi.quantity,
       oi.unit_price,
       oi.subtotal
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id;

-- Q3. LEFT OUTER JOIN: Show all customers including those with no orders
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       c.city,
       o.order_id,
       o.order_date,
       o.total_amount
FROM customers c
LEFT OUTER JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- Q4. RIGHT OUTER JOIN: Show all products including those never ordered
SELECT p.product_id,
       p.product_name,
       p.price,
       oi.order_id,
       oi.quantity
FROM order_items oi
RIGHT OUTER JOIN products p ON oi.product_id = p.product_id
ORDER BY p.product_id;

-- Q5. FULL OUTER JOIN: Show all orders and all shipping records
SELECT o.order_id,
       o.order_status,
       s.shipping_id,
       s.shipping_status,
       s.tracking_number
FROM orders o
FULL OUTER JOIN shipping s ON o.order_id = s.order_id;

-- Q6. SELF JOIN: Find customers from the same city
SELECT a.first_name || ' ' || a.last_name AS customer_1,
       b.first_name || ' ' || b.last_name AS customer_2,
       a.city
FROM customers a, customers b
WHERE a.city = b.city
  AND a.customer_id < b.customer_id;


-- ===================== SUBQUERIES =====================

-- Q7. Single-row subquery: Find products priced above the average price
SELECT product_id,
       product_name,
       price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Q8. Single-row subquery: Find the customer who placed the highest total order
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       o.order_id,
       o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount = (SELECT MAX(total_amount) FROM orders);

-- Q9. Multiple-row subquery (IN): Find customers who ordered Electronics
SELECT DISTINCT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name
FROM customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category_id = (SELECT category_id FROM categories WHERE category_name = 'Electronics')
);

-- Q10. Multiple-row subquery (ANY): Products cheaper than ANY Electronics product
SELECT product_id,
       product_name,
       price
FROM products
WHERE price < ANY (
    SELECT price FROM products WHERE category_id = 1
);

-- Q11. Multiple-row subquery (ALL): Products cheaper than ALL Electronics products
SELECT product_id,
       product_name,
       price
FROM products
WHERE price < ALL (
    SELECT price FROM products WHERE category_id = 1
);

-- Q12. Subquery in HAVING: Categories with avg product price above overall avg
SELECT cat.category_name,
       AVG(p.price) AS avg_price
FROM products p
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name
HAVING AVG(p.price) > (SELECT AVG(price) FROM products);

-- Q13. Correlated subquery: Find each customer's most recent order
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       o.order_id,
       o.order_date,
       o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);


-- ===================== AGGREGATION FUNCTIONS =====================

-- Q14. COUNT: Total number of orders per status
SELECT order_status,
       COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Q15. SUM: Total revenue generated (excluding cancelled orders)
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status <> 'Cancelled';

-- Q16. AVG: Average order value per customer
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       COUNT(o.order_id) AS total_orders,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY avg_order_value DESC;

-- Q17. MIN / MAX: Cheapest and most expensive product in each category
SELECT cat.category_name,
       MIN(p.price) AS cheapest_product,
       MAX(p.price) AS most_expensive
FROM products p
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name;

-- Q18. GROUP BY with HAVING: Categories with total revenue > 50000
SELECT cat.category_name,
       SUM(oi.subtotal) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY cat.category_name
HAVING SUM(oi.subtotal) > 50000
ORDER BY total_revenue DESC;

-- Q19. Nested aggregation: Category with the highest average product price
SELECT category_name, avg_price
FROM (
    SELECT cat.category_name,
           ROUND(AVG(p.price), 2) AS avg_price
    FROM products p
    JOIN categories cat ON p.category_id = cat.category_id
    GROUP BY cat.category_name
    ORDER BY avg_price DESC
)
WHERE ROWNUM = 1;

-- Q20. COUNT DISTINCT: Number of unique customers who placed orders
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;

-- Q21. Revenue by payment method
SELECT payment_method,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_collected
FROM payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_collected DESC;

-- Q22. Monthly sales report
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       COUNT(*) AS total_orders,
       SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- Q23. Top 3 best-selling products by quantity
SELECT product_name, total_qty_sold
FROM (
    SELECT p.product_name,
           SUM(oi.quantity) AS total_qty_sold
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY p.product_name
    ORDER BY total_qty_sold DESC
)
WHERE ROWNUM <= 3;

-- Q24. Customers who have never placed an order
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       c.email
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);

-- Q25. Display data from Views
SELECT * FROM vw_customer_order_summary;
SELECT * FROM vw_product_catalog;
SELECT * FROM vw_order_details;
SELECT * FROM vw_category_revenue;
SELECT * FROM vw_shipping_tracker;
