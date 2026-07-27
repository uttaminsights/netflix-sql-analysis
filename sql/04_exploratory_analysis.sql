-- ==========================================================
-- Netflix SQL Analysis Project
-- File: 04_exploratory_data_analysis.sql
-- Description:
-- Exploratory Data Analysis (EDA) to understand content
-- distribution, trends, and business insights.
-- ==========================================================

USE netflix;

-- ==========================================================
-- Question 1: Distribution of Movies vs TV Shows
-- ==========================================================
-- Business Question:
-- How is Netflix's content distributed between Movies and TV Shows?
--
-- Objective:
-- Determine the number of Movies and TV Shows available in the
-- Netflix catalog to understand the overall content distribution.
--
-- SQL Concepts Used:
-- • COUNT()
-- • GROUP BY
-- ==========================================================

SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;

-- Expected Output:
-- +----------+--------------+
-- | type     | total_titles |
-- +----------+--------------+
-- | Movie    | 6131         |
-- | TV Show  | 2676         |
-- +----------+--------------+

-- Business Insight:
-- Movies account for approximately 70% of Netflix's content,
-- while TV Shows make up around 30%. This indicates that
-- Netflix's catalogue is primarily movie-focused.

-- ==========================================================
-- Question 2: Content Added to Netflix Each Year
-- ==========================================================
-- Business Question:
-- How many titles were added to Netflix each year?
--
-- Objective:
-- Analyze Netflix's yearly content acquisition trend to
-- understand how the platform expanded its catalogue over time.
--
-- SQL Concepts Used:
-- • STR_TO_DATE()
-- • YEAR()
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- ==========================================================

SELECT
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(date_added) <> ''
GROUP BY YEAR(STR_TO_DATE(date_added, '%M %d, %Y'))
ORDER BY year_added;

-- Expected Output:
-- +------------+--------------+
-- | year_added | total_titles |
-- +------------+--------------+
-- | 2008       | ...          |
-- | 2009       | ...          |
-- | 2010       | ...          |
-- | ...        | ...          |
-- | 2021       | ...          |
-- +------------+--------------+
--
-- Business Insight:
-- This analysis shows Netflix's content acquisition trend over
-- the years and helps identify periods of rapid catalogue growth.

-- ==========================================================
-- Question 3: Content Added to Netflix by Month
-- ==========================================================
-- Business Question:
-- Which month has the highest number of titles added to Netflix?
--
-- Objective:
-- Identify the months in which Netflix adds the most content.
-- This helps understand seasonal trends in content releases.
--
-- SQL Concepts Used:
-- • MONTHNAME()
-- • STR_TO_DATE()
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- ==========================================================

SELECT
    MONTHNAME(STR_TO_DATE(date_added, '%M %d, %Y')) AS month_added,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(date_added) <> ''
GROUP BY MONTHNAME(STR_TO_DATE(date_added, '%M %d, %Y'))
ORDER BY total_titles DESC;

-- Expected Output:
-- +-------------+--------------+
-- | month_added | total_titles |
-- +-------------+--------------+
-- | July        | ...          |
-- | December    | ...          |
-- | September   | ...          |
-- | ...         | ...          |
-- +-------------+--------------+
--
-- Business Insight:
-- This analysis identifies the months when Netflix typically
-- adds the most content, revealing seasonal acquisition
-- patterns and release strategies.

-- ==========================================================
-- Question 4: Number of Movies Released Each Year
-- ==========================================================
-- Business Question:
-- How many movies were released each year?
--
-- Objective:
-- Analyze movie release trends over the years to identify
-- periods of high and low production.
--
-- SQL Concepts Used:
-- • WHERE
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- ==========================================================

select count(*),release_year from 
netflix_titles
where type='Movie'
group by release_year
order by release_year

