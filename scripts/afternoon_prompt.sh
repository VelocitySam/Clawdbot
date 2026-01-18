#!/bin/bash
# Afternoon prompt - asks Sam if there's anything to note down

curl -s -X POST "http://127.0.0.1:18789/api/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $(cat /root/.clawdbot/agents/main/agent/auth-profiles.json | grep -o '"token": *"[^"]*"' | cut -d'"' -f4)" \
  -d '{
    "model": "minimax/MiniMax-M2.1",
    "messages": [
      {
        "role": "user",
        "content": "Send Sam a brief afternoon prompt on Telegram: \"Good afternoon! 🌤️ Anything you want to note down or add to your todo list?\" - Keep it short and friendly."
      }
    ],
    "maxTokens": 50
  }' > /dev/null 2>&1

echo "Afternoon prompt sent at $(date)"
