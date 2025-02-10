-- ====================================================
--   Customer Behavior Data Analysis and Cleanup Script
-- ====================================================

-- ====================
-- SECTION 1: DATA COPY
-- ====================

-- Select all data from the existing Amazon customer behavior table
SELECT * 
FROM amazon_customer_behavior;

-- Create a new table for customer behavior
CREATE TABLE customer_behavior LIKE amazon_customer_behavior;

-- Insert data from the existing amazon_customer_behavior table into the new customer_behavior table
INSERT INTO customer_behavior
SELECT *
FROM amazon_customer_behavior;

-- 
SELECT * 
FROM customer_behavior;


-- ==============================
-- SECTION 2: DATA VALIDATION
-- ==============================

-- ------------
-- GENDER CHECK
-- ------------
-- Check for invalid gender values (anything other than 'M', 'F', 'Male', 'Female')
SELECT DISTINCT Gender
FROM customer_behavior
WHERE Gender NOT IN ('M', 'F', 'Male', 'Female', 'male', 'female');

-- ------------
-- AGE VALIDATION
-- ------------
-- Check for unrealistic ages (negative or unreasonably high ages)
SELECT *
FROM customer_behavior
WHERE Age < 0 OR Age > 120;

-- ------------
-- PURCHASE FREQUENCY VALIDATION
-- ------------
-- Check for empty or null values in 'Purchase_Frequency'
SELECT *
FROM customer_behavior
WHERE Purchase_Frequency IS NULL OR Purchase_Frequency = '';


-- ===============================
-- SECTION 3: DATA CLEANUP AND STANDARDIZATION
-- ===============================

-- ---------
-- TIMESTAMP
-- ---------

-- Convert timestamp format (strip time and GMT offset)
UPDATE customer_behavior
SET timestamp = STR_TO_DATE(LEFT(timestamp, 19), '%Y/%m/%d %h:%i:%s');

-- hange timestamp to only include date
UPDATE customer_behavior
SET timestamp = DATE(timestamp);

-- Rename 'timestamp' column to 'date' for clarity
ALTER TABLE customer_behavior
CHANGE timestamp date DATE;

-- Drop 'ID' column
ALTER TABLE customer_behavior
DROP COLUMN ID;

-- ---------
-- GENDER
-- ---------

-- Standardize gender values: Replace 'M' and 'male' with 'Male'
UPDATE customer_behavior
SET Gender = 'Male'
WHERE Gender IN ('M', 'male');

-- Replace 'F' and 'female' with 'Female'
UPDATE customer_behavior
SET Gender = 'Female'
WHERE Gender IN ('F', 'female');

-- Standardize case format for 'Gender' and other columns with inconsistent capitalization
UPDATE customer_behavior
SET 
    Gender = CONCAT(UPPER(SUBSTRING(Gender, 1, 1)), LOWER(SUBSTRING(Gender, 2))),
    Purchase_Frequency = CONCAT(UPPER(SUBSTRING(Purchase_Frequency, 1, 1)), LOWER(SUBSTRING(Purchase_Frequency, 2))),
    Purchase_Categories = CONCAT(UPPER(SUBSTRING(Purchase_Categories, 1, 1)), LOWER(SUBSTRING(Purchase_Categories, 2))),
    Product_Search_Method = CONCAT(UPPER(SUBSTRING(Product_Search_Method, 1, 1)), LOWER(SUBSTRING(Product_Search_Method, 2))),
    Cart_Abandonment_Factors = CONCAT(UPPER(SUBSTRING(Cart_Abandonment_Factors, 1, 1)), LOWER(SUBSTRING(Cart_Abandonment_Factors, 2))),
    Improvement_Areas = CONCAT(UPPER(SUBSTRING(Improvement_Areas, 1, 1)), LOWER(SUBSTRING(Improvement_Areas, 2)));

-- -------------
-- TRIMMING DATA
-- -------------

-- Trim unnecessary spaces from key columns
UPDATE customer_behavior
SET Service_Appreciation = TRIM(Service_Appreciation),
    Purchase_Categories = TRIM(Purchase_Categories),
    Gender = TRIM(Gender),
    Cart_Abandonment_Factors = TRIM(Cart_Abandonment_Factors),
    Product_Search_Method = TRIM(Product_Search_Method),
    Improvement_Areas = TRIM(Improvement_Areas);

