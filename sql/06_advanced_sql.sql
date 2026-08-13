USE netflix;

-- ==========================================================
-- 05: ADVANCED SQL ANALYSIS
-- ==========================================================

-- ==========================================================
-- Question 1: Classify Content by Type
-- ==========================================================

SELECT
    title,
    type,
    CASE
        WHEN type = 'Movie' THEN 'Film Content'
        WHEN type = 'TV Show' THEN 'Series Content'
        ELSE 'Other'
    END AS content_category
FROM netflix_titles;


-- ==========================================================
-- Question 2: Countries with More Than 500 Titles
-- ==========================================================

SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE TRIM(country) <> ''
GROUP BY country
HAVING COUNT(*) > 500
ORDER BY total_titles DESC;


-- ==========================================================
-- Question 3: Movies Longer Than Average
-- ==========================================================

SELECT
    title,
    duration
FROM netflix_titles
WHERE type = 'Movie'
  AND CAST(REPLACE(duration, ' min', '') AS UNSIGNED) >
      (
          SELECT AVG(
              CAST(REPLACE(duration, ' min', '') AS UNSIGNED)
          )
          FROM netflix_titles
          WHERE type = 'Movie'
      )
ORDER BY CAST(REPLACE(duration, ' min', '') AS UNSIGNED) DESC;


-- ==========================================================
-- Question 4: CTE - Count Movies and TV Shows
-- ==========================================================

WITH content_count AS (
    SELECT
        type,
        COUNT(*) AS total_titles
    FROM netflix_titles
    GROUP BY type
)
SELECT *
FROM content_count
ORDER BY total_titles DESC;


-- ==========================================================
-- Question 5: Rank Countries by Number of Titles
-- ==========================================================

SELECT
    country,
    COUNT(*) AS total_titles,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS country_rank
FROM netflix_titles
WHERE TRIM(country) <> ''
GROUP BY country
ORDER BY country_rank;


-- ==========================================================
-- Question 6: Rank Content Within Each Type
-- ==========================================================

SELECT
    type,
    title,
    release_year,
    ROW_NUMBER() OVER (
        PARTITION BY type
        ORDER BY release_year DESC
    ) AS row_number
FROM netflix_titles;


-- ==========================================================
-- Question 7: Dense Rank Countries
-- ==========================================================

SELECT
    country,
    COUNT(*) AS total_titles,
    DENSE_RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS country_rank
FROM netflix_titles
WHERE TRIM(country) <> ''
GROUP BY country
ORDER BY country_rank;


-- ==========================================================
-- Question 8: Recent Content Classification
-- ==========================================================

SELECT
    title,
    type,
    release_year,
    CASE
        WHEN release_year >= 2020 THEN 'Recent'
        WHEN release_year >= 2010 THEN 'Modern'
        ELSE 'Older'
    END AS content_period
FROM netflix_titles
ORDER BY release_year DESC;