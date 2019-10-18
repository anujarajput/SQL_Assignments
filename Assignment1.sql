
CREATE DATABASE Assignment1;

CREATE SCHEMA Sales;

CREATE SCHEMA Production;

CREATE TABLE Sales.Customers(
	customer_id INT IDENTITY PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	phone NUMERIC (10) NOT NULL UNIQUE,
	email VARCHAR(30) NOT NULL UNIQUE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(30),
	zip_code NUMERIC (10)
);

--INSERT INTO Sales.Customers(first_name,last_name,phone,email,street,city,state,zip_code)  VALUES ('A','AA',456123,'abc.1@gmail.com','abc','central','big state',412);

SELECT * FROM Sales.Customers;

CREATE TABLE Sales.Stores (
	store_id INT IDENTITY PRIMARY KEY,
	store_name VARCHAR(20) NOT NULL,
	phone NUMERIC (10) NOT NULL,
	email VARCHAR(30),
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(30),
	zip_code NUMERIC (10)
);

--INSERT INTO Sales.Stores(store_name,phone,email,street,city,state,zip_code)  VALUES ('BBC Stores',55456123,'bb@gmai.com','walk street','city central','wall state',641233);

SELECT * FROM Sales.Stores;

CREATE TABLE Sales.Staffs(
	staff_id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	phone NUMERIC(10) NOT NULL UNIQUE,
	store_id INT NOT NULL,
	CONSTRAINT foreign_id FOREIGN KEY (store_id)
	REFERENCES Sales.Stores(store_id)
);

--INSERT INTO Sales.Staffs(staff_id,first_name,last_name,email,phone,store_id) VALUES (1011,'ASD', 'Jksgj', 'asd.j@gmail.com', 98989858, 1);

SELECT * FROM Sales.Staffs;

CREATE TABLE Sales.Orders(
	order_id INT PRIMARY KEY,
	order_status VARCHAR(20) NOT NULL,
	order_date DATE,
	required_date DATE,
	shipped_date DATE,
	store_id INT NOT NULL,
	customer_id INT NOT NULL,
	staff_id INT NOT NULL,
	CONSTRAINT foreign_store FOREIGN KEY (store_id)
	REFERENCES Sales.Stores (store_id),
	CONSTRAINT foreign_customers FOREIGN KEY (customer_id)
	REFERENCES Sales.Customers(customer_id),
	CONSTRAINT foreign_staff FOREIGN KEY (staff_id)
	REFERENCES Sales.Staffs(staff_id)
);

--INSERT INTO Sales.Orders(order_id,order_status,order_date,required_date,shipped_date,store_id,customer_id,staff_id) VALUES (101120,'Shipped','2019/10/23','2019/08/10','2019/07/09',1,1,1011);

SELECT * FROM Sales.Orders;

CREATE TABLE Sales.Order_items(
	item_id INT IDENTITY PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT CHECK(quantity > 0) NOT NULL,
	list_price INT CHECK(list_price > 0) NOT NULL,
	discount INT NOT NULL,
	CONSTRAINT foreign_order FOREIGN KEY(order_id)
	REFERENCES Sales.Orders(order_id)
);

--INSERT INTO Sales.Order_items(order_id, product_id, quantity, list_price, discount) VALUES (101120, 12120, 2, 750, 10);

SELECT * FROM Sales.Order_items;

CREATE TABLE production.categories (
	category_id INT IDENTITY PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

SELECT * FROM production.categories;

CREATE TABLE production.brands (
	brand_id INT IDENTITY PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

SELECT * FROM production.brands;

CREATE TABLE production.products (
	product_id INT IDENTITY PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id),
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id)
);

SELECT * FROM production.products;

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id),
	FOREIGN KEY (product_id) REFERENCES production.products (product_id)
);

SELECT * FROM production.stocks;