-- -----------------------------------------
-- DROPPING UNNECESSARY COLUMNS
-- -----------------------------------------

-- Drop  'Customer_Reviews_Importance' column
ALTER TABLE customer_behavior
DROP COLUMN Customer_Reviews_Importance;

-- Drop  'Rating_Accuracy' column
ALTER TABLE customer_behavior
DROP COLUMN Rating_Accuracy;


-- =================================
-- SECTION 4: CUSTOMER DEMOGRAPHICS
-- =================================

-- ------------------------------
-- Gender Distribution
-- ------------------------------
SELECT Gender, COUNT(*) AS Response_Count
FROM customer_behavior
GROUP BY Gender
ORDER BY Gender ASC;

-- ------------------------------
-- Age Grouping and Distribution
-- ------------------------------

-- Find the mean of the customers ages
SELECT AVG(age) AS Mean
FROM customer_behavior;


-- Group customer ages into relevant categories
WITH Age_Categories AS (
    SELECT 
        CASE
			WHEN Age <= 12 THEN 'Kid'
			WHEN Age BETWEEN 13 AND 17 THEN 'Teen'
            WHEN Age BETWEEN 18 AND 30 THEN 'Young Adults'
            WHEN Age BETWEEN 31 AND 50 THEN 'Middle-Aged Adults'
            WHEN Age >= 51 THEN 'Seniors'
        END AS Age_Group,
        COUNT(*) AS Response_Count
    FROM customer_behavior
    GROUP BY Age_Group
)
-- Display age group distribution
SELECT Age_Group, Response_Count
FROM Age_Categories
ORDER BY Response_Count DESC;


-- =========================================
-- SECTION 5: CUSTOMER PURCHASE BEHAVIOR
-- =========================================

-- ------------------------------
-- Popular Product Search Methods
-- ------------------------------
SELECT Product_Search_Method, COUNT(*) AS Usage_Count
FROM customer_behavior
WHERE Product_Search_Method IS NOT NULL 
    AND Product_Search_Method <> ''
GROUP BY Product_Search_Method
ORDER BY Usage_Count DESC;

-- Display which keyword takes one or multipy pages
SELECT Product_Search_Method, Search_Result_Exploration,
COUNT(*) as Results
FROM customer_behavior
WHERE Product_Search_Method IS NOT NULL 
    AND Product_Search_Method <> ''
GROUP BY Product_Search_Method, Search_Result_Exploration
ORDER BY Results DESC;



-- ------------------------------
-- Purchase Frequency Distribution
-- ------------------------------
SELECT Purchase_Frequency, COUNT(*) AS Customer_Count
FROM customer_behavior
GROUP BY Purchase_Frequency
ORDER BY Customer_Count DESC;

-- ------------------------------
-- Purchase Categories Breakdown
-- ------------------------------

-- Split categories stored in the 'Purchase_Categories' field (which are separated by ';')
WITH Split_Categories AS (
    SELECT
        TRIM(SUBSTRING_INDEX(Purchase_Categories, ';', 1)) AS Category
    FROM customer_behavior
    WHERE Purchase_Categories IS NOT NULL
    UNION ALL
    SELECT
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Categories, ';', 2), ';', -1))
    FROM customer_behavior
    WHERE Purchase_Categories LIKE '%;%'
    UNION ALL
    SELECT
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Purchase_Categories, ';', 3), ';', -1))
    FROM customer_behavior
    WHERE Purchase_Categories LIKE '%;%'
)
-- Display purchase category distribution
SELECT Category, COUNT(*) AS Category_Count
FROM Split_Categories
WHERE Category IS NOT NULL 
    AND Category <> ''
GROUP BY Category
ORDER BY Category_Count DESC;


-- =========================================
-- SECTION 6: CART ABANDONMENT ANALYSIS
-- =========================================

-- ------------------------------
-- Top Factors for Cart Abandonment
-- ------------------------------
SELECT Cart_Abandonment_Factors, COUNT(*) AS Factor_Count
FROM customer_behavior
GROUP BY Cart_Abandonment_Factors
ORDER BY Factor_Count DESC;


