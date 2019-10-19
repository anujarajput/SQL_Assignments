

--1.

CREATE VIEW Order_details
AS
SELECT it.order_id, ord.customer_id, it.product_id, pr.brand_id, it.quantity, it.list_price      
FROM sales.order_items it INNER JOIN sales.orders ord
ON it.order_id = ord.order_id INNER JOIN production.products pr
ON it.product_id = pr.product_id

SELECT *
FROM Order_details;


--2.

CREATE VIEW Staff_sales
AS
SELECT ord.staff_id, stf.store_id, stf.first_name, stf.last_name, 
SUM(itm.quantity * itm.list_price) AS 'Order Value'
FROM sales.order_items itm INNER JOIN sales.orders ord
ON itm.order_id = ord.order_id INNER JOIN sales.staffs stf
ON ord.staff_id = stf.staff_id
GROUP BY stf.first_name, stf.last_name,ord.staff_id, stf.store_id

SELECT * 
FROM Staff_sales

--3.

CREATE PROCEDURE procedure_stores
@store VARCHAR(255),
@count INT OUTPUT
AS
BEGIN
	INSERT INTO sales.stores(store_name)
	VALUES (@store)
	SELECT @count = COUNT(*)
	FROM sales.stores
END

DECLARE @c INT
EXEC dbo.procedure_stores 
@store = 'ABC',
@count = @c OUTPUT
SELECT @c AS 'Count'

SELECT *
FROM sales.stores


--4.

CREATE PROCEDURE procedure_store_wise_sale
AS
BEGIN
	SELECT stor.store_id, stor.store_name, stor.city, COUNT(ord.order_id) AS 'Order Count'
	FROM sales.orders ord INNER JOIN sales.stores stor 
	ON ord.store_id = stor.store_id
	GROUP BY stor.store_id, stor.store_name, stor.city
END

EXEC procedure_store_wise_sale

--5.

CREATE FUNCTION avg_qty(
@c_id INT,
@year INT
)
RETURNS INT
AS
BEGIN
	DECLARE @count INT
	SELECT @count = SUM(quantity * list_price)
	FROM sales.orders ord INNER JOIN sales.order_items itm
	ON ord.order_id = itm.order_id
	WHERE customer_id = @c_id AND YEAR(ord.order_date) = @year
	RETURN @count
END

SELECT dbo.avg_qty(1212,2016);