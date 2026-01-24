#!/bin/bash
# Enhanced Morning Report with real data

# Load Notion API key
if [ -f ~/.config/notion/api_key ]; then
    NOTION_TOKEN=$(cat ~/.config/notion/api_key)
fi

# Load GOG keyring password
if [ -f ~/.config/gog/keyring_password ]; then
    export GOG_KEYRING_PASSWORD=$(cat ~/.config/gog/keyring_password)
fi

# Get current date/time
DATE=$(date "+%A, %B %d, %Y")
TIME=$(date "+%-l:%M %p")
TODAY=$(date "+%Y-%m-%d")

# Build report in a variable
REPORT="🌅 **Good Morning, Sam!** 🧠🦉

**$DATE — $TIME Copenhagen time**

"

# Copenhagen weather (with fallback)
WEATHER=$(timeout 5 curl -s "https://wttr.in/Copenhagen?format=%C+%t" 2>/dev/null)
if [ -z "$WEATHER" ] || [ "$WEATHER" = "Unknown" ]; then
    WEATHER_JSON=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=55.6761&longitude=12.5683&current_weather=true" 2>/dev/null)
    TEMP=$(echo "$WEATHER_JSON" | grep -o '"temperature":[0-9.+-]*' | head -1 | sed 's/"temperature"://')
    if [ -n "$TEMP" ]; then
        WEATHER="${TEMP}°C"
    else
        WEATHER="Unknown"
    fi
fi
REPORT+="**☀️ Weather in Copenhagen:** $WEATHER

"

# Notion Tasks
REPORT+="**📋 Notion Tasks:**"
if [ -n "$NOTION_TOKEN" ]; then
    TODOS=$(curl -s -X POST "https://api.notion.com/v1/databases/2b5009ce-b59d-8076-8610-cb340cb3930a/query" \
      -H "Authorization: Bearer $NOTION_TOKEN" \
      -H "Notion-Version: 2022-06-28" \
      -H "Content-Type: application/json" \
      -d '{
        "filter": {
          "and": [
            {
              "property": "Status",
              "status": {"does_not_equal": "Done"}
            },
            {
              "or": [
                {"property": "Due date","date": {"on_or_before": "'$TODAY'"}},
                {"property": "Due date","date": {"is_empty": true}}
              ]
            }
          ]
        },
        "sorts": [{"property": "Due date","direction": "ascending"}]
      }')
    
    TASKS=$(echo "$TODOS" | grep -o '"content":"[^"]*"' | head -10 | sed 's/"content":"//;s/"$//')
    TASK_COUNT=$(echo "$TASKS" | grep -c .)
    if [ "$TASK_COUNT" -gt 0 ]; then
        while IFS= read -r task; do
            [ -n "$task" ] && REPORT+="- $task
"
        done <<< "$TASKS"
    else
        REPORT+="- ✅ No pending tasks!
"
    fi
else
    REPORT+="- Notion not configured
"
fi
REPORT+="
"

# Google Calendar
REPORT+="**📅 Today's Calendar (Isa and Sam's wild adventures):**"
EVENTS=$(gog calendar events f1f2g8osapkgdspsbjogrl7jok@group.calendar.google.com --from "$TODAY" --to "$(date -d tomorrow +%Y-%m-%d)" --max 10 2>/dev/null)
if [ -z "$EVENTS" ] || [ "$EVENTS" = "No events" ]; then
    REPORT+="- No events today
"
else
    # Parse using awk - output has multiple spaces between fields
    EVENTS_BODY=$(echo "$EVENTS" | tail -n +2)
    while read -r line; do
        if [ -n "$line" ]; then
            # Extract last field (SUMMARY) - it's always the last column
            SUMMARY=$(echo "$line" | awk '{print $NF}')
            # Extract START (2nd field, but may have spaces, so get 2nd-3rd)
            START=$(echo "$line" | awk '{print $2}')
            if [[ "$START" == *"T"* ]]; then
                TIME_VAL=$(echo "$START" | cut -d'T' -f2 | cut -d':' -f1-2)
                REPORT+="- $TIME_VAL: $SUMMARY
"
            else
                REPORT+="- All day: $SUMMARY
"
            fi
        fi
    done <<< "$EVENTS_BODY"
fi
REPORT+="
"

# Gmail
REPORT+="**📧 Important Overnight Emails:**"
EMAILS=$(gog gmail search 'newer_than:24h label:important' --max 5 2>/dev/null)
if [ -z "$EMAILS" ] || [ "$EMAILS" = "No messages found" ]; then
    REPORT+="- No new important emails
"
else
    while read -r line; do
        if [ -n "$line" ]; then
            # Extract FROM name (between start and <email@...>)
            FROM=$(echo "$line" | sed 's/<[^>]*>.*//' | awk '{$1=$2=""; print $0}' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
            # Extract SUBJECT (between email and LABEL)
            SUBJECT=$(echo "$line" | sed 's/.*<[^>]*> *//' | sed 's/[[:space:]]*LABELS.*$//' | sed 's/[[:space:]]*$//')
            if [ -n "$FROM" ] && [ -n "$SUBJECT" ]; then
                REPORT+="- **$FROM**: $SUBJECT
"
            fi
        fi
    done <<< "$EMAILS"
fi

# Output the report
echo "$REPORT"

# Send report via email as fallback delivery
echo "$REPORT" | gog gmail send \
    --to "sam@velocityengineering.dk" \
    --subject "Morning Report - $(date '+%Y-%m-%d')" \
    --body-file "-" 2>/dev/null || true
