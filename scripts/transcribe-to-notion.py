#!/usr/bin/env python3
"""Transcribe audio and save to Notion Voice Notes"""
import sys
import os
import json
import subprocess

AUDIO_FILE = sys.argv[1] if len(sys.argv) > 1 else None

if not AUDIO_FILE or not os.path.exists(AUDIO_FILE):
    print("Usage: ./transcribe-to-notion.py <audio_file>")
    sys.exit(1)

# Load tokens
with open(os.path.expanduser("~/.config/lemonfox/api_key.env")) as f:
    for line in f:
        if line.startswith("LEMONFOX_API_KEY="):
            LEMONFOX_API_KEY = line.strip().split("=")[1]
            break

with open(os.path.expanduser("~/.config/notion/api_key")) as f:
    NOTION_TOKEN = f.read().strip()

# Transcribe using curl
print("🎤 Transcribing...")
result = subprocess.run([
    "curl", "-s", "-X", "POST",
    "https://api.lemonfox.ai/v1/audio/transcriptions",
    "-H", f"Authorization: Bearer {LEMONFOX_API_KEY}",
    "-F", f"file=@{AUDIO_FILE}",
    "-F", "response_format=text"
], capture_output=True, text=True)

transcription = result.stdout.strip()

# Clean filler words
fillers = ["uh", "um", "uhm", "ah", "er", "like", "you know", "sort of", "kinda", "kind of", "stuff", "things", "the the"]
cleaned = transcription
for filler in fillers:
    cleaned = cleaned.replace(filler, " ")
cleaned = " ".join(cleaned.split())

# Get filename as title
filename = os.path.basename(AUDIO_FILE).rsplit(".", 1)[0]

print("📝 Saving to Notion...")

# Create page in Voice Notes database
payload = {
    "parent": {"database_id": "958b3b8f-7b32-4be6-9cd7-4aeb0985cb91"},
    "properties": {
        "Name": {"title": [{"text": {"content": filename}}]}
    },
    "children": [
        {"object": "block", "type": "paragraph", "paragraph": {"rich_text": [{"text": {"content": cleaned}}]}}
    ]
}

result = subprocess.run([
    "curl", "-s", "-X", "POST",
    "https://api.notion.com/v1/pages",
    "-H", f"Authorization: Bearer {NOTION_TOKEN}",
    "-H", "Notion-Version: 2025-09-03",
    "-H", "Content-Type: application/json",
    "-d", json.dumps(payload)
], capture_output=True, text=True)

response = json.loads(result.stdout)

if response.get("object") == "error":
    print(f"❌ Error: {response.get('message')}")
else:
    page_id = response.get("id", "")
    short_id = page_id.replace("-", "")
    print(f"✅ Saved: {filename}")
    print(f"   URL: https://www.notion.so/{short_id}")
