---
name: notion-todo-sync
description: Automatically sync tasks to Notion. Use when tasks are added to HEARTBEAT.md - always add them to Sam's Notion Todo List database instead of keeping them in HEARTBEAT.md.
---

# Notion Todo Sync

Automatically sync tasks from HEARTBEAT.md to Sam's Notion Todo List.

## When to Use

- User asks to add a task or todo → Always sync to Notion
- User mentions tasks in conversation → Add to Notion
- HEARTBEAT.md contains tasks → Clear after syncing to Notion

## Notion Database

- **Database ID:** `2b5009ce-b59d-8076-8610-cb340cb3930a`
- **API Key:** `/root/clawd/.notion_api_key`

## Syncing Tasks

```bash
# Add task to Notion
NOTION_KEY=$(cat /root/clawd/.notion_api_key)
curl -X POST "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer $NOTION_KEY" \
  -H "Notion-Version: 2025-09-03" \
  -H "Content-Type: application/json" \
  -d '{
    "parent": {"database_id": "2b5009ce-b59d-8076-8610-cb340cb3930a"},
    "properties": {
      "Task name": {"title": [{"text": {"content": "Task description"}}]},
      "Status": {"status": {"name": "Not started"}}
    }
  }'
```

## Workflow

1. Read HEARTBEAT.md for pending tasks
2. Add each task to Notion with "Not started" status
3. Clear HEARTBEAT.md after successful sync
4. Confirm task was added to Notion

## Notes

- Tasks are added with "Not started" status
- Assignee is set to Clawdbot bot
- Clear HEARTBEAT.md after all tasks are synced
- Always confirm tasks were added successfully
