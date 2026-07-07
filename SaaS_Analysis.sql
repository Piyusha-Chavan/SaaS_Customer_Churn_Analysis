use SaaS_Project;

--Query 1
--How many customers do we currently have?
SELECT COUNT(*) AS Total_customers
FROM subscriptions;


--Query 2
--How many customers have churned?
SELECT COUNT(*) AS Total_active_customers
from Subscriptions
WHERE churned=1;



--Query 3
--What percentage of customers have churned?
SELECT CAST(ROUND(COUNT(CASE WHEN churned = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS DECIMAL(10,2))AS Churn_Percentage
FROM Subscriptions;


-
--Query 4
--How many active customers do we still have?
SELECT count(*) AS Total_active_customers
FROM  Subscriptions
WHERE churned=0;



--Query 5
--What is the distribution of customers across subscription plans?
SELECT [plan],
COUNT(*) AS Customers
FROM subscriptions
GROUP BY [plan]
ORDER BY Customers DESC;



--Query 6
--Which industries have the highest number of customers?
SELECT industry, COUNT(*) AS Highest_Customers
FROM Subscriptions
GROUP BY industry
ORDER BY Highest_Customers DESC;



--Query 7
--Which regions contribute the largest customer base?
SELECT region, COUNT(*) AS Total_customers
FROM Subscriptions
GROUP BY region
ORDER BY Total_customers DESC;



--Query 8
--What is the distribution of customers by company size?
SELECT company_size, COUNT(*) AS Customers
FROM Subscriptions
GROUP BY company_size
ORDER BY Customers DESC;  



--Query 9
--What is the average revenue generated per customer?
SELECT AVG(monthly_revenue) AS AVG_Revenue
FROM Subscriptions;



--Query 10
--Which customer contributes the highest monthly revenue?
SELECT TOP 1 customer_id,monthly_revenue
FROM Subscriptions
ORDER BY monthly_revenue DESC;



--Query 11
--List the top 10 highest-paying customers.
SELECT TOP 10 customer_id, monthly_revenue
FROM subscriptions
ORDER BY monthly_revenue DESC;



--Query 12
--Which subscription plan generates the most revenue?
SELECT [plan], SUM(monthly_revenue) AS Revenue
FROM Subscriptions
GROUP BY [plan]
ORDER BY Revenue DESC;


--Query 13
--Which industry contributes the highest revenue?
SELECT industry, SUM(monthly_revenue) AS Revenue
FROM Subscriptions
GROUP BY industry
ORDER BY Revenue DESC;


--Query 14
--Which region generates the highest revenue?
SELECT region, SUM(monthly_revenue) AS Revenue
FROM Subscriptions
GROUP BY region
ORDER BY Revenue DESC;


--Query 15
--Which subscription plan has the highest number of churned customers?
SELECT [plan],COUNT(*) AS Churned_customers
FROM Subscriptions
WHERE Churned=1
GROUP BY [plan]
ORDER BY Churned_customers DESC;


--Query 16
--. Which industry experiences the highest churn?
SELECT industry ,COUNT(*) AS Highest_churned
FROM Subscriptions
WHERE churned=1
GROUP BY industry
ORDER BY Highest_churned DESC; 



--Query 17
--Which company size has the highest churn?
SELECT company_size ,COUNT(*) AS Highest_churned
FROM Subscriptions
WHERE churned=1
GROUP BY company_size
ORDER BY Highest_churned DESC; 


--Query 18
--What are the top reasons customers leave our platform?
SELECT churn_reason,COUNT(*) AS Total
FROM Subscriptions
WHERE churned=1
GROUP BY churn_reason
ORDER BY Total DESC;


--Query 19
--Which acquisition channel brings customers who churn the most?
SELECT acquisition_channel,COUNT(*) AS Churned_customers
FROM Subscriptions
WHERE churned=1
GROUP BY acquisition_channel
ORDER BY Churned_customers DESC;


--Query 20
--Find customers who churned after signing up.
SELECT customer_id, signup_date,churn_date
FROM Subscriptions
WHERE churned=1;


--Query 21
--Which customers have the lowest NPS scores?
SELECT customer_id, nps_score
FROM Subscriptions
ORDER BY nps_score ASC;


--Query 22
--Is there a relationship between feature usage and churn?
SELECT churned, AVG(feature_usage_pct) AS Avg_Feature_Usage
FROM Subscriptions
GROUP BY churned;


--Query 23
--Which customers created the most support tickets?
SELECT top 10 customer_id, support_tickets_12mo
FROM subscriptions
ORDER BY support_tickets_12mo DESC;


--Query 24
--Which customers have very low feature usage (<20%)?
SELECT customer_id, feature_usage_pct
FROM Subscriptions
WHERE feature_usage_pct < 20
ORDER BY feature_usage_pct ASC;


--Query 25
--How many customers upgraded their subscription?
SELECT COUNT(*) AS upgraded_customers
FROM Subscriptions
WHERE upgraded=1;



--Query 26
--Which plans receive the highest number of upgrades?
SELECT [plan],COUNT(*) AS Upgrades
FROM Subscriptions
WHERE upgraded = 1
GROUP BY [plan]
ORDER BY Upgrades DESC;


--Query 27
--Which month recorded the highest MRR?
SELECT  top 1 month,total_mrr
FROM monthly_revenue
ORDER BY total_mrr DESC;


--Query 28
--Which month recorded the lowest MRR?
SELECT  top 1 month,total_mrr
FROM monthly_revenue
ORDER BY total_mrr ASC;



--Query 29
--Find the top 5 customers with the highest monthly revenue. Display their customer ID,
--plan, industry, and revenue.
SELECT TOP 5 customer_id, [plan] , industry, monthly_revenue
FROM Subscriptions
ORDER BY monthly_revenue DESC;


--Query 31 
--Rank all customers based on their monthly revenue. 
--If two customers have the same revenue, they should receive the same rank.
SELECT customer_id,monthly_revenue,
RANK() OVER( ORDER BY monthly_revenue DESC)AS revenue_rank
FROM Subscriptions;



--Query 32
--Find customers who meet all of these conditions:
--Feature usage < 30% , NPS score < 5, Support tickets > 8, Not churned yet
SELECT customer_id, feature_usage_pct, nps_score , support_tickets_12mo ,  churned
FROM Subscriptions
WHERE feature_usage_pct <30 AND nps_score<5 AND support_tickets_12mo > 8 AND churned=0;



--Query 33
--Monthly Net Growth
SELECT month,new_customers, churned_customers,
CAST(new_customers AS INT )- CAST(churned_customers AS INT) AS Net_growth
FROM monthly_revenue;


--Query 34
--Which acquisition channel generates the highest average monthly revenue per customer?
SELECT acquisition_channel, AVG(monthly_revenue) AS Average
FROM Subscriptions
GROUP BY acquisition_channel
ORDER BY Average DESC ;



--Query 35
--Which subscription plans have: Average NPS below 6
--AND average feature usage below 50%
SELECT [plan], AVG(nps_score) AS AVG_nps, AVG(feature_usage_pct) AS AVG_pct
FROM Subscriptions
GROUP BY [plan]
HAVING AVG(nps_score) < 6 AND AVG(feature_usage_pct) <50;


--Query 36
--Find the region that satisfies both:  Highest average revenue, Lowest churn rate
SELECT region, AVG(monthly_revenue) AS Avg_revenue,
AVG(CAST( churned AS FLOAT))* 100.0  AS churn_rate
FROM Subscriptions
GROUP BY region
ORDER BY Avg_revenue DESC, churn_rate ASC;