-- Expected Output:
-- +--------------+--------------+
-- | release_year | total_movies |
-- +--------------+--------------+
-- | 1942         | ...          |
-- | 1943         | ...          |
-- | 1944         | ...          |
-- | ...          | ...          |
-- | 2021         | ...          |
-- +--------------+--------------+
--
-- Business Insight:
-- This analysis shows the yearly trend of movie releases
-- available on Netflix. It helps identify growth in movie
-- production and the distribution of content across different
-- release years.

-- ==========================================================
-- Question 5: Top 10 Content Producing Countries
-- ==========================================================
-- Business Question:
-- Which countries contribute the highest number of titles
-- available on Netflix?
--
-- Objective:
-- Identify the top 10 countries with the largest number of
-- Movies and TV Shows in the Netflix catalogue.
--
-- SQL Concepts Used:
-- • WHERE
-- • TRIM()
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- • LIMIT
-- ==========================================================

select count(*) as total_titles,trim(country) from 
netflix_titles
group by country
order by total_titles desc
limit 10 

-- Expected Output:
-- +----------------+--------------+
-- | country        | total_titles |
-- +----------------+--------------+
-- | United States  | 2818         |
-- | India          | 972          |
-- | United Kingdom | 419          |
-- | Japan          | 245          |
-- | South Korea    | 199          |
-- | Canada         | 181          |
-- | Spain          | 145          |
-- | France         | 124          |
-- | Mexico         | 110          |
-- | Egypt          | 106          |
-- +----------------+--------------+
--
-- Business Insight:
-- The United States contributes the highest number of titles
-- to Netflix, followed by India. This indicates Netflix's
-- strong presence in the North American and Indian markets,
-- while countries such as Japan and South Korea demonstrate
-- the platform's growing investment in Asian content.

-- ==========================================================
-- Question 6: Top 10 Directors on Netflix
-- ==========================================================
-- Business Question:
-- Which directors have the highest number of titles available
-- on Netflix?
--
-- Objective:
-- Identify the top 10 directors based on the number of Movies
-- and TV Shows they have directed on Netflix.
--
-- SQL Concepts Used:
-- • WHERE
-- • TRIM()
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- • LIMIT
-- ==========================================================

select count(*) as total_titles,trim(director) from 
netflix_titles
group by director
order by total_titles desc
limit 10 

-- Expected Output:
-- +----------------------+--------------+
-- | director             | total_titles |
-- +----------------------+--------------+
-- | Rajiv Chilaka        | 19           |
-- | Raúl Campos          | 18           |
-- | Marcus Raboy         | 16           |
-- | Jay Karas            | 15           |
-- | Cathy Garcia-Molina  | 13           |
-- | Youssef Chahine      | 12           |
-- | Martin Scorsese      | 12           |
-- | Jay Chapman          | 12           |
-- | Steven Spielberg     | 11           |
-- | David Dhawan         | 11           |
-- +----------------------+--------------+
--
-- Business Insight:
-- Rajiv Chilaka has the highest number of titles on Netflix,
-- followed by Raúl Campos and Marcus Raboy. These directors
-- have contributed significantly to Netflix's content library.

-- ==========================================================
-- Question 7: Distribution of Content Ratings
-- ==========================================================
-- Business Question:
-- What are the most common content ratings available on Netflix?
--
-- Objective:
-- Analyze the distribution of content ratings to understand
-- the target audience of Netflix's catalogue.
--
-- SQL Concepts Used:
-- • WHERE
-- • COUNT()
-- • GROUP BY
-- • ORDER BY
-- ==========================================================

select count(*) as total_titles,trim(rating) from 
netflix_titles
group by rating
order by total_titles desc

