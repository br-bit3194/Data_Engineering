-- Note: can't use windows function with WHERE clause due to the order of query execution
-- Ranking based on key or partition key rank() OVER (PARTITION BY col2 ORDER BY col1 DESC)

-- 1) Nested query
select * from
(select *,
	RANK() OVER (partition by order_date ORDER BY order_revenue DESC) AS rnk,
	DENSE_RANK() OVER (partition by order_date ORDER BY order_revenue DESC) AS drnk
from daily_product_revenue
where to_char(order_date::timestamp, 'yyyy-MM') = '2014-01'
) as q
where q.rnk <=5
order by q.order_date, q.order_revenue desc;

-- 2) CTE
WITH cte as
(select *,
	RANK() OVER (partition by order_date ORDER BY order_revenue DESC) AS rnk,
	DENSE_RANK() OVER (partition by order_date ORDER BY order_revenue DESC) AS drnk
from daily_product_revenue
where to_char(order_date::timestamp, 'yyyy-MM') = '2014-01'
)
select * from cte where rnk <=5
order by order_date, order_revenue desc;