-- =========================================
-- SECTION 7: CUSTOMER FEEDBACK ANALYSIS
-- =========================================

-- ------------------------------
-- Top Suggested Areas for Improvement
-- ------------------------------

-- Clean up and group similar suggestions in 'Improvement_Areas'
SELECT
    CASE 
        -- Group common suggestions under a single label
        WHEN Improvement_Areas LIKE '%Customer service%' THEN 'Customer Service'
        WHEN Improvement_Areas LIKE '%shipping%' THEN 'Shipping'
        WHEN Improvement_Areas LIKE '%interface%' THEN 'User Interface'
        WHEN Improvement_Areas LIKE '%Ui%' THEN 'User Interface'
        WHEN Improvement_Areas LIKE '%product quality%' THEN 'Product Quality'
        WHEN Improvement_Areas LIKE '%suggestions%' THEN 'Product Suggestions'
        WHEN Improvement_Areas LIKE '%No problems with amazon%' THEN 'No Problems'
        WHEN Improvement_Areas LIKE '%any problem with amazon%' THEN 'No Problems'
        ELSE Improvement_Areas -- Retain the original value for other cases
    END AS Cleaned_Improvement_Areas,
    COUNT(*) AS Suggestion_Count
FROM customer_behavior
WHERE Improvement_Areas IS NOT NULL 
    AND TRIM(Improvement_Areas) <> ''
    AND TRIM(Improvement_Areas) <> '.'
    AND TRIM(Improvement_Areas) NOT IN ('Nothing', 'Nil', 'Ji') -- Exclude irrelevant entries
GROUP BY Cleaned_Improvement_Areas
ORDER BY Suggestion_Count DESC;

-- Display customer shopping satisfaction
SELECT Shopping_Satisfaction, Count(*) AS Satisfaction 
FROM customer_behavior
GROUP BY Shopping_Satisfaction
ORDER BY Satisfaction  DESC;

-- Display 
SELECT Recommendation_Helpfulness, Count(*) AS Helpful 
FROM customer_behavior
GROUP BY Recommendation_Helpfulness
ORDER BY Helpful  DESC;

-- ------------------------------
-- Top Appreciated Service Areas
-- ------------------------------

-- Standardize and analyze 'Service_Appreciation' feedback
SELECT Service_Appreciation, COUNT(*) AS appreciation_count
FROM customer_behavior
WHERE Service_Appreciation IS NOT NULL 
  AND Service_Appreciation <> ''
  AND Service_Appreciation <> '.'
GROUP BY Service_Appreciation
ORDER BY appreciation_count DESC;

-- =========================================
-- SECTION 8: Review Analysis
-- =========================================

-- ### Reviews Analysis Section ###

-- Percentage of Customers Who Left Reviews
SELECT Review_Left, 
COUNT(*) AS Count, 
(COUNT(*) / (SELECT COUNT(*) FROM customer_behavior)) * 100 AS Percentage
FROM customer_behavior
GROUP BY Review_Left;


-- Review Reliability Distribution
SELECT Review_Reliability, 
COUNT(*) AS Reliability_Count
FROM customer_behavior
GROUP BY Review_Reliability
ORDER BY Reliability_Count DESC;


-- Review Helpfulness Distribution
SELECT Review_Helpfulness, 
COUNT(*) AS Helpfulness_Count
FROM customer_behavior
GROUP BY Review_Helpfulness
ORDER BY Helpfulness_Count DESC;


-- Cross Analysis: Review Reliability vs Review Helpfulness
SELECT Review_Reliability, Review_Helpfulness, 
COUNT(*) AS Count
FROM customer_behavior
GROUP BY Review_Reliability, Review_Helpfulness
ORDER BY Count DESC;


-- Customers Who Found Reviews Helpful and Their Perception of Reliability
SELECT 
    Review_Helpfulness, 
    Review_Reliability, 
    COUNT(*) AS Count
FROM customer_behavior
WHERE Review_Helpfulness = 'Yes'
GROUP BY Review_Helpfulness, Review_Reliability
ORDER BY Count DESC;




