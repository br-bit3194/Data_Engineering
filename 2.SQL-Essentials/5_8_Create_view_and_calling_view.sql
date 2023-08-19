-- create the order_details_v view that combines details from 
-- orders and order_items tables
CREATE OR REPLACE VIEW order_details_v
AS
SELECT ord.*, 
	ordt.order_item_id,
	ordt.order_item_product_id,
	ordt.order_item_subtotal
FROM ORDERS as ord
	JOIN order_items as ordt
	on ord.order_id=ordt.order_item_order_id;
	
	
-- calling the view
select * from order_details_v;