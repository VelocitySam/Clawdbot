# MEMORY.md - Sam's Persistent Context

## Identity
- **Name:** Sam G
- **Username:** @velocity_engineering
- **Pronouns:** he/him
- **Timezone:** UTC
- **Founder:** Velocity Engineering
- **Location:** Copenhagen (as of 2026-01-19)

## Preferences
- **Communication:** Telegram, concise replies
- **Task Management:** Notion Todo List (database_id: 2b5009ce-b59d-8076-8610-cb340cb3930a)
- **Skills Location:** `/root/clawd/skills/`
- **API Keys Location:** `/root/clawd/` (persistent storage)

## Active Projects
- **VAT Claim:** "Solid state book" - pending (added to Notion 2026-01-19)
- **CV Update:** Pending (added to Notion 2026-01-19)
- **Simulation of target and confidence:** Pending (added to Notion 2026-01-19)

## Installed Skills
- homeassistant (v1.0.0) - Smart home control
- verify-on-browser (v1.0.0) - Chrome DevTools Protocol
- brave-search (v1.0.1) - Web search
- bird (v1.0.0) - X/Twitter (auth pending)
- notion (v1.0.0) - Notion API
- gog (v0.7.0) - Google Workspace (auth pending - remote keychain issue)
- notion-todo-sync (custom) - Auto-sync tasks to Notion
- github - GitHub CLI

## API Credentials (Persistent)
- Notion: `/root/clawd/.notion_api_key`
- Brave Search: `/root/clawd/.brave-search.env`

## Known Issues
- gog (Google Workspace) auth stored in macOS keychain, not accessible remotely
- bird (Twitter) binary has architecture issues on this system

## Behavioral Patterns
- Tasks should always sync to Notion (not kept in HEARTBEAT.md)
- Morning routine: weather check, tasks review, agenda
- Prefers CLI tools over GUIs
- Works remotely, needs persistent storage solutions

## Health & Lifestyle
- WHOOP/Garmin connected in some Clawdbot setups (not yet for Sam)

## Last Updated
2026-01-19T18:20Z
