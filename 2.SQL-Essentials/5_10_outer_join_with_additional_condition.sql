-- check which products are never sold till date
SELECT *
FROM products AS prd
	LEFT OUTER JOIN order_details_v AS odv
	ON prd.product_id = odv.order_item_product_id
WHERE odv.order_item_id is NULL;

-- check which products are never sold on specific year & month
SELECT *
FROM products AS prd
	LEFT OUTER JOIN order_details_v AS odv
	ON prd.product_id = odv.order_item_product_id
		AND to_char(odv.order_date::timestamp, 'yyyy-MM') = '2014-01'
WHERE odv.order_item_id is NULL;
