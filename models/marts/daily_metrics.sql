WITH t1 AS (
    SELECT 
        USER_ID,
        ITEM_ID,
        EVENT_NAME,
        COUNTRY_CODE,
        DATE_TRUNC('day', EVENT_TIMESTAMP) AS event_date
    FROM {{ ref("events_all") }}
),
t2 AS (
    SELECT 
        event_date,
        COUNT(DISTINCT USER_ID) AS daily_active_users,
        COUNT(DISTINCT CASE WHEN ITEM_ID IS NOT NULL THEN USER_ID END) AS daily_active_learners,
        COUNT(DISTINCT CASE WHEN EVENT_NAME = 'item-finished' THEN ITEM_ID END) AS content_completions,
        COUNT(DISTINCT CASE WHEN EVENT_NAME = 'item-finished' THEN USER_ID END) AS content_completion_user_count,
        COUNT(distinct (case when COUNTRY_CODE in ('DE','AT','CH') 
        and (DATEDIFF('day', event_date, current_date())) <= 29 
        then USER_ID else '0' end)) as dach_active_user_count
    FROM t1
    GROUP BY event_date
)
SELECT * FROM t2
