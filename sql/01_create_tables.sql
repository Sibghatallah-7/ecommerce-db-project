-- ============================================================
-- E-Commerce Database System
-- 01_create_tables.sql — Schema Definition (DDL)
-- Normalized to Third Normal Form (3NF)
-- Compatible with Oracle 11g
-- ============================================================

-- ----------------------------------------
-- 1. CATEGORIES Table
-- ----------------------------------------
CREATE TABLE categories (
    category_id     NUMBER(4)       CONSTRAINT cat_id_pk PRIMARY KEY,
    category_name   VARCHAR2(50)    CONSTRAINT cat_name_nn NOT NULL
                                    CONSTRAINT cat_name_uk UNIQUE,
    description     VARCHAR2(200)
);

-- ----------------------------------------
-- 2. PRODUCTS Table
-- ----------------------------------------
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

-- ----------------------------------------
-- 3. CUSTOMERS Table
-- ----------------------------------------
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

-- ----------------------------------------
-- 4. ORDERS Table
-- ----------------------------------------
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

-- ----------------------------------------
-- 5. ORDER_ITEMS Table (Bridge / Junction)
-- ----------------------------------------
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

-- ----------------------------------------
-- 6. PAYMENTS Table
-- ----------------------------------------
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

-- ----------------------------------------
-- 7. SHIPPING Table
-- ----------------------------------------
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
