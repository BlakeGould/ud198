--Questions and answers from UD 198 SQL For Data Analysis

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--------------------------------------------------------------------------------- L1.16
SELECT
	occurred_at
    ,account_id
    ,channel
FROM web_events
LIMIT 15





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L1.19
    -- Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
        SELECT
	        id
            ,occurred_at
            ,total_amt_usd
        FROM orders
        ORDER BY occurred_at
        LIMIT 10

    -- Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
        SELECT
	        id
            ,account_id
            ,total_amt_usd
        FROM orders
        ORDER BY total_amt_usd DESC
        LIMIT 5

    -- Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
        SELECT
	        id
            ,account_id
            ,total_amt_usd
        FROM orders
        ORDER BY total_amt_usd
        LIMIT 20





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L2.11
    -- Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
        SELECT
            primary_poc
            ,occurred_at
            ,channel
        FROM web_events w
        JOIN accounts a on w.account_id = a.id
        WHERE a.name = 'Walmart' 
    -- Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
        SELECT
            r.name
            ,s.name
            ,a.name
        FROM region r
        JOIN sales_reps s on r.id = s.region_id
        JOIN accounts a on s.id = a.sales_rep_id
        order by a.name

        -- their solution
        SELECT r.name region, s.name rep, a.name account
        FROM sales_reps s
        JOIN region r
        ON s.region_id = r.id
        JOIN accounts a
        ON a.sales_rep_id = s.id
        ORDER BY a.name;

    -- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
        SELECT
            r.name
            ,a.name
            ,o.total_amt_usd / (o.total + 0.01) Unit_Price
        FROM ORDERS O
        JOIN accounts a on o.account_id = a.id
        JOIN sales_reps s on a.sales_rep_id = s.id
        JOIN region r on s.region_id = r.id

        -- their solution
        SELECT r.name region, a.name account, 
        o.total_amt_usd/(o.total + 0.01) unit_price
        FROM region r
        JOIN sales_reps s
        ON s.region_id = r.id
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id;





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- l2.19 Questions
    -- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
    SELECT 
        r.name region_name
        ,s.name rep_name
        ,a.name account_name
    FROM region r
    JOIN sales_reps s ON r.id = s.region_id
    JOIN accounts a ON  s.id = a.sales_rep_id
    WHERE r.name = 'Midwest'

    -- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
    SELECT
    r.name region_name
    ,s.name rep_name
    ,a.name account_name
    FROM sales_reps s
    JOIN region r on s.region_id = r.id
    JOIN accounts a on s.id = a.sales_rep_id
    WHERE s.name LIKE 'S%'
    AND r.name = 'Midwest'

    -- Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
    SELECT
    r.name region_name
    ,s.name rep_name
    ,a.name account_name
    FROM sales_reps s
    JOIN region r on s.region_id = r.id
    JOIN accounts a on s.id = a.sales_rep_id
    WHERE s.name LIKE '% K%'
    AND r.name = 'Midwest'        

    -- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
    SELECT
    r.name region_name
    ,s.name rep_name
    ,(o.total_amt_usd / o.total) + .01 unit_price
    FROM sales_reps s
    JOIN region r on s.region_id = r.id
    JOIN accounts a on s.id = a.sales_rep_id
    JOIN orders o on a.id = o.account_id
    WHERE (o.standard_qty + o.poster_qty + o.gloss_qty) > 100

    -- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
    SELECT
        r.name region_name
        ,a.name account_name
        ,(o.total_amt_usd/(o.total+0.01)) unit_price
    FROM accounts a 
    JOIN orders o on a.id = o.account_id
    JOIN sales_reps s on a.sales_rep_id = s.id
    JOIN region r on s.region_id = r.id
    WHERE o.standard_qty > 100
    AND o.poster_qty > 50
    ORDER BY unit_price

    -- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
    SELECT
        r.name region_name
        ,a.name account_name
        ,(o.total_amt_usd/(o.total+0.01)) unit_price
    FROM accounts a 
    JOIN orders o on a.id = o.account_id
    JOIN sales_reps s on a.sales_rep_id = s.id
    JOIN region r on s.region_id = r.id
    WHERE o.standard_qty > 100
    AND o.poster_qty > 50
    ORDER BY unit_price desc

    -- What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
    SELECT DISTINCT
    a.name account_name
    ,w.channel channel
    FROM accounts a 
    JOIN web_events w on a.id = w.account_id AND a.id = 1001

    -- Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
    SELECT
        o.occurred_at
        ,o.total
        ,o.total_amt_usd
        ,a.name account_name
    FROM orders o 
    JOIN accounts a on o.account_id = a.id
    WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 3.7 Questions
