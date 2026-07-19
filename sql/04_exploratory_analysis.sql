-- ==========================================================
-- Question 1
-- Distribution of Movies vs TV Shows
-- ==========================================================

SELECT
    type,
    COUNT(*) AS total_titles,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles),2) AS percentage
FROM netflix_titles
GROUP BY type
ORDER BY total_titles DESC;