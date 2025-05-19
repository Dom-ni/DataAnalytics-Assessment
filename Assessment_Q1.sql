-- Author: Bassey Edet
-- Q1: High-Value Customers with Multiple Products
-- Find Customers who have both a funded savings plan and investment plan
     

SELECT
      u.id AS owner_id,
      CONCAT(u.first_name,' ', u.last_name) AS name,              -- Add customer name
      s.savings_count,
      i.investment_count,
      ROUND(IFNULL(d.total_deposits, 0)/100, 2) AS total_deposits -- Convert kobo to naira
FROM users_customuser u
JOIN (
  SELECT                                                          -- Find Customers who have a savings account with money
      owner_id,
      COUNT(*) AS savings_count
FROM plans_plan
WHERE is_regular_savings = 1
AND amount > 0
GROUP BY owner_id
) s 
ON u.id = s.owner_id
JOIN (
  SELECT                                                           -- Find Customers who have investment plans with money
      owner_id,
      COUNT(*) AS investment_count
FROM plans_plan
WHERE is_a_fund = 1
AND amount > 0
GROUP BY owner_id
) i 
ON u.id = i.owner_id
LEFT JOIN (                                                        -- Get total deposits from savings_savingsaccount
   SELECT 
       owner_id,
       SUM(confirmed_amount) AS total_deposits
FROM savings_savingsaccount
GROUP BY owner_id
) d
ON u.id = d.owner_id
ORDER BY total_deposits DESC;
    
      
      
      
    
