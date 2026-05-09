-- ============================================================
-- E-Commerce Database System
-- ALL SQL CODE (Combined)
-- Database Systems Course - Riphah International University
-- ============================================================


-- ============================================================
-- PART 1: DROP TABLES (Run first if tables already exist)
-- ============================================================

DROP TABLE shipping CASCADE CONSTRAINTS;
DROP TABLE payments CASCADE CONSTRAINTS;
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE categories CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;


-- ============================================================
-- PART 2: CREATE TABLES (DDL)
-- ============================================================

-- 1. CATEGORIES Table
CREATE TABLE categories (
    category_id     NUMBER(4)       CONSTRAINT cat_id_pk PRIMARY KEY,
    category_name   VARCHAR2(50)    CONSTRAINT cat_name_nn NOT NULL
                                    CONSTRAINT cat_name_uk UNIQUE,
    description     VARCHAR2(200)
);

-- 2. PRODUCTS Table
CREATE TABLE products (
    product_id      NUMBER(6)       CONSTRAINT prod_id_pk PRIMARY KEY,
    category_id     NUMBER(4)       CONSTRAINT prod_cat_nn NOT NULL,
    product_name    VARCHAR2(100)   CONSTRAINT prod_name_nn NOT NULL,
    description     VARCHAR2(300),
    price           NUMBER(10,2)    CONSTRAINT prod_price_nn NOT NULL
                                    CONSTRAINT prod_price_ck CHECK (price > 0),
    stock_quantity  NUMBER(6)       DEFAULT 0
                                    CONSTRAINT prod_stock_ck CHECK (stock_quantity >= 0),
    date_added      DATE            DEFAULT SYSDATE,
    CONSTRAINT prod_cat_fk FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
);

-- 3. CUSTOMERS Table
CREATE TABLE customers (
    customer_id       NUMBER(6)       CONSTRAINT cust_id_pk PRIMARY KEY,
    first_name        VARCHAR2(30)    CONSTRAINT cust_fname_nn NOT NULL,
    last_name         VARCHAR2(30)    CONSTRAINT cust_lname_nn NOT NULL,
    email             VARCHAR2(60)    CONSTRAINT cust_email_nn NOT NULL
                                      CONSTRAINT cust_email_uk UNIQUE,
    phone             VARCHAR2(20),
    address           VARCHAR2(100),
    city              VARCHAR2(40),
    registration_date DATE            DEFAULT SYSDATE
);

