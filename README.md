# Author: Bassey Edet

# DataAnalytics-Assessment – SQL Solutions

## Overview

This repository contains solutions to the SQL assessment from Cowrywise. It evaluates SQL proficiency in data aggregation, joins, subqueries, and business problem-solving using relational databases.

---

## Questions & Approach

### Q1: High-Value Customers with Multiple Products
- Identify customers who have both a savings and investment plan.
- Used `plans_plan` to count `is_regular_savings` and `is_a_fund` types.
- Joined two columns for name with `CONCAT`.
- Joined with `savings_savingsaccount` to get total deposits.
- Converted kobo to naira by dividing by 100.

### Q2: Transaction Frequency Analysis
- Calculated average transactions per customer per month.
- Categorized into high, medium, low based on frequency.
- Used `TIMESTAMPDIFF` and conditional logic via `CASE`.

### Q3: Account Inactivity Alert
- Pulled savings and investment plans from `plans_plan`.
- Filtered out those with no inflow in over 365 days using `DATEDIFF`.
- Used `last_charge_date` instead of `created_on` to because it gives more accurate picture of recent account activity.
- Used `next_charge_date` to exclude still-active billing accounts.

### Q4: Customer Lifetime Value (CLV)
- Calculated CLV using:
  ROUND(((COUNT(s.id)/NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * (0.001 * SUM(s.confirmed_amount)))/100, 2).
- Used `LEFT JOIN` to include customers with 0 transactions.

---

## Challenges
- Identified schema mismatches (`is_regular_savings` location was `plans_plan` not `saving_savingsaccount`).
- Adjusted logic after discovering the mismatches (calucated `total_deposits` using `confirmed_amount` from `saving_savingsaccount`)
- Used `CONCAT` to merge two name columns together.
- Adjusted logic after discovering `created_on` instead of `created_at`.
- Used `last_charge_date` instead of `created_on` to determine account recent activity.
- Carefully handled divide-by-zero cases with `NULLIF`.

---

## Submission
Please see individual `.sql` files for exact queries. Each query is self-contained and well-commented. Thank you.
