-- What are the standard ingredients for each pizza?
/*
WITH toppings_cte AS
	(SELECT pizza_id,
			trim(unnest(string_to_array(toppings, ',')))::integer toppings_id
	 FROM pizza_runner.pizza_recipes)

SELECT pn.pizza_name, STRING_AGG(pt.topping_name, ', ') std_ingredients
FROM toppings_cte tc
JOIN pizza_runner.pizza_toppings pt 
	ON tc.toppings_id = pt.topping_id
JOIN pizza_runner.pizza_names pn
	USING(pizza_id)
GROUP BY pn.pizza_name
ORDER BY 1, 2
*/


-- What was the most commonly added extra?
/*
WITH extras_cte AS
	(SELECT *, trim(unnest(string_to_array(extras, ',')))::integer extras_id
	 FROM pizza_runner.customer_orders
	 WHERE extras IS NOT NULL )

SELECT pt.topping_name, COUNT(*)
FROM extras_cte ec
JOIN pizza_runner.pizza_toppings pt 
	ON ec.extras_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY 2 DESC
LIMIT 1
*/


-- What was the most common exclusion?
/*
WITH exclusions_cte AS (
	 SELECT *, trim(unnest(string_to_array(exclusions, ',')))::integer exclusions_id
	 FROM pizza_runner.customer_orders
	 WHERE exclusions IS NOT NULL )
	 
SELECT pt.topping_name, count(*)
FROM exclusions_cte ec
JOIN pizza_runner.pizza_toppings pt 
	ON ec.exclusions_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY 2 DESC
LIMIT 1
*/


-- Generate an order item for each record in the customers_orders table in the format of one of the following:
-- Meat Lovers
-- Meat Lovers - Exclude Beef
-- Meat Lovers - Extra Bacon
-- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers


-- Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
-- For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"


-- What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?






















































































