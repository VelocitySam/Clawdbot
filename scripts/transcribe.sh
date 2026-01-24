#!/bin/bash
# Lemon Fox AI Transcription Helper
# Usage: ./transcribe.sh <audio_file> [output_format]

AUDIO_FILE="$1"
OUTPUT_FORMAT="${2:-text}"

if [ -z "$AUDIO_FILE" ]; then
    echo "Usage: $0 <audio_file> [output_format]"
    echo "  audio_file: Path to .ogg, .mp3, .wav file"
    echo "  output_format: text (default), json, srt, vtt"
    exit 1
fi

if [ ! -f "$AUDIO_FILE" ]; then
    echo "Error: File not found: $AUDIO_FILE"
    exit 1
fi

# Load API key
export $(cat /root/.config/lemonfox/api_key.env | xargs)

# Transcribe
curl -s -X POST "https://api.lemonfox.ai/v1/audio/transcriptions" \
    -H "Authorization: Bearer $LEMONFOX_API_KEY" \
    -F "file=@$AUDIO_FILE" \
    -F "response_format=$OUTPUT_FORMAT"
