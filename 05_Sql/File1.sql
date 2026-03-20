-- (1) High Value Trips Only
-- Fetch trips where fare_amount > 500 and passenger_rating > 4
SELECT 
    trip_id, 
    city_id, 
    fare_amount, 
    passenger_rating 
FROM fact_trips 
WHERE fare_amount > 500 
  AND passenger_rating > 4;

-- (2) Cities with Frequent Repeat Passengers
-- Cities where total repeat passengers > 1000
SELECT 
    city_id, 
    SUM(repeat_passengers) AS total_repeats 
FROM fact_passenger_summary 
GROUP BY city_id
HAVING total_repeats > 1000;

-- (3) Monthly Business Volume
-- Total passengers per month
SELECT 
    month, 
    SUM(total_passengers) AS monthly_users 
FROM fact_passenger_summary 
GROUP BY month;

-- (4) Average Trip Distance for Repeated vs New
-- Compare average trip distance by passenger type
SELECT 
    passenger_type, 
    ROUND(AVG(distance_travelled_km),2) AS avg_dist 
FROM fact_trips 
GROUP BY passenger_type;

-- (5) Driver Performance Filter
-- Trips with low driver rating (<3) but high fare (>400)
SELECT 
    COUNT(trip_id) AS issue_trips 
FROM fact_trips 
WHERE driver_rating < 3 
  AND fare_amount > 400;
