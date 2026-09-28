```sql
-- =========================================================
-- BANKING RISK ANALYSIS
-- Database: banking_risk_automation
-- Table: banking_customers
-- =========================================================


-- 1. Total Customers
SELECT COUNT(*) AS total_customers
FROM banking_customers;


-- 2. Risk Level Distribution
SELECT
    risklevel,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY risklevel
ORDER BY customer_count DESC;


-- 3. Customers by Geography
SELECT
    geography,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY geography
ORDER BY customer_count DESC;


-- 4. High Risk Customers by Geography
SELECT
    geography,
    COUNT(*) AS high_risk_customers
FROM banking_customers
WHERE risklevel = 'High Risk'
GROUP BY geography
ORDER BY high_risk_customers DESC;


-- 5. High Risk Percentage
SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM banking_customers),
        2
    ) AS high_risk_percentage
FROM banking_customers
WHERE risklevel = 'High Risk';


-- 6. Average Balance of High Risk Customers
SELECT
    ROUND(AVG(balance), 2) AS avg_balance_high_risk
FROM banking_customers
WHERE risklevel = 'High Risk';


-- 7. Risk Level vs Average Balance
SELECT
    risklevel,
    COUNT(*) AS customer_count,
    ROUND(AVG(balance), 2) AS avg_balance
FROM banking_customers
GROUP BY risklevel
ORDER BY avg_balance DESC;


-- 8. Action-wise Customer Distribution
SELECT
    action,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY action
ORDER BY customer_count DESC;


-- 9. Risk Level and Recommended Action
SELECT
    risklevel,
    action,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY risklevel, action
ORDER BY risklevel, customer_count DESC;


-- 10. High Risk Age Analysis
SELECT
    ROUND(AVG(age), 2) AS avg_age_high_risk,
    MIN(age) AS youngest_high_risk,
    MAX(age) AS oldest_high_risk
FROM banking_customers
WHERE risklevel = 'High Risk';


-- 11. High Risk Customers by Gender
SELECT
    gender,
    COUNT(*) AS high_risk_customers
FROM banking_customers
WHERE risklevel = 'High Risk'
GROUP BY gender
ORDER BY high_risk_customers DESC;


-- 12. High Risk Credit Score Analysis
SELECT
    ROUND(AVG(creditscore), 2) AS avg_credit_score,
    MIN(creditscore) AS min_credit_score,
    MAX(creditscore) AS max_credit_score
FROM banking_customers
WHERE risklevel = 'High Risk';


-- 13. High Risk Customers by Number of Products
SELECT
    numofproducts,
    COUNT(*) AS customer_count
FROM banking_customers
WHERE risklevel = 'High Risk'
GROUP BY numofproducts
ORDER BY numofproducts;


-- 14. High Risk Customers by Active Member Status
SELECT
    isactivemember,
    COUNT(*) AS customer_count
FROM banking_customers
WHERE risklevel = 'High Risk'
GROUP BY isactivemember
ORDER BY isactivemember;


-- 15. High Risk Customers by Exit Status
SELECT
    exited,
    COUNT(*) AS customer_count
FROM banking_customers
WHERE risklevel = 'High Risk'
GROUP BY exited
ORDER BY exited;


-- 16. High Risk Exit Rate
SELECT
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS high_risk_exit_rate
FROM banking_customers
WHERE risklevel = 'High Risk';


-- 17. Overall Exit Rate
SELECT
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS overall_exit_rate
FROM banking_customers;


-- 18. Exit Rate by Risk Level
SELECT
    risklevel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate
FROM banking_customers
GROUP BY risklevel
ORDER BY exit_rate DESC;


-- 19. Geography and Risk Level
SELECT
    geography,
    risklevel,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY geography, risklevel
ORDER BY geography, risklevel;


-- 20. Exit Rate by Geography
SELECT
    geography,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate
FROM banking_customers
GROUP BY geography
ORDER BY exit_rate DESC;


-- 21. Geography + Risk + Exit Rate
SELECT
    geography,
    risklevel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate
FROM banking_customers
GROUP BY geography, risklevel
ORDER BY geography, risklevel;


-- 22. Risk Level + Credit Score
SELECT
    risklevel,
    ROUND(AVG(creditscore), 2) AS avg_credit_score,
    MIN(creditscore) AS min_credit_score,
    MAX(creditscore) AS max_credit_score
FROM banking_customers
GROUP BY risklevel
ORDER BY avg_credit_score;


-- 23. Risk Level + Balance
SELECT
    risklevel,
    COUNT(*) AS customer_count,
    ROUND(AVG(balance), 2) AS avg_balance,
    ROUND(MIN(balance), 2) AS min_balance,
    ROUND(MAX(balance), 2) AS max_balance
FROM banking_customers
GROUP BY risklevel
ORDER BY avg_balance DESC;


-- 24. Risk Level + Active Member
SELECT
    risklevel,
    isactivemember,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY risklevel, isactivemember
ORDER BY risklevel, isactivemember;


-- 25. Risk Level + Number of Products
SELECT
    risklevel,
    numofproducts,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY risklevel, numofproducts
ORDER BY risklevel, numofproducts;


-- 26. Risk Level + Gender
SELECT
    risklevel,
    gender,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY risklevel, gender
ORDER BY risklevel, gender;


-- 27. Age Group + Risk Level
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    risklevel,
    COUNT(*) AS customer_count
FROM banking_customers
GROUP BY age_group, risklevel
ORDER BY age_group, risklevel;


-- 28. Age Group Exit Rate
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate
FROM banking_customers
GROUP BY age_group
ORDER BY exit_rate DESC;


-- 29. Age Group + Risk + Exit Rate
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    risklevel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate
FROM banking_customers
GROUP BY age_group, risklevel
ORDER BY age_group, risklevel;


-- 30. Final Risk + Exit + Geography Analysis
SELECT
    geography,
    risklevel,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) AS exited_customers,
    ROUND(
        SUM(CASE WHEN exited = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS exit_rate,
    ROUND(AVG(balance), 2) AS avg_balance
FROM banking_customers
GROUP BY geography, risklevel
ORDER BY exit_rate DESC;
```
