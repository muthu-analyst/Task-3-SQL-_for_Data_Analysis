CREATE DATABASE Internship;
USE Internship;

-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Region VARCHAR(50)
);

-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    StockQty INT
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    PaymentMethod VARCHAR(30),
    OrderStatus VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, Name, Email, Region) VALUES
(1, 'Aarav Mehta', 'aarav.mehta@example.com', 'Mumbai'),
(2, 'Diya Sharma', 'diya.sh arma@example.com', 'Delhi'),
(3, 'Rohan Iyer', 'rohan.iyer@example.com', 'Bangalore'),
(4, 'Sneha Reddy', 'sneha.reddy@example.com', 'Hyderabad'),
(5, 'Kabir Singh', 'kabir.singh@example.com', 'Chennai');

INSERT INTO Products (ProductID, ProductName, Category, StockQty) VALUES
(101, 'Wireless Mouse', 'Electronics', 150),
(102, 'Yoga Mat', 'Fitness', 80),
(103, 'Bluetooth Speaker', 'Electronics', 60),
(104, 'Running Shoes', 'Footwear', 120),
(105, 'Cotton T-Shirt', 'Apparel', 200);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, UnitPrice, PaymentMethod, OrderStatus) VALUES
(1001, 1, 101, '2025-10-01', 2, 799.00, 'Credit Card', 'Delivered'),
(1002, 2, 104, '2025-10-03', 1, 2499.00, 'UPI', 'Delivered'),
(1003, 3, 102, '2025-10-05', 3, 499.00, 'PayPal', 'Pending'),
(1004, 4, 105, '2025-10-07', 4, 299.00, 'Credit Card', 'Cancelled'),
(1005, 5, 103, '2025-10-10', 1, 1599.00, 'UPI', 'Delivered'),
(1006, 1, 104, '2025-10-12', 2, 2399.00, 'Credit Card', 'Delivered'),
(1007, 2, 101, '2025-10-15', 1, 749.00, 'PayPal', 'Delivered'),
(1008, 3, 105, '2025-10-18', 2, 279.00, 'Credit Card', 'Pending');


# List all orders placed using "Credit Card" as the payment method, sorted by most recent first.
SELECT * 
FROM Orders
WHERE PaymentMethod = 'Credit Card'
ORDER BY OrderDate DESC;


-- Show the total quantity sold for each product category.
SELECT Category , SUM(O.Quantity) as Total_Quantity
FROM Orders O
JOIN Orders O ON O.ProductID = .ProductID 
Group by 1


-- Display customer names along with the products they ordered.
SELECT C.Name , ProductName 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Products p ON p.ProductID = O.ProductID


-- List all customers and their orders, including those who haven’t placed any orders.
SELECT C.Name, O.OrderID
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Show all products and their order details, including products that haven’t been ordered.
SELECT p.ProductName, O.OrderID , O.Quantity
FROM Orders O
RIGHT JOIN Products p ON p.ProductID = O.ProductID;


-- Find the customer IDs of those who have placed more than one order.
SELECT CustomerID 
FROM Orders
GROUP BY 1
HAVING COUNT(OrderID) > 1

-- Calculate the total revenue generated from all delivered orders.
SELECT SUM(quantity * UnitPrice) AS Total_revenue 
FROM orders
WHERE OrderStatus = 'Delivered'


-- Create a view showing monthly sales totals by product category.
CREATE VIEW MonthlySales AS
SELECT 
    DATE_TRUNC('month', OrderDate) AS Month,
    P.Category,
    SUM(O.Quantity * O.UnitPrice) AS TotalSales
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
GROUP BY DATE_TRUNC('month', OrderDate), P.Category;

-- Create an index to optimize queries filtering by OrderDate.
CREATE INDEX idx_order_date ON Orders(OrderDate);

-- Find the names of customers who spent more than ₹3000 in total across all their orders.
SELECT c.CustomerID, c.Name, SUM(o.UnitPrice) AS Total
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name
having sum(o.UnitPrice) >= 3000































