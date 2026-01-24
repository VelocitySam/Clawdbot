#!/bin/bash
# Goodnight Script - Turn off all lights

HASS_URL="http://127.0.0.1:8123"
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiMmE3MmEzNzBiNWE0ZWUxOWIzM2Y3NGJiNWI0Y2M2ZCIsImlhdCI6MTc2ODczOTg3NSwiZXhwIjoyMDg0MDk5ODc1fQ.B_lWPqt3twbFztiQtGawVomU3viraHFL168byv1Uy9c"

# Get all light entities
lights=$(curl -s "$HASS_URL/api/states" \
  -H "Authorization: Bearer $TOKEN" | \
  grep -o '"entity_id":"light[^"]*"' | \
  sed 's/"entity_id":"//;s/"$//' | sort)

# Turn off each light
count=0
for light in $lights; do
  curl -s -X POST "$HASS_URL/api/services/light/turn_off" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"entity_id\": \"$light\"}" > /dev/null 2>&1
  count=$((count + 1))
done

echo "Goodnight! 🌙 Turned off $count lights."
