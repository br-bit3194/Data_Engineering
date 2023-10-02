-- Here are some of the exercises for which you can write SQL queries to self evaluate using all the concepts we have learnt to write SQL Queries.
-- * All the exercises are based on retail tables.
-- * We have already setup the tables and also populated the data.
-- * We will use all the 6 tables in retail database as part of these exercises.

-- Here are the commands to validate the tables
SELECT count(*) FROM departments;
SELECT count(*) FROM categories;
SELECT count(*) FROM products;
SELECT count(*) FROM orders;
SELECT count(*) FROM order_items;
SELECT count(*) FROM customers;

SELECT * FROM orders;
-- ### Exercise 1 - Customer order count

-- Get order count per customer for the month of 2014 January.

-- * Tables - `orders` and `customers`
-- * Data should be sorted in descending order by count and ascending order by customer id.
-- * Output should contain `customer_id`, `customer_fname`, `customer_lname` and `customer_order_count`.

select customers.customer_id, customers.customer_fname, customers.customer_lname, count(*) as customer_order_count
from orders
inner join customers
	on orders.order_customer_id=customers.customer_id
where to_char(orders.order_date::timestamp, 'YYYY-MM')='2014-01'
group by 1,2,3
order by 4 desc, 1;

-- ### Exercise 2 - Dormant Customers

-- Get the customer details who have not placed any order for the month of 2014 January.
-- * Tables - `orders` and `customers`
-- * Output Columns - **All columns from customers as is**
-- * Data should be sorted in ascending order by `customer_id`
-- * Output should contain all the fields from `customers`
-- * Make sure to run below provided validation queries and validate the output.
SELECT count(DISTINCT order_customer_id)
FROM orders
WHERE to_char(order_date, 'yyyy-MM') = '2014-01';

SELECT count(*)
FROM customers;

-- ans using right outer join
select customers.*
from orders
right outer join customers
	on orders.order_customer_id=customers.customer_id
	and to_char(orders.order_date::timestamp, 'YYYY-MM')='2014-01'
where orders.order_id is NULL
order by 1;

-- Get the difference
-- Get the count using solution query, both the difference and this count should match

-- ans using NOT IN
select *
from customers
where customer_id not in (
	select order_customer_id from orders where to_char(order_date::timestamp,'yyyy-MM')='2014-01'
)
order by 1;

-- * Hint: You can use `NOT IN` or `NOT EXISTS` or `OUTER JOIN` to solve this problem.

-- ### Exercise 3 - Revenue Per Customer

-- Get the revenue generated by each customer for the month of 2014 January
-- * Tables - `orders`, `order_items` and `customers`
-- * Data should be sorted in descending order by revenue and then ascending order by `customer_id`
-- * Output should contain `customer_id`, `customer_fname`, `customer_lname`, `customer_revenue`.
-- * If there are no orders placed by customer, then the corresponding revenue for a given customer should be 0.
-- * Consider only `COMPLETE` and `CLOSED` orders

select cust.customer_id, cust.customer_fname, cust.customer_lname, 
	coalesce(round(sum(ordt.order_item_subtotal)::numeric,2),0) as customer_revenue
from customers cust
	left outer join orders ord
		on ord.order_customer_id = cust.customer_id
		and to_char(order_date::timestamp, 'yyyy-MM')='2014-01'
		and ord.order_status in ('COMPLETE','CLOSED')
	left outer join order_items ordt
		on ord.order_id = ordt.order_item_order_id
group by 1,2,3
order by 4 desc, 1
limit 10;

-- ### Exercise 4 - Revenue Per Category

-- Get the revenue generated for each category for the month of 2014 January
-- * Tables - `orders`, `order_items`, `products` and `categories`
-- * Data should be sorted in ascending order by `category_id`.
-- * Output should contain all the fields from `categories` along with the revenue as `category_revenue`.
-- * Consider only `COMPLETE` and `CLOSED` orders

select * from orders;
select * from customers;
select * from order_items;
select * from products;
select * from categories;

SELECT cat.category_id,
		cat.category_department_id,
		cat.category_name,
		ROUND(SUM(ordt.order_item_subtotal)::numeric,2) as category_revenue
FROM categories cat
	inner join order_items ordt
		on ord.order_id = ordt.order_item_order_id
	inner join products prod
		on ordt.order_item_product_id = prod.product_id
	inner join orders ord
		ON prod.product_category_id = cat.category_id
		AND ord.order_status in ('CLOSED','COMPLETE')
		AND to_char(order_date, 'yyyy-MM')='2014-01'
GROUP BY 1,2,3
ORDER BY 1;


-- ### Exercise 5 - Product Count Per Department

-- Get the count of products for each department.
-- * Tables - `departments`, `categories`, `products`
-- * Data should be sorted in ascending order by `department_id`
-- * Output should contain all the fields from `departments` and the product count as `product_count`

SELECT dept.department_id, dept.department_name, COUNT(dept.department_name) as product_count
FROM departments dept
	JOIN categories cat
		on dept.department_id = cat.category_department_id
	JOIN products prod
		on cat.category_id = prod.product_category_id
GROUP BY 1,2
ORDER BY 1;