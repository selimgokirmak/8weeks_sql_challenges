set dateformat dmy;

create view clean_weekly_sales as 
select convert(date, week_date) week_date, 
		DATEPART(ww, convert(date, week_date)) week_number, 
		MONTH(convert(date, week_date)) month_number,
		YEAR(convert(date, week_date)) calendar_year,

		region, PLATFORM, segment, 

		case when right(segment,1) = '1' then 'Young Adults'
			 when right(segment,1) = '2' then 'Middle Aged'
			 when right(segment,1) in ('3', '4') then 'Retirees'
			 else 'unknown' end age_band,

		case when LEFT(segment,1) = 'C' then 'Couples'
			 when LEFT(segment,1) = 'F' then 'Families'
			 else 'unknown' end demographic,
		customer_type, transactions, sales, 
		convert(dec(10,2), round(sales*1.0 / transactions, 2)) avg_transactions
from weekly_sales
