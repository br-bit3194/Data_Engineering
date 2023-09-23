-- Note: can't use windows function with WHERE clause due to the order of query execution
-- global rank

-- 1) Nested query
select * from
(select *,
	RANK() OVER (ORDER BY order_revenue DESC) AS rnk,
	DENSE_RANK() OVER (ORDER BY order_revenue DESC) AS drnk
from daily_product_revenue
where order_date = '2014-01-01 00:00:00.0'
) as q
where q.rnk <=5
order by q.order_date, q.order_revenue desc;

-- 2) CTE
WITH cte as
(select *,
	RANK() OVER (ORDER BY order_revenue DESC) AS rnk,
	DENSE_RANK() OVER (ORDER BY order_revenue DESC) AS drnk
from daily_product_revenue
where order_date = '2014-01-01 00:00:00.0'
)
select * from cte where rnk <=5
order by order_date, order_revenue desc;
