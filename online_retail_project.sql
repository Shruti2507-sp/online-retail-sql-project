DROP SCHEMA IF EXISTS retail_db;
CREATE DATABASE retail_db;
USE retail_db;

CREATE TABLE user_login (
user_id VARCHAR(50) PRIMARY KEY,
user_password TEXT,
first_name TEXT,
last_name TEXT,
sign_up_on DATE,
email_id TEXT

);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name TEXT,
    email_id TEXT,
    location TEXT,
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    description TEXT,
    category TEXT,
    price DECIMAL(10, 2),
    in_stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id VARCHAR(50),
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user_login(user_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_each DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method TEXT,
    amount_paid DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO user_login (user_id, user_password, first_name, last_name, sign_up_on, email_id) VALUES
('u001', 'pass123', 'Amit', 'Shah', '2024-01-05', 'amit@example.com'),
('u002', 'pass456', 'Riya', 'Sen', '2024-02-15', 'riya@example.com');
DELETE FROM user_login WHERE user_id IN ('u001', 'u002');
INSERT INTO user_login (user_id, user_password, first_name, last_name, sign_up_on, email_id)
VALUES
('u001', 'pass123', 'Amit', 'Shah', '2024-01-05', 'amit@example.com'),
('u002', 'pass456', 'Riya', 'Sen', '2024-02-15', 'riya@example.com');

INSERT INTO products (product_id, product_name, description, category, price, in_stock) VALUES
(1, 'Bluetooth Headphones', 'Wireless over-ear headphones', 'Electronics', 1999.99, 20),
(2, 'Yoga Mat', 'Eco-friendly yoga mat', 'Fitness', 499.00, 50),
(3, 'Smartwatch', 'Fitness tracker with heart rate', 'Wearables', 2999.99, 15);

INSERT INTO orders (order_id, user_id, order_date, total_amount) VALUES
(5001, 'u001', '2024-03-01', 2498.99),
(5002, 'u002', '2024-03-02', 499.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, price_each) VALUES
(1, 5001, 1, 1, 1999.99),
(2, 5001, 2, 1, 499.00),
(3, 5002, 2, 1, 499.00);

INSERT INTO payments (payment_id, order_id, payment_date, payment_method, amount_paid) VALUES
(9001, 5001, '2024-03-01', 'Credit Card', 2498.99),
(9002, 5002, '2024-03-02', 'UPI', 499.00);

SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN user_login u ON o.user_id = u.user_id
JOIN customers c ON u.email_id = c.email_id;

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

SELECT 
    SUM(amount_paid) AS total_revenue
FROM payments;

SELECT 
    order_id,
    order_date,
    total_amount
FROM orders
WHERE order_date BETWEEN '2024-03-01' AND '2024-03-31';

SELECT 
    product_name,
    in_stock
FROM products
WHERE in_stock < 10;




