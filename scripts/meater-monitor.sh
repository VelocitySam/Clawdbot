#!/bin/bash
# MEATER Probe Monitor - Alerts when internal temp reaches 70°C

HA_URL="http://127.0.0.1:8123"
HA_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJiMmE3MmEzNzBiNWE0ZWUxOWIzM2Y3NGJiNWI0Y2M2ZCIsImlhdCI6MTc2ODczOTg3NSwiZXhwIjoyMDg0MDk5ODc1fQ.B_lWPqt3twbFztiQtGawVomU3viraHFL168byv1Uy9c"
ENTITY="sensor.meater_probe_3031a82e_internal_temperature"
TARGET_TEMP=70
CHECK_INTERVAL=600  # 10 minutes

echo "🍖 MEATER Monitor started - watching for ${TARGET_TEMP}°C"
echo "Press Ctrl+C to stop"
echo ""

while true; do
    # Get current temperature
    TEMP=$(curl -s -H "Authorization: Bearer $HA_TOKEN" \
        "${HA_URL}/api/states/${ENTITY}" | grep -oP '"state":"[^"]+' | cut -d'"' -f4)

    if [ -z "$TEMP" ]; then
        echo "[$(date '+%H:%M:%S')] ⚠️ Could not read temperature"
    else
        DECIMAL_TEMP=$(printf "%.1f" "$TEMP")
        echo "[$(date '+%H:%M:%S')] 🌡️  Current: ${DECIMAL_TEMP}°C"

        # Check if target reached
        if (( $(echo "$TEMP >= $TARGET_TEMP" | bc -l) )); then
            echo ""
            echo "🎯 TARGET REACHED: ${DECIMAL_TEMP}°C"
            echo "🔥 Meat is done! Take it off the heat!"
            # Send notification (optional - depends on your setup)
            exit 0
        fi
    fi

    sleep $CHECK_INTERVAL
done
