select EVENT_NAME, 
EVENT_TIMESTAMP, 
USER_ID, 
FINGERPRINT, 
ARRIVAL_TIMESTAMP, 
BROWSER_NAME, 
BROWSER_VERSION, 
LANGUAGE, 
SCREEN_RESOLUTION, 
DEVICE_TYPE, 
COOKIES_ENABLED, 
SESSION_ID, 
USER_ACCESS_TYPE, 
COUNTRY_CODE, 
REFERRER, 
ITEM_ID, 
ITEM_TYPE, 
ITEM_TITLE
from 
 {{ source('events', 'web_events') }}