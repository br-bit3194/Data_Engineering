-- DAILY Revenue
CREATE TABLE daily_revenue
AS
SELECT O.order_date,
	round(sum(OI.order_item_subtotal)::numeric,2) AS order_revenue
FROM ORDERS AS O
	JOIN ORDER_ITEMS AS OI
		ON O.order_id=OI.order_item_order_id
WHERE O.order_status IN ('COMPLETE','CLOSED')
GROUP BY 1;

SELECT * FROM daily_revenue ORDER BY order_date;

-- Daily product revenue
CREATE TABLE daily_product_revenue
AS
SELECT O.order_date,
	OI.order_item_product_id,
	round(sum(OI.order_item_subtotal)::numeric,2) AS order_revenue
FROM ORDERS AS O
	JOIN ORDER_ITEMS AS OI
		ON O.order_id=OI.order_item_order_id
WHERE O.order_status IN ('COMPLETE','CLOSED')
GROUP BY 1,2;

SELECT * FROM daily_product_revenue ORDER BY 1,3 DESC;