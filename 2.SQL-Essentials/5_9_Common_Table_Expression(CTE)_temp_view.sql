-- create the order_details_cte that combines details from 
-- orders and order_items tables
--- ************** CTE -> Common Table Expressions **************
WITH order_details_cte AS
(SELECT ord.*, 
	ordt.order_item_id,
	ordt.order_item_product_id,
	ordt.order_item_subtotal
FROM ORDERS as ord
	JOIN order_items as ordt
	on ord.order_id=ordt.order_item_order_id)
select * from order_details_cte;

--- temporary view that doesn't persist in the db. If session restarted then it will be gone.