-- Find the total amount of poster_qty paper ordered in the orders table.
    SELECT
        SUM (poster_qty) as posters_sum
    FROM orders

-- Find the total amount of standard_qty paper ordered in the orders table.
SELECT
        SUM (standard_qty) as standard_sum
    FROM orders
    
-- Find the total dollar amount of sales using the total_amt_usd in the orders table.
SELECT
    SUM (total_amt_usd) AS total_sales_usd
FROM orders

-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
SELECT
    id
    ,standard_amt_usd + gloss_amt_usd as total 
FROM orders

-- Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
SELECT 
    SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L3.11 Questions
-- When was the earliest order ever placed? You only need to return the date.
SELECT
    MIN(occurred_at)
FROM orders

-- Try performing the same query as in question 1 without using an aggregation function.
SELECT
    occurred_at
FROM ORDERS
ORDER BY occurred_at 
LIMIT 1

-- When did the most recent (latest) web_event occur?
SELECT
    MAX(occurred_at)
FROM web_events

-- Try to perform the result of the previous query without using an aggregation function.
SELECT
    occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT
    AVG(standard_qty) mean_std_qty
    ,AVG(poster_qty) mean_poster_qty
    ,AVG(gloss_qty) mean_gloss_qty
    ,AVG(standard_amt_usd) mean_std_amt
    ,AVG(gloss_amt_usd) mean_gloss_amt
    ,AVG(poster_amt_usd) mean_poster_amt
FROM orders

-- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
-- Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. This is the average of 2483.16 and 2482.55. This gives the median of 2482.855. This obviously isn't an ideal way to compute. If we obtain new orders, we would have to change the limit. SQL didn't even calculate the median for us. The above used a SUBQUERY, but you could use any method to find the two necessary values, and then you just need the average of them.





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L 3.14 Questions
-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT 
    a.name
    ,o.occurred_at
FROM accounts a
JOIN orders o ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT
a.name
,SUM(o.total_amt_usd) total_sales_usd
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name

-- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
SELECT
w.occurred_at as date
,w.channel channel
,a.name
FROM web_events w
JOIN accounts a ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1

-- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
SELECT
channel
,count(id)
FROM web_events
GROUP BY channel

    -- their solution 
    SELECT w.channel, COUNT(*)
    FROM web_events w
    GROUP BY w.channel
-- Who was the primary contact associated with the earliest web_event?
SELECT 
a.primary_poc
FROM accounts a
JOIN web_events w on a.id = w.account_id
ORDER BY occurred_at
LIMIT 1

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT
a.name
,MIN(o.total_amt_usd) smallest_order
FROM accounts a 
JOIN ORDERS o ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
SELECT
r.name
,COUNT(s.id) as rep_count
FROM region r
JOIN sales_reps s on r.id = s.region_id
GROUP BY r.name
ORDER BY rep_count





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L 3.17 Questions 
-- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
SELECT
a.name
,AVG(o.standard_qty) standard_avg
,AVG(o.poster_qty) poster_avg
,AVG(o.gloss_qty) gloss_avg
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP BY a.name

-- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
SELECT
a.name
,AVG(o.standard_amt_usd) standard_avg_per_order
,AVG(o.poster_amt_usd) poster_avg_per_order
,AVG(o.gloss_amt_usd) gloss_avg_per_order
FROM accounts a
JOIN orders o on a.id = o.account_id
GROUP BY a.name

-- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT
    s.name
    ,w.channel
    ,COUNT(w.channel) channel_count
FROM sales_reps s
JOIN accounts a on s.id = a.sales_rep_id
JOIN web_events w on a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY channel_count DESC

-- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT
    r.name
    ,w.channel
    ,COUNT(w.*) event_count
FROM accounts a
JOIN web_events w ON a.id = w.account_id
JOIN sales_reps s ON s.id = a.sales_rep_id
JOIN region r ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY event_count DESC





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L 3.20 Questions
-- Use DISTINCT to test if there are any accounts associated with more than one region.
    -- The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.

SELECT a.id as "account id", r.id as "region id", 
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

-- and

SELECT DISTINCT id, name
FROM accounts;

-- Have any sales reps worked on more than one account?
    -- Actually all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

-- and

SELECT DISTINCT id, name
FROM sales_reps;





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- L 3.23 Questions
-- Questions: HAVING
-- Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.
-- How many of the sales reps have more than 5 accounts that they manage?

    -- their way
    SELECT s.id, s.name, COUNT(*) num_accounts
    FROM accounts a
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    GROUP BY s.id, s.name
    HAVING COUNT(*) > 5
    ORDER BY num_accounts;

-- How many accounts have more than 20 orders?
SELECT
    a.id
    ,COUNT(*)
FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.id
HAVING COUNT(*) >20

-- Which account has the most orders?
SELECT
    a.id
    ,COUNT(*) order_count
FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.id
ORDER BY order_count DESC
limit 1

-- Which accounts spent more than 30,000 usd total across all orders?
SELECT
    a.id
    ,SUM(o.total_amt_usd) usd_total
FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.id
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY usd_total

-- Which accounts spent less than 1,000 usd total across all orders?
SELECT
    a.id
    ,SUM(o.total_amt_usd) usd_total
FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.id
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY usd_total

-- Which account has spent the most with us?
SELECT
    a.id
    ,a.name
    ,SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1

-- Which account has spent the least with us?
SELECT 
    a.id
    ,a.name
    ,SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT
    a.id
    ,COUNT(*) facebook_events
FROM web_events w
JOIN accounts a on w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY a.id
HAVING COUNT(*) > 6
ORDER BY facebook_events DESC

    -- their solution
    SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.id, a.name, w.channel
    HAVING COUNT(*) > 6 AND w.channel = 'facebook'
    ORDER BY use_of_channel;

-- Which account used facebook most as a channel?
SELECT
a.id
,COUNT(*) facebook_events
FROM web_events w
JOIN accounts a on w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY a.id
ORDER BY facebook_events DESC
LIMIT 1

    --Their solution 
    SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    WHERE w.channel = 'facebook'
    GROUP BY a.id, a.name, w.channel
    ORDER BY use_of_channel DESC
    LIMIT 1;

-- Which channel was most frequently used by most accounts?
SELECT
a.id
,w.channel
,COUNT(*) channel_usage
FROM web_events w
JOIN accounts a on w.account_id = a.id
GROUP BY a.id, w.channel
ORDER BY channel_usage DESC
LIMIT 10

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
/*
L3.27 Questions
*/
-- 1) Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
    SELECT
	DATE_TRUNC('year',occurred_at)
    ,SUM(total_amt_usd)
    FROM ORDERS
    GROUP BY 1
    ORDER BY 2 DESC

    --their solution (still gives same output)
    SELECT DATE_PART('year', occurred_at) ord_year,  SUM(total_amt_usd) total_spent
    FROM orders
    GROUP BY 1
    ORDER BY 2 DESC;

