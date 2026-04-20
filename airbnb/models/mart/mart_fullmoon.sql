{{config(
    materialized='table',
)}}

WITH fact_reviews AS(
    SELECT * FROM {{ref('fact_reviews')}}
),full_moon_dates AS(
    SELECT * FROM {{ref('seed_full_moon_dates')}}
)

SELECT 
 r.*,
 CASE 
    WHEN f.FULL_MOON_DATE IS NULL THEN 'NotFull Moon'
    ELSE 'Full Moon'
    END AS MOON_PHASE
FROM fact_reviews r
LEFT JOIN full_moon_dates f
ON (TO_DATE(r.REVIEW_DATE) = DATEADD(day, 1, f.FULL_MOON_DATE))