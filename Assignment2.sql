

--1.

SELECT *
FROM Sales.customers
ORDER BY first_name DESC;

--2.

SELECT first_name , last_name, city
FROM Sales.customers
ORDER BY city, first_name;

--3.

SELECT TOP(3) *
FROM production.products
ORDER BY list_price DESC;

--4.

SELECT *
FROM production.products
WHERE list_price >= 300 AND model_year = '2018';

--5.

SELECT *
FROM production.products
WHERE list_price >= 3000 OR model_year = '2018';

--6.

SELECT *
FROM production.products
WHERE list_price >= 1899 AND list_price <= 1999.99;

--7.

SELECT * 
FROM production.products
WHERE list_price
IN(
	SELECT list_price 
	FROM production.products
	WHERE list_price = 299.99 OR list_price = 466.99 OR list_price = 489.99
);

--8.

SELECT *
FROM Sales.customers
WHERE last_name LIKE '[abc]%';

--9.

SELECT *
FROM Sales.customers
WHERE FIRST_name NOT LIKE 'a%';

--10.

SELECT state, city, COUNT(customer_id) AS 'No of Customer'
FROM sales.customers
GROUP BY state, city



--11.

SELECT customer_id, COUNT(order_id) AS 'Order Count'
FROM sales.orders
GROUP BY customer_id, YEAR(order_date)

--12

SELECT category_id, MAX(list_price) AS 'Max_price', MIN(list_price) AS 'Min_Price'
FROM production.products
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500
