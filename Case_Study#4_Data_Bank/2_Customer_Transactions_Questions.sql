-- What is the unique count and total amount for each transaction type?
/*
select txn_type, COUNT(*) count_, SUM(txn_amount) total_amount
from customer_transactions
group by txn_type
*/


-- What is the average total historical deposit counts and amounts for all customers?
/*
?????????
*/


-- For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
/*
with deposit_cte as (
select *, MONTH(txn_date) month_
from customer_transactions ),

expanded_cte as (
select customer_id, month_,
		case when txn_type = 'deposit' then 1 else 0 end deposit,
		case when txn_type = 'purchase' then 1 else 0 end purchase,
		case when txn_type = 'withdrawal' then 1 else 0 end withdrawal
from deposit_cte ),

last_cte as (
select customer_id, month_, SUM(deposit) deposit, SUM(purchase) purchase, SUM(withdrawal) withdrawal
from expanded_cte
group by customer_id, month_
having SUM(deposit) > 1
	and ( (SUM(purchase) = 1 and SUM(withdrawal) = 0) or (SUM(purchase) = 0 and SUM(withdrawal) = 1) ) )

select month_, COUNT(*) count_
from last_cte
group by month_
*/


-- What is the closing balance for each customer at the end of the month?
/*
with balance_cte as (
select *, MONTH(txn_date) month_,
		case when txn_type = 'deposit' then txn_amount
			 else txn_amount*-1
			 end balance
from customer_transactions ),

sum_balance_cte as (
select distinct customer_id, month_,
		SUM(balance) over(partition by customer_id, month_ order by month_) sum_
from balance_cte )

select customer_id, month_, 
		SUM(sum_) over(partition by customer_id order by month_ rows between unbounded preceding and current row) monthly_balance
from sum_balance_cte
*/


-- What is the percentage of customers who increase their closing balance by more than 5%?

