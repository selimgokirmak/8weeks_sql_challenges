-- set dateformat dmy;

-- What day of the week is used for each week_date value?
/*
SELECT 
  DISTINCT(datename(weekday, week_date)) AS week_day 
FROM clean_weekly_sales;
*/


-- What range of week numbers are missing from the dataset?
/*
select distinct week_number
from clean_weekly_sales
order by week_number

-- 1-12 and 36-52 ranges are missing.
*/


-- How many total transactions were there for each year in the dataset?
/*
select calendar_year, SUM(transactions) total_transactions
from clean_weekly_sales
group by calendar_year
order by calendar_year
*/


-- What is the total sales for each region for each month?
/*
select region, month_number, SUM(cast(sales as bigint)) total_sales
from clean_weekly_sales
group by region, month_number
order by region, month_number
*/


-- What is the total count of transactions for each platform?
/*
select PLATFORM, SUM(transactions) total_transactions
from clean_weekly_sales
group by PLATFORM
*/


-- What is the percentage of sales for Retail vs Shopify for each month?
/*
select month_number, PLATFORM, 
	convert(dec(10,2), round(SUM(cast(sales as bigint))*1.0/(select SUM(cast(sales as bigint)) from clean_weekly_sales where month_number = cws.month_number)*100, 2)) sales_percentage
from clean_weekly_sales cws
group by month_number, PLATFORM
order by 1,2
*/


-- What is the percentage of sales by demographic for each year in the dataset?
/*
select calendar_year, demographic, 
	convert(dec(10,2), round(SUM(cast(sales as bigint))*1.0/(select SUM(cast(sales as bigint)) from clean_weekly_sales where calendar_year = cws.calendar_year)*100, 2)) sales_percentage
from clean_weekly_sales cws
group by calendar_year, demographic
order by 1,2
*/


-- Which age_band and demographic values contribute the most to Retail sales?
/*
select age_band, demographic, SUM(cast(sales as bigint)) total_sales
from clean_weekly_sales
where PLATFORM = 'Retail'
group by age_band, demographic
order by 3 desc
*/


-- Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? 
-- If not - how would you calculate it instead?
/*
select calendar_year, PLATFORM,
		convert(dec(10,2), AVG(avg_transactions)) avg_transactions_1,
		convert(dec(10,2), SUM(cast(sales as bigint))*1.0 / sum(transactions)) avg_transactions_2
from clean_weekly_sales
group by calendar_year, PLATFORM
order by 1,2
*/

