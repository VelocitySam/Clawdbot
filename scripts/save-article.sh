#!/bin/bash
# Save article from URL to Notion
# Usage: ./save-article.sh "https://example.com/article" "Article Title"

URL="$1"
TITLE="$2"

if [ -z "$URL" ]; then
    echo "Usage: ./save-article.sh <url> [title]"
    exit 1
fi

# Fetch article content
echo "Fetching article..."
CONTENT=$(curl -s "$URL" | python3 -c "
import sys, json, re
from html import unescape
try:
    import requests
    from bs4 import BeautifulSoup
    r = requests.get(sys.argv[1])
    soup = BeautifulSoup(r.text, 'html.parser')
    # Remove scripts and styles
    for s in soup(['script', 'style', 'nav', 'footer', 'header']):
        s.decompose()
    text = soup.get_text()
    # Clean up
    lines = (line.strip() for line in text.splitlines())
    chunks = (phrase.strip() for line in lines for phrase in line.split('  '))
    text = '\n'.join(c for c in chunks if c)
    print(text[:10000])  # Limit to 10k chars
except Exception as e:
    print(f'Error: {e}', file=sys.stderr)
    sys.exit(1)
" -- "$URL" 2>/dev/null)

if [ -z "$CONTENT" ] || [ "$CONTENT" = "Error"* ]; then
    echo "Failed to fetch article. Try using web_fetch tool instead."
    exit 1
fi

# Get page title if not provided
if [ -z "$TITLE" ]; then
    TITLE=$(echo "$URL" | sed 's|https*://||' | sed 's|www\.||' | cut -d'/' -f1 | tr '-' ' ' | title)
fi

NOTION_KEY="ntn_bb1645418531Z2asRVrX0F7aBc9l9qoegMZ98BHThRA4kK"

# Create page in Todo List database
echo "Creating Notion page..."
curl -s -X POST "https://api.notion.com/v1/pages" \
    -H "Authorization: Bearer $NOTION_KEY" \
    -H "Notion-Version: 2025-09-03" \
    -H "Content-Type: application/json" \
    -d "{
        \"parent\": {\"database_id\": \"2b5009ce-b59d-8076-8610-cb340cb3930a\"},
        \"properties\": {
            \"Task name\": {\"title\": [{\"text\": {\"content\": \"$TITLE\"}}]}
        },
        \"children\": [
            {
                \"object\": \"block\",
                \"type\": \"paragraph\",
                \"paragraph\": {
                    \"rich_text\": [{\"text\": {\"content\": \"$CONTENT\"}}]
                }
            }
        ]
    }" | grep -o '"url":"[^"]*"' | head -1

echo ""
echo "Done! Article saved to Notion."
