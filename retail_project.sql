-- create database
CREATE DATABASE retail_db1;

-- Use database
USE retail_db1;

-- create tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price FLOAT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- inserting values
INSERT INTO Customers VALUES
(1, 'Anusha', 'Hyderabad'),
(2, 'Rahul', 'Mumbai'),
(3, 'Sneha', 'Bangalore');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Shoes', 'Fashion', 3000),
(103, 'Watch', 'Accessories', 2000);

INSERT INTO Orders VALUES
(1, 1, '2026-04-01'),
(2, 2, '2026-04-02');

INSERT INTO Order_Items VALUES
(1, 101, 1),
(1, 102, 2),
(2, 103, 1);


-- Insert Data
SELECT * FROM Customers;
SELECT * FROM Products;


-- find top selling product
SELECT product_id, SUM(quantity) AS total_sold
FROM Order_Items
GROUP BY product_id
ORDER BY total_sold DESC;

-- identify most valuable customers
SELECT customer_id, SUM(quantity * price) AS total_spent
FROM Orders
JOIN Order_Items USING(order_id)
JOIN Products USING(product_id)
GROUP BY customer_id
ORDER BY total_spent DESC;

-- monthly revenue
SELECT MONTH(date) AS month,
SUM(quantity * price) AS revenue
FROM Orders
JOIN Order_Items USING(order_id)
JOIN Products USING(product_id)
GROUP BY MONTH(date);

-- category wise sales analysis
SELECT category, SUM(quantity * price) AS total_sales
FROM Order_Items
JOIN Products USING(product_id)
GROUP BY category;

-- detect inactive customers
SELECT * FROM Customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM Orders
);