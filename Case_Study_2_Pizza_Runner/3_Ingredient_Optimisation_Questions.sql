-- What are the standard ingredients for each pizza?
/*
WITH toppings_cte AS
	(SELECT pizza_id,
			trim(unnest(string_to_array(toppings, ',')))::integer toppings_id
	 FROM pizza_runner.pizza_recipes)

SELECT tc.*, pt.topping_name
FROM toppings_cte tc
JOIN pizza_runner.pizza_toppings pt 
	ON tc.toppings_id = pt.topping_id
ORDER BY 1, 2
*/


-- What was the most commonly added extra?
/*
WITH extras_cte AS
	(SELECT *, trim(unnest(string_to_array(extras, ',')))::integer extras_id
	 FROM pizza_runner.customer_orders
	 WHERE extras IS NOT NULL )

SELECT pt.topping_name, count(*)
FROM extras_cte ec
JOIN pizza_runner.pizza_toppings pt 
	ON ec.extras_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY 2 DESC
LIMIT 1
*/


-- What was the most common exclusion?































































































