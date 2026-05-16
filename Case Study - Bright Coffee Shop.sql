--EXPLORATORY DATA ANALYSIS
--Show the full table

SELECT *
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Show the number of stores

SELECT DISTINCT Store_location
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Show the product categories

SELECT DISTINCT Product_Category
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP; 

--------------------------------------------------------------
--Show the product types

SELECT DISTINCT Product_type
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP; 

--------------------------------------------------------------
--Show the opening hour

SELECT MIN(Transaction_time) AS Opening_hour
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Determine the closing hour

SELECT MAX(Transaction_time) AS Opening_hour
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------

--Query for the main table

SELECT
    YEAR(Transaction_date) AS Year,
    MONTH(Transaction_date) AS Month_number,
    MONTHNAME(Transaction_date) AS Month_name,
    Store_Location,
    Product_Category,

    HOUR(Transaction_time) AS Hour_of_day,

    CASE 
        WHEN HOUR(Transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(Transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(Transaction_time) BETWEEN 17 AND 20 THEN 'Evening'
    END AS Time_bucket,

    COUNT(*) AS Total_transactions,
    SUM(Transaction_qty) AS Total_items_sold,
    SUM(Transaction_qty * Unit_Price) AS Total_revenue

FROM `workspace`.`default`.`bright_coffee_shop_sales_analysis`

GROUP BY
    YEAR(Transaction_date),
    MONTH(Transaction_date),
    MONTHNAME(Transaction_date),
    Store_Location,
    Product_Category,
    HOUR(Transaction_time),
    CASE 
        WHEN HOUR(Transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(Transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(Transaction_time) BETWEEN 17 AND 19 THEN 'Evening'
        ELSE 'Night'
    END

ORDER BY
    Month_number,
    Total_revenue DESC;
