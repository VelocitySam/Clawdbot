#!/bin/bash
# Transcribe audio and save to Notion Voice Notes
# Usage: ./transcribe-to-notion.sh <audio_file>

AUDIO_FILE="$1"
NOTION_TOKEN_FILE="${HOME}/.config/notion/api_key"
LEMONFOX_TOKEN_FILE="${HOME}/.config/lemonfox/api_key.env"

if [ -z "$AUDIO_FILE" ]; then
    echo "Usage: $0 <audio_file>"
    echo "  audio_file: Path to .ogg, .mp3, .wav file"
    exit 1
fi

if [ ! -f "$AUDIO_FILE" ]; then
    echo "Error: File not found: $AUDIO_FILE"
    exit 1
fi

# Load tokens
export $(cat "$LEMONFOX_TOKEN_FILE" | xargs)
NOTION_TOKEN=$(cat "$NOTION_TOKEN_FILE")

# Transcribe
echo "🎤 Transcribing..."
TRANSCRIPTION=$(curl -s -X POST "https://api.lemonfox.ai/v1/audio/transcriptions" \
    -H "Authorization: Bearer $LEMONFOX_API_KEY" \
    -F "file=@$AUDIO_FILE" \
    -F "response_format=text")

# Clean filler words
CLEANED=$(echo "$TRANSCRIPTION" | sed -E 's/\b(uh|um|uhm|ah|er|like|you know|sort of|kinda|kind of|stuff|things)\b//gi' | sed -E 's/  +/ /g' | sed -E 's/^ | $//g' | sed -E 's/\. \././g')

# Get filename as title
FILENAME=$(basename "$AUDIO_FILE" | sed 's/\.[^.]*$//')
TIMESTAMP=$(date +%Y-%m-%dT%H:%M:%SZ)

echo "📝 Saving to Notion..."

# Create page in Voice Notes database
curl -s -X POST "https://api.notion.com/v1/pages" \
    -H "Authorization: Bearer $NOTION_TOKEN" \
    -H "Notion-Version: 2025-09-03" \
    -H "Content-Type: application/json" \
    -d "{
        \"parent\": {\"database_id\": \"958b3b8f-7b32-4be6-9cd7-4aeb0985cb91\"},
        \"properties\": {
            \"Name\": {\"title\": [{\"text\": {\"content\": \"$FILENAME\"}}]}
        },
        \"children\": [
            {\"object\": \"block\", \"type\": \"paragraph\", \"paragraph\": {\"rich_text\": [{\"text\": {\"content\": \"$CLEANED\"}}]}}
        ]
    }"

echo ""
echo "✅ Saved: $FILENAME"