-- 4. ORDERS Table
CREATE TABLE orders (
    order_id        NUMBER(8)       CONSTRAINT ord_id_pk PRIMARY KEY,
    customer_id     NUMBER(6)       CONSTRAINT ord_cust_nn NOT NULL,
    order_date      DATE            DEFAULT SYSDATE,
    total_amount    NUMBER(12,2)    DEFAULT 0,
    order_status    VARCHAR2(20)    DEFAULT 'Pending'
                                    CONSTRAINT ord_status_ck CHECK (
                                        order_status IN ('Pending','Processing','Shipped','Delivered','Cancelled')
                                    ),
    CONSTRAINT ord_cust_fk FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

-- 5. ORDER_ITEMS Table (Bridge / Junction)
CREATE TABLE order_items (
    item_id         NUMBER(10)      CONSTRAINT oi_id_pk PRIMARY KEY,
    order_id        NUMBER(8)       CONSTRAINT oi_ord_nn NOT NULL,
    product_id      NUMBER(6)       CONSTRAINT oi_prod_nn NOT NULL,
    quantity        NUMBER(4)       CONSTRAINT oi_qty_nn NOT NULL
                                    CONSTRAINT oi_qty_ck CHECK (quantity > 0),
    unit_price      NUMBER(10,2)    CONSTRAINT oi_uprice_nn NOT NULL,
    subtotal        NUMBER(12,2),
    CONSTRAINT oi_ord_fk FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT oi_prod_fk FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

-- 6. PAYMENTS Table
CREATE TABLE payments (
    payment_id      NUMBER(8)       CONSTRAINT pay_id_pk PRIMARY KEY,
    order_id        NUMBER(8)       CONSTRAINT pay_ord_nn NOT NULL,
    payment_date    DATE            DEFAULT SYSDATE,
    amount          NUMBER(12,2)    CONSTRAINT pay_amt_nn NOT NULL
                                    CONSTRAINT pay_amt_ck CHECK (amount > 0),
    payment_method  VARCHAR2(30)    CONSTRAINT pay_method_ck CHECK (
                                        payment_method IN ('Credit Card','Debit Card','Cash on Delivery','Bank Transfer','PayPal')
                                    ),
    payment_status  VARCHAR2(20)    DEFAULT 'Completed'
                                    CONSTRAINT pay_status_ck CHECK (
                                        payment_status IN ('Completed','Pending','Failed','Refunded')
                                    ),
    CONSTRAINT pay_ord_fk FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);

-- 7. SHIPPING Table
CREATE TABLE shipping (
    shipping_id       NUMBER(8)       CONSTRAINT ship_id_pk PRIMARY KEY,
    order_id          NUMBER(8)       CONSTRAINT ship_ord_nn NOT NULL,
    shipping_date     DATE,
    delivery_date     DATE,
    shipping_address  VARCHAR2(150)   CONSTRAINT ship_addr_nn NOT NULL,
    shipping_status   VARCHAR2(20)    DEFAULT 'Pending'
                                      CONSTRAINT ship_status_ck CHECK (
                                          shipping_status IN ('Pending','Dispatched','In Transit','Delivered','Returned')
                                      ),
    tracking_number   VARCHAR2(30),
    CONSTRAINT ship_ord_fk FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);


-- ============================================================
-- PART 3: INSERT SAMPLE DATA (DML)
-- ============================================================

-- CATEGORIES
INSERT INTO categories (category_id, category_name, description)
VALUES (1, 'Electronics', 'Smartphones, laptops, tablets, and accessories');

INSERT INTO categories (category_id, category_name, description)
VALUES (2, 'Clothing', 'Men and women apparel including shirts, pants, and dresses');

INSERT INTO categories (category_id, category_name, description)
VALUES (3, 'Books', 'Fiction, non-fiction, academic, and reference books');

INSERT INTO categories (category_id, category_name, description)
VALUES (4, 'Home & Kitchen', 'Furniture, cookware, and home decor items');

INSERT INTO categories (category_id, category_name, description)
VALUES (5, 'Sports & Outdoors', 'Fitness equipment, sportswear, and camping gear');

-- PRODUCTS
INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (101, 1, 'Samsung Galaxy S24', '6.2 inch AMOLED, 128GB, 8GB RAM', 89999.00, 50, TO_DATE('2025-01-15','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (102, 1, 'Dell Inspiron 15 Laptop', '15.6 inch, Intel i5, 512GB SSD, 8GB RAM', 74999.00, 30, TO_DATE('2025-02-10','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (103, 1, 'Apple AirPods Pro', 'Active Noise Cancellation, Wireless', 34999.00, 100, TO_DATE('2025-03-01','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (104, 2, 'Nike Dri-FIT T-Shirt', 'Moisture-wicking polyester, multiple colors', 3499.00, 200, TO_DATE('2025-01-20','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (105, 2, 'Levi Strauss Slim Jeans', 'Classic slim fit denim, dark wash', 5999.00, 150, TO_DATE('2025-02-05','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (106, 3, 'Database System Concepts', 'By Silberschatz, 7th Edition', 2500.00, 80, TO_DATE('2025-03-10','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (107, 3, 'Clean Code by Robert C. Martin', 'A Handbook of Agile Software Craftsmanship', 3200.00, 60, TO_DATE('2025-04-01','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (108, 4, 'Prestige Non-Stick Cookware Set', '5-piece set including frying pan and saucepan', 7999.00, 40, TO_DATE('2025-01-25','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (109, 4, 'Wooden Coffee Table', 'Sheesham wood, modern design', 15999.00, 20, TO_DATE('2025-02-28','YYYY-MM-DD'));

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity, date_added)
VALUES (110, 5, 'Adidas Running Shoes', 'Ultraboost, breathable mesh upper', 12999.00, 70, TO_DATE('2025-03-15','YYYY-MM-DD'));

-- CUSTOMERS
INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1001, 'Ahmed', 'Khan', 'ahmed.khan@email.com', '0301-1234567', '12 Main Boulevard, Gulberg', 'Lahore', TO_DATE('2025-01-10','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1002, 'Fatima', 'Ali', 'fatima.ali@email.com', '0312-9876543', '45 University Road, F-8', 'Islamabad', TO_DATE('2025-01-20','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1003, 'Usman', 'Malik', 'usman.malik@email.com', '0333-5551234', '78 Shahrah-e-Faisal', 'Karachi', TO_DATE('2025-02-05','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1004, 'Ayesha', 'Siddiqui', 'ayesha.siddiqui@email.com', '0345-6789012', '23 GT Road, Saddar', 'Rawalpindi', TO_DATE('2025-02-15','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1005, 'Bilal', 'Ahmed', 'bilal.ahmed@email.com', '0321-4567890', '9 Mall Road, Cantt', 'Peshawar', TO_DATE('2025-03-01','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1006, 'Zainab', 'Hassan', 'zainab.hassan@email.com', '0300-1112233', '56 Jinnah Avenue, G-9', 'Islamabad', TO_DATE('2025-03-10','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1007, 'Hassan', 'Raza', 'hassan.raza@email.com', '0315-7778899', '34 Clifton Block 5', 'Karachi', TO_DATE('2025-03-20','YYYY-MM-DD'));

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address, city, registration_date)
VALUES (1008, 'Sana', 'Tariq', 'sana.tariq@email.com', '0342-3334455', '67 Model Town', 'Lahore', TO_DATE('2025-04-01','YYYY-MM-DD'));

-- ORDERS
INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5001, 1001, TO_DATE('2025-04-01','YYYY-MM-DD'), 124998.00, 'Delivered');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5002, 1002, TO_DATE('2025-04-03','YYYY-MM-DD'), 38498.00, 'Delivered');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5003, 1003, TO_DATE('2025-04-05','YYYY-MM-DD'), 5700.00, 'Shipped');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5004, 1004, TO_DATE('2025-04-07','YYYY-MM-DD'), 89999.00, 'Processing');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5005, 1005, TO_DATE('2025-04-10','YYYY-MM-DD'), 28998.00, 'Delivered');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5006, 1001, TO_DATE('2025-04-12','YYYY-MM-DD'), 15999.00, 'Shipped');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5007, 1006, TO_DATE('2025-04-15','YYYY-MM-DD'), 9498.00, 'Pending');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5008, 1007, TO_DATE('2025-04-18','YYYY-MM-DD'), 74999.00, 'Delivered');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5009, 1003, TO_DATE('2025-04-20','YYYY-MM-DD'), 34999.00, 'Cancelled');

INSERT INTO orders (order_id, customer_id, order_date, total_amount, order_status)
VALUES (5010, 1008, TO_DATE('2025-04-22','YYYY-MM-DD'), 12999.00, 'Processing');

-- ORDER_ITEMS
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (1, 5001, 101, 1, 89999.00, 89999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (2, 5001, 103, 1, 34999.00, 34999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (3, 5002, 104, 1, 3499.00, 3499.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (4, 5002, 103, 1, 34999.00, 34999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (5, 5003, 106, 1, 2500.00, 2500.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (6, 5003, 107, 1, 3200.00, 3200.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (7, 5004, 101, 1, 89999.00, 89999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (8, 5005, 110, 1, 12999.00, 12999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (9, 5005, 108, 2, 7999.00, 15999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (10, 5006, 109, 1, 15999.00, 15999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (11, 5007, 104, 2, 3499.00, 6998.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (12, 5007, 105, 1, 5999.00, 5999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (13, 5008, 102, 1, 74999.00, 74999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (14, 5009, 103, 1, 34999.00, 34999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (15, 5010, 110, 1, 12999.00, 12999.00);

-- PAYMENTS
INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7001, 5001, TO_DATE('2025-04-01','YYYY-MM-DD'), 124998.00, 'Credit Card', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7002, 5002, TO_DATE('2025-04-03','YYYY-MM-DD'), 38498.00, 'Debit Card', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7003, 5003, TO_DATE('2025-04-05','YYYY-MM-DD'), 5700.00, 'Cash on Delivery', 'Pending');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7004, 5004, TO_DATE('2025-04-07','YYYY-MM-DD'), 89999.00, 'Bank Transfer', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7005, 5005, TO_DATE('2025-04-10','YYYY-MM-DD'), 28998.00, 'Credit Card', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7006, 5006, TO_DATE('2025-04-12','YYYY-MM-DD'), 15999.00, 'PayPal', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7007, 5007, TO_DATE('2025-04-15','YYYY-MM-DD'), 9498.00, 'Cash on Delivery', 'Pending');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7008, 5008, TO_DATE('2025-04-18','YYYY-MM-DD'), 74999.00, 'Debit Card', 'Completed');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7009, 5009, TO_DATE('2025-04-20','YYYY-MM-DD'), 34999.00, 'Credit Card', 'Refunded');

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method, payment_status)
VALUES (7010, 5010, TO_DATE('2025-04-22','YYYY-MM-DD'), 12999.00, 'Bank Transfer', 'Pending');

-- SHIPPING
INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9001, 5001, TO_DATE('2025-04-02','YYYY-MM-DD'), TO_DATE('2025-04-05','YYYY-MM-DD'), '12 Main Boulevard, Gulberg, Lahore', 'Delivered', 'TRK-20250402-001');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9002, 5002, TO_DATE('2025-04-04','YYYY-MM-DD'), TO_DATE('2025-04-07','YYYY-MM-DD'), '45 University Road, F-8, Islamabad', 'Delivered', 'TRK-20250404-002');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9003, 5003, TO_DATE('2025-04-06','YYYY-MM-DD'), NULL, '78 Shahrah-e-Faisal, Karachi', 'In Transit', 'TRK-20250406-003');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9004, 5004, NULL, NULL, '23 GT Road, Saddar, Rawalpindi', 'Pending', NULL);

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9005, 5005, TO_DATE('2025-04-11','YYYY-MM-DD'), TO_DATE('2025-04-14','YYYY-MM-DD'), '9 Mall Road, Cantt, Peshawar', 'Delivered', 'TRK-20250411-005');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9006, 5006, TO_DATE('2025-04-13','YYYY-MM-DD'), NULL, '12 Main Boulevard, Gulberg, Lahore', 'Dispatched', 'TRK-20250413-006');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9007, 5007, NULL, NULL, '56 Jinnah Avenue, G-9, Islamabad', 'Pending', NULL);

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9008, 5008, TO_DATE('2025-04-19','YYYY-MM-DD'), TO_DATE('2025-04-22','YYYY-MM-DD'), '34 Clifton Block 5, Karachi', 'Delivered', 'TRK-20250419-008');

INSERT INTO shipping (shipping_id, order_id, shipping_date, delivery_date, shipping_address, shipping_status, tracking_number)
VALUES (9009, 5010, NULL, NULL, '67 Model Town, Lahore', 'Pending', NULL);

COMMIT;


-- ============================================================
-- PART 4: CREATE VIEWS
-- ============================================================

-- VIEW 1: Customer Order Summary
CREATE OR REPLACE VIEW vw_customer_order_summary AS
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       c.email,
       c.city,
       COUNT(o.order_id) AS total_orders,
       NVL(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT OUTER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city;

-- VIEW 2: Product Catalog with Category
CREATE OR REPLACE VIEW vw_product_catalog AS
SELECT p.product_id,
       p.product_name,
       c.category_name,
       p.price,
       p.stock_quantity,
       p.date_added,
       p.description AS product_description
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- VIEW 3: Order Details (Full Breakdown)
CREATE OR REPLACE VIEW vw_order_details AS
SELECT o.order_id,
       o.order_date,
       c.first_name || ' ' || c.last_name AS customer_name,
       p.product_name,
       cat.category_name,
       oi.quantity,
       oi.unit_price,
       oi.subtotal,
       o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id;

-- VIEW 4: Revenue per Category
CREATE OR REPLACE VIEW vw_category_revenue AS
SELECT cat.category_id,
       cat.category_name,
       COUNT(DISTINCT oi.item_id) AS items_sold,
       NVL(SUM(oi.subtotal), 0) AS total_revenue
FROM categories cat
LEFT OUTER JOIN products p ON cat.category_id = p.category_id
LEFT OUTER JOIN order_items oi ON p.product_id = oi.product_id
LEFT OUTER JOIN orders o ON oi.order_id = o.order_id AND o.order_status <> 'Cancelled'
GROUP BY cat.category_id, cat.category_name;

-- VIEW 5: Shipping Tracker
CREATE OR REPLACE VIEW vw_shipping_tracker AS
SELECT s.shipping_id,
       s.tracking_number,
       o.order_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       s.shipping_address,
       s.shipping_date,
       s.delivery_date,
       s.shipping_status,
       o.total_amount
FROM shipping s
JOIN orders o ON s.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id;


-- ============================================================
-- PART 5: QUERIES (Joins, Subqueries, Aggregation)
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