-- 2) Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
    SELECT
	DATE_TRUNC('month',occurred_at)
    ,SUM(total_amt_usd)
    FROM ORDERS
    GROUP BY 1
    ORDER BY 2 DESC

    --their solution
    SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
    FROM orders
    WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
    GROUP BY 1
    ORDER BY 2 DESC; 

    /*
    Ah, okay, I see what they're doing now. They just mean month by name (December), not which actual month in the history of time (the December in 2016). 

    Yah, look at that--later they switch to "In which month of which year..."
    */

-- 3) Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
    SELECT
    DATE_PART('year',occurred_at)
    ,SUM(total_amt_usd)
    FROM ORDERS
    GROUP BY 1
    ORDER BY 2 DESC

-- 4) Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
    SELECT
    DATE_PART('month',occurred_at)
    ,COUNT(ID)
    FROM ORDERS
    GROUP BY 1
    ORDER BY 2 DESC

    --their answer
        SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
        FROM orders
        WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
        GROUP BY 1
        ORDER BY 2 DESC; 

-- 5) In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

    SELECT
	DATE_TRUNC('month', o.occurred_at) ord_month
    ,SUM(o.gloss_amt_usd) gloss_sales
    FROM orders o
    JOIN accounts a on o.account_id = a.id
    WHERE a.name = 'Walmart'
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1;


/*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
L3.31 Questions
*/
-- 1) Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
    SELECT
	account_id
    ,total_amt_usd
    ,CASE
    	WHEN total_amt_usd >= 3000 THEN 'Large'
    	WHEN total_amt_usd < 3000 THEN 'Small'
        END AS order_level
    FROM ORDERS  

    --their solution
    SELECT account_id, total_amt_usd,
    CASE WHEN total_amt_usd > 3000 THEN 'Large'
    ELSE 'Small' END AS order_level
    FROM orders;

-- 2) Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
    SELECT
    CASE
    	WHEN total >= 2000 THEN 'At least 2000'
    	WHEN total < 2000 AND total >= 1000 THEN 'Between 1000 and 2000'
        ELSE 'less than 1000'
        END AS number_of_orders
	,COUNT(*)
    FROM ORDERS
    GROUP BY number_of_orders

-- 3) We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
    SELECT
    A.name
    , SUM(o.total_amt_usd) AS lifetime_value
    ,CASE
        WHEN SUM(o.total_amt_usd) > 200000 THEN 'Gold'
        WHEN SUM(o.total_amt_usd) >100000 THEN 'Silver' 
        ELSE 'Bronze'
        END AS level
    FROM accounts a
    JOIN orders o on a.id = o.account_id
    GROUP BY a.name
    ORDER BY 2 DESC

-- 4) We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
    SELECT 
        a.name
        ,SUM(total_amt_usd) total_spent, 
        CASE 
            WHEN SUM(total_amt_usd) > 200000 THEN 'top'
            WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
            ELSE 'low' 
            END AS customer_level
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    WHERE occurred_at > '2015-12-31' 
    GROUP BY 1
    ORDER BY 2 DESC;

-- 5) We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
 
    SELECT
        s.name
        ,COUNT(*) order_count
        ,CASE
            WHEN COUNT(*) > 200 THEN 'Best'
            ELSE 'Not so much'
            END AS level
    FROM sales_reps s
    JOIN accounts a on s.id = a.sales_rep_id
    JOIN orders o on a.id = o.account_id
    GROUP BY s.name
    ORDER BY 2 DESC

-- 6) The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!

    SELECT
        s.name
        ,COUNT(*) total_orders
        ,SUM(o.total_amt_usd) total_spend
        ,CASE
            WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'Best'
            WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 200000 THEN 'meh'
            ELSE 'Not so much'
            END AS level
    FROM sales_reps s
    JOIN accounts a on s.id = a.sales_rep_id
    JOIN orders o on a.id = o.account_id
    GROUP BY s.name
    ORDER BY 3 DESC

    /*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
L4.3 Questions
*/
-- Using a subquery, find the average number of events for each day for each channel. 
    SELECT
        channel
        ,AVG(count)
    FROM 
        (
        SELECT 
            DATE_TRUNC('day',occurred_at) AS day
            ,channel
            ,COUNT(*)
        FROM web_events
        GROUP BY 1,2
        ) sub
    GROUP BY channel


