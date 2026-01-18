# Memory

## System
- Clawdbot workspace at `/root/clawd/`
- Docker persistence configured (Jan 18, 2026)

## Credentials (stored securely)
- Notion API: `ntn_bb1645418531Z2asRVrX0F7aBc9l9qoegMZ98BHThRA4kK` (in TOOLS.md)
- GitHub: PAT configured via gh CLI
- Google OAuth: `client_secret.json` at `/root/shared/`

## Skills Available
- `gog` — Google Workspace CLI (needs gog CLI installed + auth)
- `github` — GitHub CLI via gh
- `notion` — Notion API
- `web_search` — Brave Search
- `image` — MiniMax VL (image analysis)

## Pending Setup
- gog CLI: `brew install steipete/tap/gogcli`
- gog auth: `gog auth credentials /root/shared/client_secret.json`
- Claude API: needs ANTHROPIC_API_KEY env var

## Notes
- Max 3 heartbeats/day, nothing at night
- Shared folder at `/root/shared/`
- GitHub backup at `VelocitySam/Clawdbot`
