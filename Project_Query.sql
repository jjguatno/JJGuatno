WITH cte AS (
    SELECT dteday, weekday, yr, hr, buyer_type, product_type, buyers, Location
    FROM [Project_year_1]
    UNION ALL
    SELECT dteday, weekday, yr, hr, buyer_type, product_type, buyers, Location
    FROM [Project_year_2]
)
SELECT 
    CASE
        WHEN weekday = 0 THEN 'Monday'
        WHEN weekday = 1 THEN 'Tuesday'
        WHEN weekday = 2 THEN 'Wednesday'
        WHEN weekday = 3 THEN 'Thursday'
        WHEN weekday = 4 THEN 'Friday'
        WHEN weekday = 5 THEN 'Saturday'
        WHEN weekday = 6 THEN 'Sunday'
    END AS DayName,
    CASE    
        WHEN yr = 0 THEN '2021'
        WHEN yr = 1 THEN '2022'
    END AS YrFormatted,
    CASE
        WHEN hr = 0 THEN '12 AM'
        WHEN hr < 12 THEN CONCAT(hr, ' AM')
        WHEN hr = 12 THEN '12 PM'
        WHEN hr > 12 THEN CONCAT(hr - 12, ' PM')
    END AS HrFormatted,
    hr,
    weekday,
    dteday,
    buyer_type,
    a.product_type,
    buyers,
    a.Location,
    ROUND(a.buyers * b.price, 2) AS revenue,
    ROUND(a.buyers * b.price - b.COGS * a.buyers - c.Rent - c.Utilities, 2) AS profit
FROM 
    cte a
LEFT JOIN 
    Project_cost_table_1 b ON a.product_type = b.product_type
LEFT JOIN
    Project_cost_table_2 c ON a.Location = c.Location;


