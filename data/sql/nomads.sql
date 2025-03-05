-- Checking the top 10 city with Wework locations
SELECT city, country, COUNT(*) AS wework_count
FROM wework_loc
GROUP BY city, country
ORDER BY wework_count DESC
LIMIT 10;


-- Merging nomads, cost_of_living, quality_of_life, internet, wework_loc tables
SELECT 
	n.rank,
    -- n.country_code, 
    n.country,
    q.safety_category, 
    q.quality_of_life_category, 
    q.cost_of_living_category, 
    avg_cost.monthly_rent_euro, 
    avg_cost.meal_euro, 
    avg_cost.coffee_euro, 
    avg_cost.monthly_pass_euro, 
    ROUND(i.broadband, 0) AS internet_mbps, 
    COUNT(w.id) AS total_wework_count
FROM nomads n
JOIN quality_of_life q ON n.country_code = q.country_code
JOIN (
    -- Aggregate cost of living values at the country level and round values inside the subquery
    -- Rank base on nomads.com suggestion
    SELECT country_code, 
           ROUND(AVG(monthly_rent), 0) AS monthly_rent_euro, 
           ROUND(AVG(meal), 0) AS meal_euro,
           ROUND(AVG(coffee), 0) AS coffee_euro,
           ROUND(AVG(monthly_pass), 0) AS monthly_pass_euro
    FROM cost_of_living
    GROUP BY country_code
) avg_cost ON n.country_code = avg_cost.country_code
JOIN internet_speed i ON n.country_code = i.country_code
LEFT JOIN wework_loc w ON n.country_code = w.country_code
GROUP BY n.rank, n.country, q.safety_category, q.quality_of_life_category, 
         q.cost_of_living_category, avg_cost.monthly_rent_euro, 
         avg_cost.meal_euro, avg_cost.coffee_euro, avg_cost.monthly_pass_euro,
         i.broadband
LIMIT 10;


-- Base on nomad.com users, find out the most popular city
SELECT 
	city,
    country, 
    SUM(day_travel) AS total_days,
    ROUND(AVG(day_travel),0) AS avg_days,
    COUNT(DISTINCT username) AS unique_users
FROM nomads.user_trips
GROUP BY city, country
ORDER BY COUNT(DISTINCT username) DESC;

-- Distinct count of users that have the trip records
SELECT COUNT(DISTINCT username) AS unique_users FROM nomads.user_trips;


-- Find Countries with High Demand but Low WeWork Presence
WITH country_counts AS (
    -- Calculate total users and WeWork locations per country
    SELECT 
        ut.country_code, 
        ut.country, 
        COUNT(DISTINCT ut.username) AS total_users,
        COUNT(DISTINCT wl.id) AS total_wework_locations
    FROM user_trips ut
    LEFT JOIN wework_loc wl 
        ON ut.country_code = wl.country_code
    GROUP BY ut.country_code, ut.country
    HAVING COUNT(DISTINCT ut.username) > 50  -- Remove countries with small total_users
), 
total_counts AS (
    -- Calculate the total sum across only the filtered countries
    SELECT 
        SUM(total_users) AS total_users_global,
        SUM(total_wework_locations) AS total_wework_global
    FROM country_counts
)

SELECT 
    cc.country_code, 
    cc.country, 
    cc.total_users,
    cc.total_wework_locations,
    ROUND((cc.total_users / tc.total_users_global) * 100, 2) AS users_ratio,
    ROUND((cc.total_wework_locations / NULLIF(tc.total_wework_global, 0)) * 100, 2) AS wework_loc_ratio
FROM country_counts cc
JOIN total_counts tc
ORDER BY cc.total_users DESC;
;












