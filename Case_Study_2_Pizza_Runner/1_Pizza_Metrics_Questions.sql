-- How many pizzas were ordered?
/*
SELECT count(*)
FROM pizza_runner.customer_orders
*/


-- How many unique customer orders were made?
/*
SELECT count(DISTINCT order_id)
FROM pizza_runner.customer_orders
*/


-- How many successful orders were delivered by each runner?
/*
SELECT runner_id, count(*)
FROM pizza_runner.runner_orders
WHERE pickup_time IS NOT NULL
GROUP BY runner_id
ORDER BY 2 DESC
*/


-- How many of each type of pizza was delivered?
/*
SELECT co.pizza_id, count(*)
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro 
	USING(order_id)
WHERE ro.pickup_time IS NOT NULL
GROUP BY co.pizza_id
*/


-- How many Vegetarian and Meatlovers were ordered by each customer?
/*
SELECT co.customer_id, pn.pizza_name, count(*)
FROM pizza_runner.customer_orders co
JOIN pizza_runner.pizza_names pn 
	USING (pizza_id)
GROUP BY co.customer_id, pn.pizza_name
ORDER BY 1
*/


-- What was the maximum number of pizzas delivered in a single order?
/*
SELECT co.order_id, count(*)
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro 
	USING (order_id)
WHERE ro.pickup_time IS NOT NULL
GROUP BY co.order_id
ORDER BY 2 DESC
LIMIT 1
*/


-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
/*
SELECT co.customer_id,count(*) had_change
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro 
	USING (order_id)
WHERE ro.pickup_time IS NOT NULL
	AND (co.exclusions IS NOT NULL OR co.extras IS NOT NULL)
GROUP BY co.customer_id

SELECT co.customer_id, count(*) had_no_change
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro 
	USING (order_id)
WHERE ro.pickup_time IS NOT NULL
	AND (co.exclusions IS NULL AND co.extras IS NULL)
GROUP BY co.customer_id
*/


-- How many pizzas were delivered that had both exclusions and extras?
/*
SELECT count(co.*)
FROM pizza_runner.customer_orders co
JOIN pizza_runner.runner_orders ro 
	USING (order_id)
WHERE ro.pickup_time IS NOT NULL
	AND (co.exclusions IS NOT NULL AND co.extras IS NOT NULL)
*/


-- What was the total volume of pizzas ordered for each hour of the day?
/*
SELECT extract(HOUR FROM order_time), count(*)
FROM pizza_runner.customer_orders
GROUP BY extract(HOUR FROM order_time)
ORDER BY 1
*/


-- What was the volume of orders for each day of the week?
/*
SELECT extract(isodow FROM order_time), count(*)
FROM pizza_runner.customer_orders
GROUP BY extract(isodow FROM order_time)
ORDER BY 1
*/

