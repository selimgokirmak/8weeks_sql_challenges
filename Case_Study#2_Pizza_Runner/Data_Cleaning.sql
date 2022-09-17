-- update 'null' values as NULL in exclusions
/*
SELECT exclusions
FROM pizza_runner.customer_orders
WHERE exclusions = 'null'

UPDATE pizza_runner.customer_orders
SET exclusions = NULL
WHERE exclusions = 'null'
*/


-- update blank values as NULL in exclusions
/*
SELECT exclusions
FROM pizza_runner.customer_orders
WHERE length(exclusions) = 0

UPDATE pizza_runner.customer_orders
SET exclusions = NULL
WHERE length(exclusions) = 0
*/


-- update blank values as NULL in extras
/*
SELECT extras
FROM pizza_runner.customer_orders
WHERE length(extras) = 0

UPDATE pizza_runner.customer_orders
SET extras = NULL
WHERE length(extras) = 0
*/


-- update 'null' values as NULL in extras
/*
SELECT extras
FROM pizza_runner.customer_orders
WHERE extras = 'null'

UPDATE pizza_runner.customer_orders
SET extras = NULL
WHERE extras = 'null'
*/


-- delete 'km' text in distance
/*
SELECT distance,
	position('km' in distance),
	left(distance, position('km' in distance)-1)
FROM pizza_runner.runner_orders
WHERE distance like '%km%'

UPDATE pizza_runner.runner_orders
SET distance = trim(left(distance, position('km' in distance)-1))
WHERE distance like '%km%'
*/

-- delete 'minute' texts in duration
/*
SELECT duration,
	position('m' in duration),
	trim(left(duration, position('m' in duration)-1))
FROM pizza_runner.runner_orders
WHERE duration like '%min%'

UPDATE pizza_runner.runner_orders
SET duration = trim(left(duration, position('m' in duration)-1))
WHERE duration like '%min%'
*/

-- update 'null' values and blank values as NULL in cancellation
/*
SELECT *
FROM pizza_runner.runner_orders
WHERE cancellation = 'null'
	OR length(cancellation) = 0
	
UPDATE pizza_runner.runner_orders
SET cancellation = NULL
WHERE cancellation = 'null'
	OR length(cancellation) = 0
*/

-- update 'null' as NULL in distance
/*
SELECT distance
FROM pizza_runner.runner_orders
WHERE distance = 'null'

UPDATE pizza_runner.runner_orders
SET distance = NULL
WHERE distance = 'null'
*/

-- update 'null' as NULL in duration
/*
SELECT duration
FROM pizza_runner.runner_orders
WHERE duration = 'null'

UPDATE pizza_runner.runner_orders
SET duration = NULL
WHERE duration = 'null'
*/

-- update 'null' as NULL in pickup_time
/*
SELECT pickup_time
FROM pizza_runner.runner_orders
WHERE pickup_time = 'null'

UPDATE pizza_runner.runner_orders
SET pickup_time = NULL
WHERE pickup_time = 'null'
*/

-- change data type of distance and duration
/*
alter table pizza_runner.runner_orders
alter column distance type numeric using distance::numeric;

alter table pizza_runner.runner_orders
alter column duration type integer using duration::integer;
*/


