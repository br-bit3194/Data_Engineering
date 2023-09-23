select to_char(dr.order_date::timestamp, 'yyyy-MM') AS order_month,
	dr.order_date,
	dr.order_revenue,
	sum(order_revenue) over (partition by to_char(dr.order_date::timestamp, 'yyyy-MM')) AS monthly_order_revenue
from daily_revenue AS dr
order by 2;
