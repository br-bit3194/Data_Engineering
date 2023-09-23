select count(*) from daily_product_revenue;

select * from daily_product_revenue
order by order_date, order_revenue desc;

-- rank() over () -> if same value of col occures, then it will assign same rank to both and skip the next rank until different value comes
-- dense_rank() over() -> it doesn't skip any rank

-- Global Ranking rank() OVER (ORDER BY col1 DESC)
-- Ranking based on key or partition key rank() OVER (PARTITION BY col2 ORDER BY col1 DESC)

-- rank(), dense_rank() global ranking
select *,
	RANK() OVER (ORDER BY order_revenue DESC) AS rnk,
	DENSE_RANK() OVER (ORDER BY order_revenue DESC) AS dense_rnk
from daily_product_revenue
where order_date = '2014-01-01 00:00:00.0'
order by order_revenue DESC;

-- Ranking based on key or partition key rank() OVER (PARTITION BY col2 ORDER BY col1 DESC)
select *,
	RANK() OVER (partition by order_date ORDER BY order_revenue DESC),
	DENSE_RANK() OVER (partition by order_date ORDER BY order_revenue DESC)
from daily_product_revenue
where to_char(order_date::timestamp, 'yyyy-MM') = '2014-01'
order by order_date, order_revenue desc;