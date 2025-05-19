-- Author:Bassey Edet
-- Q2: Transaction Frequency Analysis
-- Categorize customes by average monthly transaction frequency


SELECT
      frequency_category,                                                      -- High, Medium, or Low frequency
      COUNT(*) AS customer_count,                                              -- Number of customers in each category
      ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month  -- Average across category
FROM (
    SELECT 
	  t.owner_id,
      ROUND(t.total_transactions/NULLIF(t.tenure_months, 0), 2) AS avg_transactions_per_month, -- Prevent divide-by-zero
CASE 
    WHEN (t.total_transactions/NULLIF(t.tenure_months, 0)) >= 10 THEN 'High Frequency' 
    WHEN (t.total_transactions/NULLIF(t.tenure_months, 0)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
END AS frequency_category
FROM (
   SELECT
      s.owner_id,
      COUNT(*) AS total_transactions,                                             -- Total number of savings transactions
      TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months             -- How long they've been a customer
FROM savings_savingsaccount s
JOIN users_customuser u
ON s.owner_id = u.id
GROUP BY s.owner_id
  ) t
) grouped
GROUP BY frequency_category;
