# LATTE ART RATING - STANDARD OUTPUT FORMAT

## Criteria Breakdown
| Criterion | Score | Description |
|-----------|-------|-------------|
| Symmetry | X/10 | Balance and evenness of the pattern |
| Contrast | X/10 | Visual distinction between foam and coffee |
| Definition | X/10 | Sharpness and clarity of lines/shapes |
| Flow | X/10 | Smooth transitions and fluid lines |
| Complexity | X/10 | Difficulty level of the pattern |
| Composition | X/10 | Centering, proportion, and placement |
| Visual Appeal | X/10 | Overall aesthetic impression |

## Standard Output Template

```
☕ LATTE ART RATING
═══════════════════════════════════════
📸 Photo: <filename>
👤 Barista: <name>
📅 Rated: <YYYY-MM-DD HH:MM>

CRITERIA BREAKDOWN
───────────────────────────────────────
 Symmetry         ████████░░░░░░░░░░ X.X/10
 Contrast         ██████████████████░ X.X/10
 Definition       ██████████████░░░░░ X.X/10
 Flow             ███████████████░░░░░ X.X/10
 Complexity       ██████████░░░░░░░░░ X.X/10
 Composition      ██████████████░░░░░ X.X/10
 Visual_Appeal    ███████████████░░░░░ X.X/10
───────────────────────────────────────

🏆 FINAL SCORE: X.XX/10

📈 VERDICT
   <Verdict text based on score>

DETAILED FEEDBACK:

✅ What's Good:
   • <Specific observation>
   • <Specific observation>

⚠️ What to Improve:
   • <Specific observation>
   • <Specific observation>

💡 Tips:
   • <Actionable tip>
   • <Actionable tip>

🏆 TOP 5 LEADERBOARD
───────────────────────────────────────
 🥇 Name             X.XX/10  YYYY-MM-DD HH:MM
 🥈 Name             X.XX/10  YYYY-MM-DD HH:MM
 🥉 Name             X.XX/10  YYYY-MM-DD HH:MM
 4️⃣  Name             X.XX/10  YYYY-MM-DD HH:MM
 5️⃣  Name             X.XX/10  YYYY-MM-DD HH:MM
```

## Verdict Thresholds
- 9.5+ — Perfection. Competition-winning quality!
- 9.0-9.49 — Exceptional. Near-perfect execution.
- 8.0-8.99 — Excellent. Professional level technique.
- 7.0-7.99 — Great. Strong pour with good technique.
- 6.0-6.99 — Good. Solid pour, minor improvements possible.
- 5.0-5.99 — Average. Decent, room for improvement.
- 4.0-4.99 — Below average. Technique needs work.
- 3.0-3.99 — Poor. Significant issues with execution.
- 2.0-2.99 — Very poor. Basic structure lacking.
- <2.0 — Failed. No discernible latte art.

## Weights
- Symmetry: 20%
- Contrast: 15%
- Definition: 15%
- Flow: 15%
- Complexity: 10%
- Composition: 15%
- Visual Appeal: 10%

## Usage
```bash
latte-art-rate <photo_path> -n "Barista Name"
```

## Files
- `/root/clawd/skills/latte-art/latte-art-rate` — Main script
- `/root/clawd/skills/latte-art/leaderboard.json` — Score history
- `/root/clawd/skills/latte-art/references/` — Reference photos by score
