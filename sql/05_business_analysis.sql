USE netflix;

-- ==========================================================
-- 06: BUSINESS INSIGHTS
-- ==========================================================


-- 1. Total Netflix Titles

SELECT
    COUNT(*) AS total_titles
FROM netflix_titles;


-- 2. Movies vs TV Shows

SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type
ORDER BY total_titles DESC;


-- 3. Top 10 Countries

SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(country) <> ''
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;


-- 4. Most Common Ratings

SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 10;


-- 5. Content Added by Year

SELECT
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(date_added) <> ''
GROUP BY year_added
ORDER BY year_added;


-- 6. Top Directors

SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(director) <> ''
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- 7. Average Movie Duration

SELECT
    ROUND(
        AVG(
            CAST(REPLACE(duration, ' min', '') AS UNSIGNED)
        ),
        2
    ) AS average_movie_duration
FROM netflix_titles
WHERE type = 'Movie';


-- 8. Content Released in Recent Years

SELECT
    release_year,
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE release_year >= 2015
GROUP BY release_year, type
ORDER BY release_year, type;