-- CTAS -> create table from select query
-- that actually persist in the database
CREATE TABLE ORDER_COUNT_BY_STATUS
AS
SELECT ORDER_STATUS, COUNT(*) AS ORDER_COUNT
FROM ORDERS
GROUP BY 1;

SELECT * FROM ORDER_COUNT_BY_STATUS;

-- create empty table with the same schema
CREATE TABLE orders_stg
AS
SELECT * FROM orders WHERE false;

SELECT * FROM orders_stg;