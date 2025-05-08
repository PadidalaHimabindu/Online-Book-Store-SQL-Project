CREATE DATABASE Bookstore;

SELECT * FROM Bookstore.books;
SELECT * FROM Bookstore.customers;
SELECT * FROM Bookstore.orders;


-- 1) Retrieve all books in the "Fiction" genre:
SELECT * 
FROM books
WHERE genre='Fiction'; 


-- 2) Find books published after the year 1950:
SELECT title,published_year
FROM books
WHERE published_year>1950;


-- 3) List all customers from the Canada:
SELECT * 
FROM customers
WHERE country='Canada';


-- 4) Show orders placed in November 2023:
SELECT *
FROM orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS total_stock
FROM books;


-- 6) Find the details of the most expensive book:
SELECT *
FROM books
ORDER BY PRICE DESC
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT *
FROM orders
WHERE total_amount>20;


-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM books;


-- 10) Find the book with the lowest stock:
SELECT * 
FROM books
ORDER BY stock 
limit 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS Revenue
FROM orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.genre,SUM(o.quantity) as total_sold
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.genre;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Avg_price
FROM books
GROUP BY genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT c.customer_id,c.name,COUNT(order_id) AS orders_count
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.name
HAVING orders_count>=2;


-- 4) Find the most frequently ordered book:
SELECT b.book_id,b.title,COUNT(o.order_id) AS frequent_order
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.book_id,b.title
ORDER BY frequent_order DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT *
FROM books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author,SUM(quantity) AS total_quantity
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
WHERE o.total_amount>30;


-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS orders_amount
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.name
ORDER BY orders_amount DESC LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT 
    b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) AS Order_quantity,  
    b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;

