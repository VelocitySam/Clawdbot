# Latte Art Rating Skill

Rate and score latte art photos with detailed breakdown of evaluation criteria.

## Research: What Makes Perfect Latte Art

### Key Scoring Criteria (World Champion Level)

Based on barista competition standards:

| Criterion | Description | Weight |
|-----------|-------------|--------|
| **Symmetry** | Perfect mirror symmetry, no deviation | 20% |
| **Contrast** | Crisp white on dark brown, no ghosting | 15% |
| **Definition** | Razor-sharp edges, clean cuts | 15% |
| **Flow** | Fluid, organic movement in lines | 15% |
| **Complexity** | Advanced patterns, fine details | 10% |
| **Composition** | Perfectly centered, ideal proportions | 15% |
| **Visual Appeal** | Competition-worthy presentation | 10% |

### Scoring Scale (Strict)

- **10.00** — WORLD CHAMPION. Magazine cover quality. Flawless.
- **9.00-9.99** — Exceptional. Competition finalist level.
- **8.00-8.99** — Excellent. Professional barista quality.
- **7.00-7.99** — Good. Strong home barista skills.
- **6.00-6.99** — Average. Decent but obvious room for improvement.
- **5.00-5.99** — Below Average. Basic technique issues.
- **4.00-4.99** — Poor. Significant problems.
- **3.00-3.99** — Very Poor. Little skill demonstrated.
- **2.00-2.99** — Failed. Barely recognizable.
- **1.00-1.99** — No latte art. Failed attempt.

### Reference Photos

Reference photos in `references/` folder show what each score looks like:
- `score-10.jpg` — World champion level
- `score-9.jpg` — Competition finalist
- `score-8.jpg` — Professional quality
- `score-7.jpg` — Good home barista
- `score-6.jpg` — Average, needs work
- `score-5.jpg` — Below average
- `score-4.jpg` — Poor technique
- `score-3.jpg` — Very poor
- `score-2.jpg` — Failed attempt
- `score-1.jpg` — No art at all

## Usage

```bash
latte-art-rate <photo_path>
```

### Example Output

```
☕ LATTE ART RATING
═══════════════════════════════════════
📸 Photo: espresso_2024-01-18.jpg
👤 Barista: Sam
📅 Rated: 2024-01-18 14:30

CRITERIA BREAKDOWN
───────────────────────────────────────
 Symmetry         ███████████████░░░░░ 8.5/10
 Contrast         ████████████████░░░░░ 9.0/10
 Definition       ██████████████░░░░░░ 8.0/10
 Flow             ███████████████░░░░░░ 8.5/10
 Complexity       ████████████░░░░░░░░ 7.5/10
 Composition      ██████████████░░░░░░ 8.0/10
 Visual_Appeal    ███████████████░░░░░░ 8.5/10
───────────────────────────────────────

🏆 FINAL SCORE: 8.29/10

📈 VERDICT
   Excellent. Professional level technique.

DETAILED FEEDBACK:

✅ What's Good:
   • Perfect microfoam with excellent contrast
   • Smooth, fluid lines throughout
   • Well-centered in the cup

⚠️ What to Improve:
   • Slight asymmetry in the base layer
   • Middle cut could be sharper

💡 Tips:
   • Keep pitcher more centered when pouring
   • Lift higher and cut faster for crisp lines

🏆 TOP 5 LEADERBOARD
───────────────────────────────────────
 🥇 Sam             8.29/10  2024-01-18 14:30
 🥈 Morten          7.85/10  2024-01-17 09:15
```

## AI Integration

For detailed AI analysis, use the image tool:
```python
image.ask(prompt="Analyze this latte art for: symmetry, contrast, definition, flow, complexity, composition, visual_appeal (scores 1-10), what's good, what to improve, tips")
```

Then pass the JSON response to the skill:
```bash
latte-art-rate photo.jpg --scores '{"symmetry": 7.0, "contrast": 9.0, ...}'
```

## Setup

No dependencies required. Uses basic image analysis.

## Notes

- Photos should be well-lit and centered on the cup
- Best results with 1:1 or 4:3 aspect ratios
- Compare to reference photos for calibration
