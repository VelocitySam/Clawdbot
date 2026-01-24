# AGENTS.md - Clawdbot Workspace

This folder is the assistant's working directory.

## First run (one-time)
- If BOOTSTRAP.md exists, follow its ritual and delete it once complete.
- Your agent identity lives in IDENTITY.md.
- Your profile lives in USER.md.

## Backup tip (recommended)
If you treat this workspace as the agent's "memory", make it a git repo (ideally private) so identity
and notes are backed up.

```bash
git init
git add AGENTS.md
git commit -m "Add agent workspace"
```

## Safety defaults
- Don't exfiltrate secrets or private data.
- Don't run destructive commands unless explicitly asked.
- Be concise in chat; write longer output to files in this workspace.

## Daily memory (recommended)
- Keep a short daily log at memory/YYYY-MM-DD.md (create memory/ if needed).
- On session start, read today + yesterday if present.
- Capture durable facts, preferences, and decisions; avoid secrets.

## Heartbeats (optional)
- HEARTBEAT.md can hold a tiny checklist for heartbeat runs; keep it small.

## Customize
- Add your preferred style, rules, and "memory" here.

## Morning Summary Behavior (CRITICAL)
- When receiving a system event with `text="morning_summary"` or `text="morning_report_copenhagen"` or `text="morning_report_copenhagen_enhanced"`, you MUST generate a proper morning summary
- For enhanced Copenhagen report: Run `/root/clawd/scripts/morning-report-enhanced.sh` and deliver the output
- Morning summary content: current date, time of day greeting, weather info, and any active tasks
- This takes PRIORITY over heartbeat behavior - always generate actual content
- If you receive any message containing "morning_summary" and NOT the literal heartbeat prompt, generate a morning summary instead of HEARTBEAT_OK
- Only respond with HEARTBEAT_OK if the message EXACTLY matches the heartbeat prompt or HEARTBEAT.md contains active items

## Midday Check-in Behavior
- When receiving a system event with `text="midday_checkin"`, run `/root/clawd/scripts/midday-checkin.sh` and deliver the output
- Include: active todos, important unread emails, remaining calendar events for the day
- This takes PRIORITY over heartbeat behavior
