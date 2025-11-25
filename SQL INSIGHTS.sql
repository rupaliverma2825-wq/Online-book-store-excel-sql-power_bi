DROP TABLE IF EXISTS BOOKS;
DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE BOOKS (
	BOOK_ID SERIAL PRIMARY KEY,
	TITLE VARCHAR(100),
	AUTHOR VARCHAR(100),
	GENRE VARCHAR(100),
	PUBLISHED_YEAR INT,
	PRICE NUMERIC(10, 2),
	STOCK INT
);

CREATE TABLE CUSTOMERS (
	CUSTOMER_ID SERIAL PRIMARY KEY,
	NAME VARCHAR(100),
	EMAIL VARCHAR(100),
	PHONE INT,
	CITY VARCHAR(100),
	COUNTRY VARCHAR(100)
);

CREATE TABLE ORDERS (
	ORDER_ID SERIAL PRIMARY KEY,
	CUSTOMER_ID SERIAL,
	BOOK_ID INT,
	ORDER_DATE DATE,
	QUANTITY INT,
	TOTAL_AMOUNT NUMERIC(10, 2)
);

SELECT * FROM BOOKS;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

--Retrieve top 5 books in the "Fiction" genre 

SELECT TITLE,GENRE
FROM BOOKS
WHERE GENRE='Fiction'
LIMIT 5;

--Find books published after the year 1950

SELECT TITLE,published_year
FROM BOOKS
WHERE published_year > 1950 
LIMIT 10;

--List all customers from the Canada

SELECT NAME,COUNTRY
FROM CUSTOMERS
WHERE COUNTRY='Canada';

--Show orders placed in November 2023

select order_id,Customer_id
from orders
where order_date BETWEEN '2023-11-01' and '2023-11-30';

--Retrieve the total stock of books available

select 
sum(stock) as "total_stock"
from books;

--Find the details of the most expensive book

select
max(price) as "Most Expensive"
from books;

--Show all top 10 customers who ordered more than 1 quantity of a book

SELECT
	C.NAME,
	O.QUANTITY
FROM
	CUSTOMERS C
	INNER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE
	QUANTITY > 1

order by O.quantity desc
limit 10 ;

--Retrieve all orders where the total amount exceeds $450

select order_id,total_amount
from orders
where total_amount > 450;

--List all genres available in the Books table

select distinct genre
from books;

--Find the book with the lowest stock

select title,stock
from books
order by stock asc
limit 1;

--Calculate the total revenue generated from all orders

select 
sum(total_amount) as "total_revenue"
from orders;

--Retrieve the total number of books sold for each genre

select * from orders;
select * from books;
select * from customers;

SELECT
	B.GENRE,
	SUM(O.QUANTITY) AS "total_sold"
FROM
	ORDERS O
	JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
GROUP BY
	B.genre;

--Find the average price of books in the "Fantasy" genre

select 
avg(price) as "Average_price"
from books
where genre= 'Fantasy';

--List customers who have placed at least 2 orders

SELECT
	C.NAME,
	COUNT(O.ORDER_ID) AS "total_orders"
FROM
	CUSTOMERS C
	JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY
	C.NAME
HAVING
	COUNT(O.ORDER_ID) >= 2
ORDER BY
	"total_orders" ASC;

--Find the most frequently ordered book

SELECT 
    B.title,
    COUNT(O.book_id) AS order_count
FROM 
    orders O
JOIN 
    books B ON O.book_id = B.book_id
GROUP BY 
    B.title
ORDER BY 
    order_count DESC
LIMIT 1;

--Show the top 3 most expensive books of 'Fantasy' Genre 

SELECT
	TITLE,
	PRICE
FROM
	BOOKS
WHERE
	GENRE = 'Fantasy'
ORDER BY
	PRICE DESC
LIMIT
	3;

--Retrieve the total quantity of books sold by each author

select * from books;
select * from orders;
select * from customers;

SELECT
	B.AUTHOR, sum(O.QUANTITY) AS "total"
FROM
	BOOKS B
	JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID
GROUP BY
	B.AUTHOR
order by total desc
limit 5;

--Find the customer who spent the most on orders

select * from customers;
select * from orders;
select * from books;

SELECT
	C.NAME,
	MAX(O.TOTAL_AMOUNT) AS "Total_amt"
FROM
	CUSTOMERS C
	JOIN ORDERS O
	on C.customer_id = O.customer_id
group by C.name
ORDER BY
	"Total_amt" DESC
LIMIT
	5;










