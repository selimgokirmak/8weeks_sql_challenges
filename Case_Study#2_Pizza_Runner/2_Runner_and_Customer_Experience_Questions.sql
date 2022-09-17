-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
/*
WITH runners_cte AS
	( SELECT *, (date_trunc('week', registration_date) + '4 days')::date week_start
	  FROM pizza_runner.runners )
	 
SELECT week_start, count(*)
FROM runners_cte
GROUP BY week_start
ORDER BY 1
*/


-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
/*
with pickup_cte as (
select ro.runner_id, co.order_time, ro.pickup_time, Extract(epoch FROM (ro.pickup_time::timestamp - co.order_time::timestamp))/60 time_diff_min
from pizza_runner.customer_orders co
join pizza_runner.runner_orders ro
	using (order_id)
where ro.pickup_time is not null )

SELECT runner_id, avg(time_diff_min)
FROM pickup_cte
GROUP BY runner_id
ORDER BY 1
*/


-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
/*
with pickup_cte as (
select ro.runner_id, co.order_id, co.pizza_id, co.order_time, ro.pickup_time, Extract(epoch FROM (ro.pickup_time::timestamp - co.order_time::timestamp))/60 time_diff_min
from pizza_runner.customer_orders co
join pizza_runner.runner_orders ro
	using (order_id)
where ro.pickup_time is not null )

SELECT order_id, count(pizza_id), avg(time_diff_min) avg_time_min
FROM pickup_cte
GROUP BY order_id
ORDER BY 1
*/


-- What was the average distance travelled for each customer?
/*
select co.customer_id, avg(ro.distance) avg_distance
from pizza_runner.customer_orders co
join pizza_runner.runner_orders ro
	using (order_id)
where distance is not null
group by co.customer_id
order by 1
*/


-- What was the difference between the longest and shortest delivery times for all orders?
/*
with pickup_cte as (
select ro.runner_id, co.order_id, co.pizza_id, co.order_time, ro.pickup_time, Extract(epoch FROM (ro.pickup_time::timestamp - co.order_time::timestamp))/60 time_diff_min
from pizza_runner.customer_orders co
join pizza_runner.runner_orders ro
	using (order_id)
where ro.pickup_time is not null )

SELECT max(time_diff_min) - min(time_diff_min) longest_shortest_time_diff
FROM pickup_cte
*/


-- What was the average speed for each runner for each delivery and do you notice any trend for these values?
/*
SELECT runner_id, order_id, (distance / duration) * 60 speed
FROM pizza_runner.runner_orders
WHERE distance IS NOT NULL
ORDER BY 1, 2
*/


-- What is the successful delivery percentage for each runner?
/*
select runner_id, count(pickup_time) successfull_del, count(*) all_orders, round(count(pickup_time)*1.0 / count(*) * 100, 0) succes_percentage
from pizza_runner.runner_orders 
group by runner_id
order by 1
*/

