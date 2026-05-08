-- ============================================================
-- E-Commerce Database System
-- 02_insert_data.sql — Sample Data (DML)
-- ============================================================

-- ----------------------------------------
-- 1. INSERT INTO CATEGORIES
-- ----------------------------------------
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

-- ----------------------------------------
-- 2. INSERT INTO PRODUCTS
-- ----------------------------------------
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

-- ----------------------------------------
-- 3. INSERT INTO CUSTOMERS
-- ----------------------------------------
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

-- ----------------------------------------
-- 4. INSERT INTO ORDERS
-- ----------------------------------------
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

-- ----------------------------------------
-- 5. INSERT INTO ORDER_ITEMS
-- ----------------------------------------
-- Order 5001: Samsung Galaxy + Dell Laptop
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (1, 5001, 101, 1, 89999.00, 89999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (2, 5001, 103, 1, 34999.00, 34999.00);

-- Order 5002: Nike T-Shirt + AirPods
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (3, 5002, 104, 1, 3499.00, 3499.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (4, 5002, 103, 1, 34999.00, 34999.00);

-- Order 5003: 2x Database Book + Clean Code
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (5, 5003, 106, 1, 2500.00, 2500.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (6, 5003, 107, 1, 3200.00, 3200.00);

-- Order 5004: Samsung Galaxy
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (7, 5004, 101, 1, 89999.00, 89999.00);

-- Order 5005: Running Shoes + Cookware Set
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (8, 5005, 110, 1, 12999.00, 12999.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (9, 5005, 108, 2, 7999.00, 15999.00);

-- Order 5006: Coffee Table
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (10, 5006, 109, 1, 15999.00, 15999.00);

-- Order 5007: Nike T-Shirt x2 + Jeans
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (11, 5007, 104, 2, 3499.00, 6998.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (12, 5007, 105, 1, 5999.00, 5999.00);

-- Order 5008: Dell Laptop
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (13, 5008, 102, 1, 74999.00, 74999.00);

-- Order 5009: AirPods (cancelled order)
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (14, 5009, 103, 1, 34999.00, 34999.00);

-- Order 5010: Running Shoes
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, subtotal)
VALUES (15, 5010, 110, 1, 12999.00, 12999.00);

-- ----------------------------------------
-- 6. INSERT INTO PAYMENTS
-- ----------------------------------------
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

-- ----------------------------------------
-- 7. INSERT INTO SHIPPING
-- ----------------------------------------
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

-- COMMIT all inserted data
COMMIT;
