-- =============================================================
-- ExpansionIQ: Retail Expansion Strategy for Minimalist
-- Database Schema (PostgreSQL)
-- =============================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS cities;

-- =========================
-- Cities
-- =========================
CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city VARCHAR(100) UNIQUE NOT NULL,
    state VARCHAR(100),
    population INT,
    average_income NUMERIC(12,2),
    competition_score INT,
    rent_index NUMERIC(10,2),
    mall_count INT,
    female_population_percent NUMERIC(5,2)
);

-- =========================
-- Customers
-- =========================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(100),
    state VARCHAR(100),
    annual_income NUMERIC(12,2),
    skin_type VARCHAR(30),
    signup_date DATE,
    CONSTRAINT fk_customer_city
        FOREIGN KEY(city)
        REFERENCES cities(city)
);

-- =========================
-- Products
-- =========================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    product_name VARCHAR(120),
    brand VARCHAR(50) DEFAULT 'Minimalist',
    cost_price NUMERIC(10,2),
    selling_price NUMERIC(10,2)
);

-- =========================
-- Orders
-- =========================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    payment_method VARCHAR(30),
    order_status VARCHAR(30),
    discount NUMERIC(5,2),
    shipping_cost NUMERIC(10,2),
    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
);

-- =========================
-- Order Items
-- =========================
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    selling_price NUMERIC(10,2),
    FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

-- =============================================================
-- Useful Indexes
-- =============================================================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_customers_city
ON customers(city);

CREATE INDEX idx_products_category
ON products(category);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

-- =============================================================
-- Data Import Example
-- =============================================================
-- COPY cities FROM '/path/cities.csv' DELIMITER ',' CSV HEADER;
-- COPY customers FROM '/path/customers.csv' DELIMITER ',' CSV HEADER;
-- COPY products FROM '/path/products.csv' DELIMITER ',' CSV HEADER;
-- COPY orders FROM '/path/orders.csv' DELIMITER ',' CSV HEADER;
-- COPY order_items FROM '/path/order_items.csv' DELIMITER ',' CSV HEADER;
