WITH h AS (
    SELECT * FROM {{ref('dim_hosts_cleansed')}}
),
l AS (
    SELECT * FROM {{ref('dim_listings_cleansed')}}
)
SELECT 
    l.LISTING_ID,
    l.LISTING_URL, 
    l.LISTING_NAME,
    l.ROOM_TYPE,
    l.MINIMUM_NIGHTS, 
    l.HOST_ID,
    l.PRICE,
    l.CREATED_AT,
    h.HOST_NAME,
    h.IS_SUPERHOST as HOST_IS_SUPERHOST,
    GREATEST(l.UPDATED_AT, h.UPDATED_AT) as UPDATED_AT
FROM l
LEFT JOIN h on (h.HOST_ID = l.HOST_ID)  