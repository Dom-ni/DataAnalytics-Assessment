-- Author: Bassey Edet
-- Q4: Customer Lifetime Valvue Estimation
-- Estimate CLV based on tenure and transaction volume


SELECT
      u.id AS customer_id,
      CONCAT(u.first_name, ' ', u.last_name) AS tenure_months,
      TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,              -- How long they’ve had an account
      COUNT(s.id) AS total_transactions,                                            -- Number of savings transactions
      ROUND(((COUNT(s.id)/NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * (0.001 * SUM(s.confirmed_amount)))/100, 2) AS estimated_clv    -- Average profit per transaction = 0.1% of total value
FROM users_customuser u
LEFT JOIN savings_savingsaccount s
ON u.id = s.owner_id
GROUP BY u.id, u.first_name, u.last_name, u.date_joined
ORDER BY estimated_clv DESC;                                                        -- Rank customers by estimated value
