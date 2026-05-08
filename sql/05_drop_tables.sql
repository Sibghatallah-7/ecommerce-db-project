-- ============================================================
-- E-Commerce Database System
-- 05_drop_tables.sql — Drop all tables (cleanup)
-- Run this BEFORE 01_create_tables.sql if tables already exist
-- ============================================================

DROP TABLE shipping CASCADE CONSTRAINTS;
DROP TABLE payments CASCADE CONSTRAINTS;
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE categories CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;