/*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
L4.7 Questions
*/
SELECT
	AVG(standard_qty) as  avg_std
    ,AVG(gloss_qty) as avg_gloss
	,AVG(poster_qty) as avg_poster
    ,SUM(total_amt_usd) as sum_total_amt_usd
FROM ORDERS
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at))
	FROM orders)

/*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
L4.9 Questions
*/

-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT 
    sub3.sales_rep_name
    ,sub3.region_name
    ,sub3.total_sales
FROM
    (SELECT 
        region_name
        ,MAX(total_sales) total_amt
    FROM (
        SELECT 
            s.name sales_rep_name
            ,r.name region_name
            ,SUM(o.total_amt_usd) as total_sales
        FROM sales_reps s
        JOIN region r on s.region_id = r.id
        JOIN accounts a on s.id = a.sales_rep_id
        JOIN orders o on a.id = o.account_id
        GROUP BY 1,2
        ) sub1
    GROUP BY 1) sub2
JOIN
    (        SELECT 
            s.name sales_rep_name
            ,r.name region_name
            ,SUM(o.total_amt_usd) as total_sales
        FROM sales_reps s
        JOIN region r on s.region_id = r.id
        JOIN accounts a on s.id = a.sales_rep_id
        JOIN orders o on a.id = o.account_id
        GROUP BY 1,2) sub3
    ON sub2.region_name = sub3.region_name AND sub2.total_amt = sub3.total_sales

-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
    --Their solution
    SELECT r.name, COUNT(o.total) total_orders
    FROM sales_reps s
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY r.name
    HAVING SUM(o.total_amt_usd) = (
        SELECT MAX(total_amt)
        FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                JOIN accounts a
                ON a.sales_rep_id = s.id
                JOIN orders o
                ON o.account_id = a.id
                JOIN region r
                ON r.id = s.region_id
                GROUP BY r.name) sub);

-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
    --Thier solution
    SELECT COUNT(*)
    FROM (SELECT a.name
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1
        HAVING SUM(o.total) > (SELECT total 
                    FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                            FROM accounts a
                            JOIN orders o
                            ON o.account_id = a.id
                            GROUP BY 1
                            ORDER BY 2 DESC
                            LIMIT 1) inner_tab)
                ) counter_tab;

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
    --Their solution
    SELECT a.name, w.channel, COUNT(*)
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id AND a.id =  (SELECT id
                        FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                            FROM orders o
                            JOIN accounts a
                            ON a.id = o.account_id
                            GROUP BY a.id, a.name
                            ORDER BY 3 DESC
                            LIMIT 1) inner_table)
    GROUP BY 1, 2
    ORDER BY 3 DESC;

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
    --Their solution
    SELECT AVG(tot_spent)
    FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;

-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
    --Their solution
    SELECT AVG(avg_amt)
    FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                    FROM orders o)) temp_table;

/*
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
L4.13 Questions - USE SUBQUERIES
*/
-- 1 - Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH sub2 as(
    SELECT 
            s.name sales_rep_name
            ,r.name region_name
            ,SUM(o.total_amt_usd) as total_sales
        FROM sales_reps s
        JOIN region r on s.region_id = r.id
        JOIN accounts a on s.id = a.sales_rep_id
        JOIN orders o on a.id = o.account_id
        GROUP BY 1,2
),

sub3 as (
    SELECT 
        region_name as region_name
        ,MAX(total_sales) as total_sales
    FROM sub2
    GROUP BY 1
)

SELECT 
    sub2.sales_rep_name
    ,sub2.region_name
    ,sub2.total_sales
FROM sub2
JOIN sub3 ON sub2.region_name = sub3.region_name AND sub2.total_sales = sub3.total_sales

-- For the region with the largest sales total_amt_usd, how many total orders were placed?


-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.