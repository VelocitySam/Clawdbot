# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

## Home Assistant
- **URL (from Docker):** `http://172.17.0.1:8123`
- **URL (LAN):** `http://192.168.0.32:8123`
- **Token:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjMTEwY2I0NDNlMzg0NGI4OTkyZjc2MmQxMmQ1N2IxZCIsImlhdCI6MTc2ODEzOTcwMCwiZXhwIjoyMDgzNDk5NzAwfQ.1bt5ASJMDBf4dUTNvhIRE2bRxsPKNj32WchZLQU1H0Y`

### Notable devices
- **Lights:** kitchen_1, ph5, gang, hue_go_1, flower_pot, klemme, gaggiuino_coffee_machine
- **Scenes:** stue_slap_af, stue_dimmed, gang_bright, kontor_slap_af

---

## Notion
- **API Key:** `ntn_bb1645418531Z2asRVrX0F7aBc9l9qoegMZ98BHThRA4kK`
- **Config path:** `~/.config/notion/api_key`

---

Add whatever helps you do your job. This is your cheat sheet.
