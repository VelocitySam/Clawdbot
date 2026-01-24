#!/bin/bash
# Auto backup script for Clawd workspace

cd ~/clawd
git add -A
git commit -m "Auto backup - $(date '+%Y-%m-%d %H:%M')" 2>/dev/null || exit 0
git push origin master 2>/dev/null || echo "Nothing to push"
