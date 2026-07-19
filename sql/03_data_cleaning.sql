-- ==========================================================
-- Netflix SQL Analysis Project
-- File: 03_data_cleaning.sql
-- Description:
-- This script performs initial data quality checks, data
-- profiling, and basic cleaning on the Netflix dataset.
-- ==========================================================

USE netflix;

-- ==========================================================
-- Step 1: Dataset Overview
-- ==========================================================

-- Count total number of records

SELECT COUNT(*) AS total_records
FROM netflix_titles;


-- Preview first 10 records

SELECT *
FROM netflix_titles
LIMIT 10;


-- ==========================================================
-- Step 2: Check NULL Values
-- ==========================================================

SELECT
    SUM(show_id IS NULL)        AS show_id_nulls,
    SUM(type IS NULL)           AS type_nulls,
    SUM(title IS NULL)          AS title_nulls,
    SUM(director IS NULL)       AS director_nulls,
    SUM(cast_members IS NULL)   AS cast_nulls,
    SUM(country IS NULL)        AS country_nulls,
    SUM(date_added IS NULL)     AS date_added_nulls,
    SUM(release_year IS NULL)   AS release_year_nulls,
    SUM(rating IS NULL)         AS rating_nulls,
    SUM(duration IS NULL)       AS duration_nulls,
    SUM(listed_in IS NULL)      AS listed_in_nulls,
    SUM(description IS NULL)    AS description_nulls
FROM netflix_titles;

-- Result:
-- No NULL values found.


-- ==========================================================
-- Step 3: Check Empty Values
-- ==========================================================

SELECT COUNT(*) AS empty_director
FROM netflix_titles
WHERE TRIM(director) = '';

-- Result: 2634


SELECT COUNT(*) AS empty_country
FROM netflix_titles
WHERE TRIM(country) = '';

-- Result: 831


SELECT COUNT(*) AS empty_cast
FROM netflix_titles
WHERE TRIM(cast_members) = '';

-- Result: 825


SELECT COUNT(*) AS empty_date_added
FROM netflix_titles
WHERE TRIM(date_added) = '';

-- Result: 10


-- ==========================================================
-- Step 4: Check Duplicate Primary Keys
-- ==========================================================

SELECT
    show_id,
    COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

-- Result:
-- No duplicate show_id found.


-- ==========================================================
-- Step 5: Check Complete Duplicate Records
-- ==========================================================

SELECT
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    listed_in,
    description,
    COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY
    show_id,
    type,
    title,
    director,
    cast_members,
    country,
    date_added,
    release_year,
    rating,
    duration,
    listed_in,
    description
HAVING COUNT(*) > 1;

-- Result:
-- No duplicate records found.


-- ==========================================================
-- Step 6: Data Profiling
-- ==========================================================

-- ----------------------------------------------------------
-- 6.1 Movies vs TV Shows
-- ----------------------------------------------------------

SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;

-- Result:
-- Movie   : 6131
-- TV Show : 2676


-- ----------------------------------------------------------
-- 6.2 Rating Distribution
-- ----------------------------------------------------------

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY rating
ORDER BY total_titles DESC;

-- Observation:
-- Found three incorrect values:
-- 66 min
-- 74 min
-- 84 min


-- ----------------------------------------------------------
-- 6.3 Top 10 Content Producing Countries
-- ----------------------------------------------------------

SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(country) <> ''
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Top Countries:
-- United States : 2818
-- India         : 972
-- United Kingdom: 419
-- Japan         : 245
-- South Korea   : 199
-- Canada        : 181
-- Spain         : 145
-- France        : 124
-- Mexico        : 110
-- Egypt         : 106


-- ==========================================================
-- Step 7: Identify Incorrect Rating Values
-- ==========================================================

SELECT
    show_id,
    title,
    rating,
    duration
FROM netflix_titles
WHERE rating IN ('66 min','74 min','84 min');

-- Observation:
-- Duration values were incorrectly stored in the rating column.


-- ==========================================================
-- Step 8: Fix Incorrect Rating Values
-- ==========================================================

UPDATE netflix_titles
SET
    duration = rating,
    rating = NULL
WHERE rating IN ('66 min','74 min','84 min');


-- ==========================================================
-- Step 9: Verify Data Cleaning
-- ==========================================================

SELECT
    show_id,
    title,
    rating,
    duration
FROM netflix_titles
WHERE show_id IN ('s5542','s5795','s5814');

-- Expected Result:
-- Rating   -> NULL
-- Duration -> 74 min / 84 min / 66 min


-- ==========================================================
-- Data Cleaning Completed Successfully
-- ==========================================================