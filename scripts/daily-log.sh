#!/bin/bash
# Daily activity logger for Clawdbot

DATE=$(date +%Y-%m-%d)
LOG_FILE="/root/clawd/memory/${DATE}.md"

# Check if already logged today
if [ -f "$LOG_FILE" ]; then
    echo "Already logged today"
    exit 0
fi

# Get weather
WEATHER=$(curl -s --max-time 10 "https://wttr.in/Copenhagen?format=%C+%t" 2>/dev/null || echo "Unknown")

# Get Notion tasks
NOTION_KEY=$(cat /root/clawd/.notion_api_key)
TASKS=$(curl -s -X POST "https://api.notion.com/v1/data_sources/2b5009ce-b59d-80da-919b-000b806e9c9d/query" \
    -H "Authorization: Bearer $NOTION_KEY" \
    -H "Notion-Version: 2025-09-03" \
    -H "Content-Type: application/json" \
    -d '{}' 2>/dev/null | grep -o '"name":"Not started"' | wc -l || echo "0")

# Create daily log
cat > "$LOG_FILE" << EOF
# ${DATE}

## Weather (Copenhagen)
${WEATHER}

## Notion Tasks
- Pending tasks: ${TASKS}

## Activities
- [Auto-logged by cron]

## Notes
EOF

echo "Daily log created: $LOG_FILE"
