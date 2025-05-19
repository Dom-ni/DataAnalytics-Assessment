-- Q3: Account Inactivity Alert
-- Identify active savings and investment plans with no inflow for over 1 year

-- First part: Inactive Savings Plans
SELECT 
      id AS plan_id,
      owner_id,
      'Savings' AS type,                                       -- Label the row as savings
      DATE(last_charge_date) AS last_transaction_date,
      DATEDIFF(CURDATE(), last_charge_date) AS inactivity_days       -- Days since last inflow
FROM plans_plan
WHERE is_regular_savings = 1                                         -- It’s a savings plan
AND last_charge_date IS NOT NULL                                 
AND DATEDIFF(CURDATE(), last_charge_date) > 365                      -- More than a year of inactivity

UNION ALL

-- Second part: Inactive Investment Plans
SELECT
      id AS plan_id,
      owner_id,
      'Investment' AS type,                                    -- Label the row as investment
      DATE(last_charge_date) AS last_transaction_date,
      DATEDIFF(CURDATE(), last_charge_date) AS inactivity_days
FROM plans_plan
WHERE is_a_fund = 1                                            -- It’s an investment plan
AND last_charge_date IS NOT NULL                               -- Best indicator of last inflow attempt
AND DATEDIFF(CURDATE(), last_charge_date) > 365
AND (next_charge_date IS NULL OR next_charge_date < CURDATE()); -- Useful for excluding still-active billing