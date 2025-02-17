with t1 as 
(
    select *,
    date_trunc('day', EVENT_TIMESTAMP) as event_date
    from {{ref("events_all")}}
),
t2 as 
(
    select event_date,
    count(distinct USER_ID) as daily_active_users,
    count(distinct (case when ITEM_ID is not null then user_id else 0 end)) as daily_active_learners,
    count(distinct (case when EVENT_NAME = 'item-finished' then ITEM_ID else 0 end)) as content_completions,
    count(distinct (case when EVENT_NAME = 'item-finished' then USER_ID else 0 end)) as content_completion_user_count,
    count(distinct (case when COUNTRY_CODE in ('DE','AT','CH') 
    and date_diff(DATEDIFF('day', event_date, run_at_date)) <= 29 
    then user_id else 0 end)) as dach_active_user_count
    from t1
    group by 1
)
select * from t2
