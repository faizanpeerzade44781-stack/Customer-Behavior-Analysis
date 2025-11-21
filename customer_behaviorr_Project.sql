create database customer_behaviorr ;
 


 select top 10 * from customer_behavior

exec sp_help customer_behavior

-- 1 What is the Total Revenue genrate By Male And female 

select gender , sum(purchase_amount) as Total_Revenue 
from customer_behavior 
group by gender ;

 

-- Convert Total Revenue In Millions 
select gender , concat(cast(sum(purchase_amount)/1000000.0 as decimal(10,0)),+''+'M') as Total_Revenue_Million  
from customer_behavior 
group by gender

-- 2 which customer Used a discount But Still Spent More than the Average Purchase Amount 

select customer_id , discount_applied ,purchase_amount
from customer_behavior
where discount_applied = 'Yes' and purchase_amount>= (select avg(purchase_amount) from customer_behavior)
 
 -- 3 which are the top 5 product with  highestt average revie rating 

 select top 5 item_purchased ,   cast(avg(review_rating) as decimal(10,2)) as avg_review
 from customer_behavior 
 group by item_purchased
 order by avg_review desc
 
 -- 4   Compare the average Purchase Amounts between Standard and Express Shipping.

 select shipping_type , avg(purchase_amount) as avg_amount  
 from customer_behavior
where shipping_type in ('Standard' , 'Express')
group by shipping_type ;

----------------------------------------------------------------------------------
-- Diffrence amount between  Standard_Avg, Express_Avg,
    

SELECT
    Standard_Avg,
    Express_Avg,
    Express_Avg - Standard_Avg AS Difference_Amount
FROM (
    SELECT 
        AVG(CASE WHEN shipping_type = 'Standard' THEN purchase_amount END) AS Standard_Avg,
        AVG(CASE WHEN shipping_type = 'Express' THEN purchase_amount END) AS Express_Avg
    FROM customer_behavior
) AS t;


----Q5. Do subscribed customers spend more? Compare average spend and total revenue between
--subscribers and non-subscribers.

select   subscription_status  ,  avg(purchase_amount) avg_amount , sum(purchase_amount) total_revenue
from customer_behavior
group by subscription_status

--Q6. Which 5 products have the highest percentage of purchases with discounts applied?
select top 5 item_purchased ,  count(*)as Total_purchase,
sum( case when discount_applied = 'Yes' then 1 else 0 end) as discount_Purchase ,
CAST(SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) 
                                               AS DECIMAL(10,2)) AS discount_percentage
from  customer_behavior
group by item_purchased 
order by discount_Percentage desc


 
--Q7. Segment customers into New, Returning, and Loyal based on their total number of
--previous purchases, and show the count of each segment.

with Segment_customers as (

 select customer_id , previous_purchases,
case 
    when previous_purchases = 1 then 'New'
	when previous_purchases between  5 and 15 then 'Returning'
	else 'Loyal'
	end as Segment_cust
 from customer_behavior 
 
)
select Segment_cust , count(*) as Total_Customers 
from Segment_customers
group by Segment_cust

 --Q8. What are the top 3 most purchased products within each category?

with top_3_Most_Purchase_Within_Catogory as ( 

select item_purchased , category , sum(purchase_amount) as total_Purchase_amount , 
row_Number () over (partition by category order  by sum(purchase_amount) desc ) as rn 

from customer_behavior
group by item_purchased , category

)  

select item_purchased , category ,total_Purchase_amount
from top_3_Most_Purchase_Within_Catogory
where rn <4
order by  category , total_Purchase_amount  desc


----Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?

  
WITH customer_who_are_repeat_buyers AS (
    SELECT 
        customer_id,
        subscription_status,
        COUNT(*) AS total_purchases,
        CASE
            WHEN COUNT(*) > 5 THEN 'Repeat_Buyer'
            ELSE 'Not_Repeat_Buyer'
        END AS customer_
    FROM customer_behavior
    GROUP BY customer_id, subscription_status
)

SELECT 
    customer_,
    subscription_status,
    total_purchases
FROM customer_who_are_repeat_buyers
ORDER BY total_purchases DESC;


--Q10. What is the revenue contribution of each age group?

select age_group , sum(purchase_amount) as Total_Revenue 
from customer_behavior 
group by age_group
order by Total_Revenue desc



--Revenue Contribution % by Each Age Group

with percentage_revenue_by_each_Group as ( 

select age_group , sum(purchase_amount) as Total_Revenue  
from customer_behavior 
group by age_group

)

select age_group , Total_Revenue , 
concat(cast(cast(Total_Revenue * 100.0 / 
  (SELECT SUM(Total_Revenue) FROM percentage_revenue_by_each_Group)
        AS DECIMAL(10,2)) as varchar(20)),'%' ) as revenu_Percentage

from percentage_revenue_by_each_Group
order by Total_Revenue desc

  select top 10* from customer_behavior