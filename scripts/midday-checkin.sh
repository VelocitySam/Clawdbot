#!/bin/bash
# Midday Check-in Script
# Provides todo list, essential emails, and calendar overview

# Load environment
if [ -f ~/.config/notion/api_key ]; then
    NOTION_TOKEN=$(cat ~/.config/notion/api_key)
fi

if [ -f ~/.config/gog/keyring_password ]; then
    export GOG_KEYRING_PASSWORD=$(cat ~/.config/gog/keyring_password)
fi

TODAY=$(date "+%Y-%m-%d")
TIME=$(date "+%-l:%M %p")

REPORT="🌤️ **Midday Check-in** 🧠🦉

**$TIME Copenhagen — $TODAY**

"

# Notion Todos
REPORT+="**📋 Active Todos:**"
if [ -n "$NOTION_TOKEN" ]; then
    TODOS=$(curl -s -X POST "https://api.notion.com/v1/databases/2b5009ce-b59d-8076-8610-cb340cb3930a/query" \
      -H "Authorization: Bearer $NOTION_TOKEN" \
      -H "Notion-Version: 2022-06-28" \
      -H "Content-Type: application/json" \
      -d '{"filter": {"property": "Status", "status": {"does_not_equal": "Done"}}, "page_size": 10}')
    
    TASKS=$(echo "$TODOS" | grep -o '"content":"[^"]*"' | head -10 | sed 's/"content":"//;s/"$//')
    TASK_COUNT=$(echo "$TASKS" | grep -c .)
    if [ "$TASK_COUNT" -gt 0 ]; then
        while IFS= read -r task; do
            [ -n "$task" ] && REPORT+="- $task
"
        done <<< "$TASKS"
    else
        REPORT+="- ✅ All caught up!
"
    fi
else
    REPORT+="- Notion not configured
"
fi
REPORT+="
"

# Essential Emails
REPORT+="**📧 Important Unread Emails:**"
if command -v gog >/dev/null 2>&1 && [ -n "$GOG_KEYRING_PASSWORD" ]; then
    EMAILS=$(gog gmail search 'is:unread label:important' --max 5 2>/dev/null)
    if [ -z "$EMAILS" ] || [ "$EMAILS" = "No messages found" ]; then
        REPORT+="- No important unread emails
"
    else
        while read -r line; do
            if [ -n "$line" ]; then
                FROM=$(echo "$line" | awk '{print $3}' | sed 's/<[^>]*>//g')
                SUBJECT=$(echo "$line" | awk '{$1=$2=$3=""; print $0}' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]LABELS.*$//')
                if [ -n "$FROM" ] && [ -n "$SUBJECT" ]; then
                    REPORT+="- **$FROM**: $SUBJECT
"
                fi
            fi
        done <<< "$EMAILS"
    fi
else
    REPORT+="- Gmail not accessible
"
fi
REPORT+="
"

# Calendar - Remaining today
REPORT+="**📅 Remaining Today (Isa & Sam's adventures):**"
if command -v gog >/dev/null 2>&1 && [ -n "$GOG_KEYRING_PASSWORD" ]; then
    TOMORROW=$(date -d tomorrow +%Y-%m-%d)
    
    EVENTS=$(gog calendar events f1f2g8osapkgdspsbjogrl7jok@group.calendar.google.com --from "$TODAY" --to "$TOMORROW" --max 10 2>/dev/null)
    
    if [ -z "$EVENTS" ] || [ "$EVENTS" = "No events" ]; then
        REPORT+="- No events scheduled
"
    else
        while read -r line; do
            if [ -n "$line" ]; then
                START=$(echo "$line" | awk '{print $2}')
                SUMMARY=$(echo "$line" | awk '{print $NF}')
                if [[ "$START" == *"T"* ]]; then
                    TIME_VAL=$(echo "$START" | cut -d'T' -f2 | cut -d':' -f1-2)
                    REPORT+="- $TIME_VAL: $SUMMARY
"
                else
                    REPORT+="- All day: $SUMMARY
"
                fi
            fi
        done <<< "$EVENTS"
    fi
else
    REPORT+="- Calendar not accessible
"
fi
REPORT+="
"

REPORT+="💪 Keep going!"

# Output the report
echo "$REPORT"

# Send via email as fallback
echo "$REPORT" | gog gmail send \
    --to "sam@velocityengineering.dk" \
    --subject "Midday Check-in - $(date '+%Y-%m-%d')" \
    --body-file "-" 2>/dev/null || true