-- Expected Output:
-- +-----------+--------------+
-- | rating    | total_titles |
-- +-----------+--------------+
-- | TV-MA     | 3204         |
-- | TV-14     | 2160         |
-- | TV-PG     | 863          |
-- | R         | 799          |
-- | PG-13     | 490          |
-- | TV-Y7     | 334          |
-- | TV-Y      | 307          |
-- | PG        | 287          |
-- | TV-G      | 220          |
-- | NR        | 80           |
-- | G         | 41           |
-- | TV-Y7-FV  | 6            |
-- | NC-17     | 3            |
-- | UR        | 3            |
-- +-----------+--------------+
--
-- Business Insight:
-- TV-MA is the most common rating on Netflix, followed by
-- TV-14 and TV-PG. This indicates that a significant portion
-- of Netflix's catalogue is designed for mature and teenage
-- audiences, while children's content represents a smaller
-- share of the platform.

-- ==========================================================
-- Question 8: Average Duration of Movies
-- ==========================================================
-- Business Question:
-- What is the average duration of Movies available on Netflix?
--
-- Objective:
-- Calculate the average movie duration to understand the
-- typical length of movies in the Netflix catalogue.
--
-- SQL Concepts Used:
-- • WHERE
-- • REPLACE()
-- • CAST()
-- • AVG()
-- • ROUND()
-- ==========================================================

SELECT
    ROUND(
        AVG(
            CAST(REPLACE(duration, ' min', '') AS UNSIGNED)
        ),
        2
    ) AS average_movie_duration
FROM netflix_titles
WHERE type = 'Movie';

-- Expected Output:
-- +------------------------+
-- | average_movie_duration |
-- +------------------------+
-- | 99.58                 |
-- +------------------------+
--
-- Business Insight:
-- The average duration of movies on Netflix is approximately
-- 100 minutes, indicating that most movies are around
-- 1 hour and 40 minutes long.

-- ==========================================================
-- Question 9: Top 10 Longest Movies on Netflix
-- ==========================================================
-- Business Question:
-- Which are the top 10 longest movies available on Netflix?
--
-- Objective:
-- Identify the longest movies in the Netflix catalogue based
-- on their duration.
--
-- SQL Concepts Used:
-- • WHERE
-- • REPLACE()
-- • CAST()
-- • ORDER BY
-- • DESC
-- • LIMIT
-- ==========================================================

SELECT
    title,
    director,
    release_year,
    duration
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY CAST(REPLACE(duration, ' min', '') AS UNSIGNED) DESC
LIMIT 10;

-- Expected Output:
-- +----------------------+------------------+--------------+----------+
-- | title                | director         | release_year | duration |
-- +----------------------+------------------+--------------+----------+
-- | ...                  | ...              | ...          | 312 min  |
-- | ...                  | ...              | ...          | 273 min  |
-- | ...                  | ...              | ...          | 248 min  |
-- | ...                  | ...              | ...          | ...      |
-- +----------------------+------------------+--------------+----------+
--
-- Business Insight:
-- This analysis identifies the longest movies available on
-- Netflix. Such content may appeal to audiences interested
-- in extended films, documentaries, or epic cinematic
-- experiences.

-- ==========================================================
-- Question 10: Oldest Movies and TV Shows on Netflix
-- ==========================================================
-- Business Question:
-- Which are the oldest Movies and TV Shows available on Netflix?
--
-- Objective:
-- Identify the oldest titles in the Netflix catalogue based
-- on their release year.
--
-- SQL Concepts Used:
-- • ORDER BY
-- • ASC
-- • LIMIT
-- ==========================================================

SELECT
    title,
    type,
    release_year,
    country,
    rating
FROM netflix_titles
ORDER BY release_year ASC
LIMIT 10;

-- Expected Output:
-- +----------------------+----------+--------------+---------------+--------+
-- | title                | type     | release_year | country       | rating |
-- +----------------------+----------+--------------+---------------+--------+
-- | Prelude to War       | Movie    | 1942         | United States | TV-PG  |
-- | The Battle of Midway | Movie    | 1942         | United States | TV-PG  |
-- | ...                  | ...      | ...          | ...           | ...    |
-- +----------------------+----------+--------------+---------------+--------+
--
-- Business Insight:
-- Netflix's catalogue contains classic titles dating back
-- to the 1940s, demonstrating that the platform offers both
-- historical and modern content to its audience.