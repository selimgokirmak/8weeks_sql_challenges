-- If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes, 
-- how much money has Pizza Runner made so far if there are no delivery fees?
/*
WITH pizza_cost_cte AS (
SELECT *,
	CASE WHEN pizza_id = 1 THEN 12
		 ELSE 10
		 END pizza_cost
FROM pizza_runner.customer_orders 
WHERE order_id NOT IN ( SELECT order_id 
						FROM pizza_runner.runner_orders 
						WHERE pickup_time IS NULL ) )

SELECT sum(pizza_cost)
FROM pizza_cost_cte
*/


-- What if there was an additional $1 charge for any pizza extras?
-- Add cheese is $1 extra
/*
WITH pizza_cost_cte AS (
SELECT *,
	CASE WHEN pizza_id = 1 and strpos(extras, '4')>0 then 13
		 when pizza_id = 1 then 12
		 when pizza_id = 2 and strpos(extras, '4')>0 then 11
		 when pizza_id = 2 then 10
		 end pizza_cost
from pizza_runner.customer_orders 
where order_id not in (select order_id 
					   from pizza_runner.runner_orders 
					   where pickup_time is null) )

select sum(pizza_cost)
from pizza_cost_cte
*/


-- The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, 
-- how would you design an additional table for this new dataset, 
-- generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
/*
SET search_path = pizza_runner;
DROP TABLE IF EXISTS runner_ratings;
CREATE TABLE runner_ratings (
  "rating_id" INTEGER,
  "order_id" INTEGER,
  "rating" INTEGER
);

INSERT INTO pizza_runner.runner_ratings
	("rating_id", "order_id", "rating")
VALUES
	('1', '1', '4'),
	('2', '2', '3'),
	('3', '3', '5'),
	('4', '4', '3'),
	('5', '5', '4'),
	('6', '7', '4'),
	('7', '8', '5'),
	('8', '10', '3');
*/


-- Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
/*
	customer_id
	order_id
	runner_id
	rating
	order_time
	pickup_time
	Time between order and pickup
	Delivery duration
	Average speed
	Total number of pizzas
*/
/*
SELECT co.customer_id, 
		co.order_id, 
		ro.runner_id, 
		rr.rating, 
		co.order_time, 
		ro.pickup_time, 
		ro.duration, 
		round((ro.distance*1.0 / ro.duration)*60,1) avg_speed, 
		count(*) Total_number_of_pizzas
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro
	USING (order_id)
JOIN pizza_runner.runner_ratings rr
	USING (order_id)
GROUP BY co.customer_id, 
		 co.order_id, 
		 ro.runner_id, 
		 rr.rating, 
		 co.order_time, 
		 ro.pickup_time, 
		 ro.duration, 
		 round((ro.distance*1.0 / ro.duration)*60,1)
ORDER BY 2
*/


-- If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled 
-- how much money does Pizza Runner have left over after these deliveries?
/*
with pizza_cost_cte as (
select co.order_id, co.pizza_id, ro.distance,
	case when pizza_id = 1 then 12
		 else 10 
		 end pizza_cost,
	distance * 0.3 as runner_paid
from pizza_runner.customer_orders co
join pizza_runner.runner_orders ro
	using (order_id)
where ro.pickup_time is not null ),

distinct_order_cte as (
select order_id, sum(pizza_cost) pizza_cost, round(avg(runner_paid),1) runner_paid
from pizza_cost_cte
group by order_id )

select sum(pizza_cost) - sum(runner_paid) revenue
from distinct_order_cte
*/





















