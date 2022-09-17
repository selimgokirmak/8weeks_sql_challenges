-- How many unique nodes are there on the Data Bank system?
/*
select COUNT(distinct node_id) count_
from customer_nodes
*/


-- What is the number of nodes per region?
/*
select region_name, COUNT(distinct node_id) count_
from customer_nodes cn
join regions r
	on cn.region_id = r.region_id
group by region_name
*/


-- How many customers are allocated to each region?
/*
select region_name, COUNT(distinct customer_id) count_
from customer_nodes cn
join regions r
	on cn.region_id = r.region_id
group by region_name
*/


-- How many days on average are customers reallocated to a different node?
/*
select avg(DATEDIFF(day, start_date, end_date)) avg_date
from customer_nodes
where end_date <> '9999-12-31'
*/


-- What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
/*
with dates_cte as (
select region_name, DATEDIFF(day, start_date, end_date) date_
from customer_nodes cn
inner join regions r
	on cn.region_id = r.region_id
where year(end_date) = '2020' )

select distinct region_name, 
		percentile_disc(.5) within group (order by date_) over(partition by region_name) median,
		percentile_disc(.8) within group (order by date_) over(partition by region_name) percentile_80,
		percentile_disc(.95) within group (order by date_) over(partition by region_name) percentile_95
from dates_cte
*/
