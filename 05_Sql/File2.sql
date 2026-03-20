-- (6) City Names with Total Trips
-- Shows total number of trips per city
SELECT 
    c.city_name, 
    COUNT(t.trip_id) AS total_trips
FROM fact_trips t
JOIN dim_city c ON t.city_id = c.city_id
GROUP BY c.city_name
ORDER BY total_trips DESC;

-- (7) Weekend vs Weekday Revenue
-- Compares total revenue earned on weekdays vs weekends
SELECT 
    d.day_type, 
    SUM(t.fare_amount) AS total_revenue
FROM fact_trips t
JOIN dim_date d ON t.date = d.date
GROUP BY d.day_type
ORDER BY total_revenue DESC;

-- (8) Monthly Repeat Rate (Customer Loyalty)
-- Calculates the percentage of repeat passengers for each month . Useful to track month-over-month customer retention trends
SELECT 
    month,
    ROUND(SUM(repeat_passengers) * 100.0 / SUM(total_passengers), 2) AS overall_repeat_pct
FROM fact_passenger_summary
GROUP BY month
ORDER BY month;

-- (9) High-Growth Targets
-- Identify cities and months where target trips > 10,000 , Highlights priority markets for business expansion
SELECT 
    city_id, 
    month, 
    total_target_trips
FROM targets_db.monthly_target_trips
WHERE total_target_trips > 10000
ORDER BY total_target_trips DESC;

-- (10) Target vs Actual New Passengers
-- Shows performance gap by comparing actual new passengers with monthly targets
SELECT 
    s.city_id, 
    s.month, 
    s.new_passengers AS actual, 
    t.target_new_passengers AS target,
    (s.new_passengers - t.target_new_passengers) AS performance_gap
FROM fact_passenger_summary s
JOIN targets_db.monthly_target_new_passengers t 
    ON s.city_id = t.city_id 
   AND s.month = t.month;
