-- How many customers has Foodie-Fi ever had?
/*
select COUNT(distinct customer_id) unique_customer_count
from subscriptions
*/


-- What is the monthly distribution of trial plan start_date values for our dataset?
-- use the start of the month as the group by value
/*
select MONTH(start_date) month_, COUNT(*) count_
from subscriptions
where plan_id = 0
group by MONTH(start_date)
order by month_
*/


-- What plan start_date values occur after the year 2020 for our dataset? 
-- Show the breakdown by count of events for each plan_name
/*
select plan_id, COUNT(start_date) count_
from subscriptions
where YEAR(start_date) > 2020
group by plan_id
*/


-- What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
/*
select plan_id, COUNT(customer_id) count_,
		round(COUNT(customer_id)*1.0 / (select COUNT(distinct customer_id) from subscriptions) * 100, 1) percentage_ 
from subscriptions
where plan_id = 4
group by plan_id
*/


-- How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
/*
with churned_cte as (
	select s1.customer_id, s1.plan_id plan_0, s1.start_date start_date, s2.plan_id plan_4, s2.start_date end_date
	from subscriptions s1
	inner join subscriptions s2
		on s1.customer_id = s2.customer_id
		and s1.plan_id < s2.plan_id
	where (s1.plan_id = 0 and s2.plan_id = 4)
		and s2.start_date = DATEADD(day, 7, s1.start_date) )

select COUNT(*) count_,
		round(COUNT(*) * 1.0 / (select COUNT(distinct customer_id) from subscriptions) * 100, 0) percentage_
from churned_cte
*/


-- What is the number and percentage of customer plans after their initial free trial?
/*
with plans_cte as (
	select s1.customer_id, s1.plan_id plan_0, s1.start_date start_date, s2.plan_id plans, s2.start_date end_date
	from subscriptions s1
	inner join subscriptions s2
		on s1.customer_id = s2.customer_id
		and s1.plan_id < s2.plan_id
	where (s1.plan_id = 0 and s2.plan_id <> 4)
		and s2.start_date = DATEADD(day, 7, s1.start_date) )

select plans, COUNT(*) count_, 
		round(COUNT(*) *1.0 / (select COUNT(distinct customer_id) from subscriptions) *100, 1) percentage_
from plans_cte
group by plans
order by plans
*/


-- What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
/*
with plans_cte as (
select *,
	LEAD(start_date) over(partition by customer_id order by start_date) end_date
from subscriptions )

select p.plan_name, COUNT(*) count_,
		ROUND(COUNT(*) *1.0 / (select COUNT(distinct customer_id) from subscriptions) *100, 1) percentage_
from plans_cte pc
inner join plans p
	on pc.plan_id = p.plan_id
where (end_date is null or start_date >= '2020-12-24')
	and start_date <= '2020-12-31'
group by p.plan_name
*/


-- How many customers have upgraded to an annual plan in 2020?
/*
select COUNT(distinct customer_id) count_
from subscriptions
where plan_id = 3 
	and YEAR(start_date) = '2020'
*/


-- How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
/*
with annual_cte as (
select *
from subscriptions
where plan_id in (0,3) ),

annual_start_cte as (
select *,
	LEAD(start_date) over(partition by customer_id order by start_date) start_to_annual
from annual_cte )

select avg(DATEDIFF(day, start_date, start_to_annual)) avg_day_to_annual_plan
from annual_start_cte
where start_to_annual is not null
*/


-- Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
/*
with annual_cte as (
select *
from subscriptions
where plan_id in (0,3) ),

annual_start_cte as (
select *,
	LEAD(start_date) over(partition by customer_id order by start_date) start_to_annual
from annual_cte ),

day_diff_cte as (
select *, DATEDIFF(day, start_date, start_to_annual) day_diff
from annual_start_cte
where start_to_annual is not null ),

periods_cte as (
select *,
	case when day_diff <= 30 then '0-30 days'
		 when day_diff <= 60 then '31-60 days'
		 when day_diff <= 120 then '91-120 days'
		 when day_diff <= 150 then '121-150 days'
		 when day_diff <= 180 then '151-180 days'
		 when day_diff <= 210 then '181-210 days'
		 when day_diff <= 240 then '211-240 days'
		 when day_diff <= 270 then '241-270 days'
		 when day_diff <= 300 then '271-300 days'
		 when day_diff <= 330 then '301-330 days'
		 when day_diff <= 360 then '331-360 days'
		 else 'more than 360 days' 
		 end periods_
from day_diff_cte )

select periods_, count(day_diff) count_
from periods_cte
group by periods_
order by 2 desc
*/


-- How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
/*
with next_plan_cte as (
select *, 
		LEAD(plan_id) over(partition by customer_id order by start_date) next_plan
from subscriptions )

select COUNT(*)
from next_plan_cte
where plan_id = 2 and next_plan = 1
	and YEAR(start_date) = '2020'
*/




























































