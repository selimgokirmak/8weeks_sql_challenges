-- What is the total amount each customer spent at the restaurant?
/*
select s.customer_id, sum(m.price) total_spent
from sales s
join menu m
	on s.product_id = m.product_id
group by s.customer_id
*/


-- How many days has each customer visited the restaurant?
/*
select customer_id, COUNT(distinct order_date) days
from sales
group by customer_id
*/


-- What was the first item from the menu purchased by each customer?
/*
with order_cte as (
	select s.customer_id, m.product_name,
		ROW_NUMBER() over(partition by s.customer_id order by s.order_date) row_num
	from sales s
	join menu m
		on s.product_id = m.product_id )

select customer_id, product_name
from order_cte
where row_num = 1
*/


-- What is the most purchased item on the menu and how many times was it purchased by all customers?
/*
select m.product_name, COUNT(*) order_count
from sales s
join menu m
	on s.product_id = m.product_id
group by m.product_name
order by 2 desc
*/


-- Which item was the most popular for each customer?
/*
with order_count_cte as (
	select s.customer_id, m.product_name, COUNT(*) order_count,
		DENSE_RANK() over(partition by s.customer_id order by Count(*) desc) rank_num
	from sales s
	join menu m
		on s.product_id = m.product_id
	group by s.customer_id, m.product_name )

select customer_id, product_name, order_count
from order_count_cte
where rank_num = 1
*/


-- Which item was purchased first by the customer after they became a member?
/*
with orders_cte as (
	select s.customer_id, m.product_name, s.order_date, mm.join_date,
		RANK() OVER(partition by s.customer_id order by order_date) row_num
	from sales s
	join menu m
		on s.product_id = m.product_id
	join members mm
		on s.customer_id = mm.customer_id
	where s.order_date >= mm.join_date )

select customer_id, product_name, order_date, join_date
from orders_cte
where row_num = 1
*/


-- Which item was purchased just before the customer became a member?
/*
with orders_cte as (
	select s.customer_id, m.product_name, s.order_date, mm.join_date,
		RANK() OVER(partition by s.customer_id order by order_date desc) row_num
	from sales s
	join menu m
		on s.product_id = m.product_id
	join members mm
		on s.customer_id = mm.customer_id
	where s.order_date < mm.join_date )

select customer_id, product_name, order_date, join_date
from orders_cte
where row_num = 1
*/


-- What is the total items and amount spent for each member before they became a member?
/*
select s.customer_id, m.product_name, s.order_date, mm.join_date, m.price,
	COUNT(*) over(partition by s.customer_id) total_items,
	SUM(price) over(partition by s.customer_id) total_amount
from sales s
join menu m
	on s.product_id = m.product_id
join members mm
	on s.customer_id = mm.customer_id
where s.order_date < mm.join_date 
*/


-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
/*
with points_cte as (
	select customer_id, m.product_name, sum(price) total_pay,
		CASE WHEN product_name = 'curry' then 10
			 WHEN product_name = 'ramen' then 10
			 WHEN product_name = 'sushi' then 20
			 end points
	from sales s
	join menu m 
		on s.product_id = m.product_id
	group by customer_id, m.product_name ),

total_points_cte as (
	select customer_id, product_name, total_pay, points, (total_pay * points) as total_points
	from points_cte )

select customer_id, SUM(total_points) grandtotal_points
from total_points_cte
group by customer_id
*/


-- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
-- not just sushi - how many points do customer A and B have at the end of January?
/*
with points_cte as (
select s.customer_id, m.product_name, m.price, s.order_date, mm.join_date,
	CASE WHEN m.product_name = 'curry' and s.order_date < mm.join_date THEN 10
		 WHEN m.product_name = 'ramen' and s.order_date < mm.join_date THEN 10
		 WHEN m.product_name = 'sushi' THEN 20
		 WHEN m.product_name = 'curry' and s.order_date >= mm.join_date THEN 20
		 WHEN m.product_name = 'ramen' and s.order_date >= mm.join_date THEN 20
		 END points
from sales s
join menu m
	on s.product_id = m.product_id
join members mm 
	on s.customer_id = mm.customer_id )

select customer_id, sum(price * points) grandtotal_points
from points_cte
group by customer_id
*/





















































