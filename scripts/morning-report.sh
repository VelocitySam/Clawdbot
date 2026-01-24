#!/bin/bash
# Morning Report Script with location and integrations support

# Get current date/time
DATE=$(date "+%A, %B %d, %Y")
TIME=$(date "+%-l:%M %p")

# Copenhagen weather
WEATHER=$(curl -s "https://wttr.in/Copenhagen?format=%C+%t+%h+%w" 2>/dev/null || echo "Weather unavailable")

echo "🌅 **Good Morning, Sam!** 🧠🦉"
echo ""
echo "**$DATE — $TIME Copenhagen time**"
echo ""
echo "**☀️ Weather in Copenhagen:** $WEATHER"
echo ""

# Check if Notion is configured
if [ -f /root/clawd/.notion_env ]; then
    echo "**📋 Notion Tasks:**"
    # Load Notion token
    source /root/clawd/.notion_env
    # TODO: Query Notion todos (late, due today, or no date)
    echo "- Querying Notion todos..."
else
    echo "**📋 Tasks:** Notion not configured"
fi
echo ""

# Check if Google Calendar is configured
if command -v gog >/dev/null 2>&1 && gog auth list 2>/dev/null | grep -q gmail.com; then
    echo "**📅 Today's Calendar:**"
    # Get today's events
    TODAY=$(date -I)
    TOMORROW=$(date -I -d "tomorrow")
    gog calendar events primary --from "$TODAY" --to "$TOMORROW" --single-events --order-by startTime --max 10 2>/dev/null | head -20 || echo "- No calendar access"
else
    echo "**📅 Calendar:** Google Workspace not configured (run: gog auth add)"
fi
echo ""

# Check for overnight emails
if command -v gog >/dev/null 2>&1 && gog auth list 2>/dev/null | grep -q gmail.com; then
    echo "**📧 Overnight Emails:**"
    # Get important emails from last 12 hours
    gog gmail search 'newer_than:12h is:important' --max 5 --format minimal 2>/dev/null || echo "- No email access"
else
    echo "**📧 Emails:** Google Workspace not configured"
fi