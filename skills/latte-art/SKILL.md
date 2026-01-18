# Latte Art Rating Skill

Rate and score latte art photos with detailed breakdown of evaluation criteria.

## Research: What Makes Perfect Latte Art

### Key Scoring Criteria

Based on barista competition standards and professional evaluation:

| Criterion | Description | Weight |
|-----------|-------------|--------|
| **Symmetry** | Balance and evenness of the pattern | 20% |
| **Contrast** | Visual distinction between foam and coffee | 15% |
| **Definition** | Sharpness and clarity of lines/shapes | 15% |
| **Flow** | Smooth transitions and fluid lines | 15% |
| **Complexity** | Difficulty level of the pattern | 10% |
| **Composition** | Centering, proportion, and placement | 15% |
| **Visual Appeal** | Overall aesthetic impression | 10% |

### Scoring Scale (1-10)

- **10.00** — Perfect. Competition-worthy, magazine quality
- **9.00-9.99** — Exceptional. Near-perfect execution
- **8.00-8.99** — Excellent. Professional level
- **7.00-7.99** — Great. Strong technique
- **6.00-6.99** — Good. Solid pour with minor issues
- **5.00-5.99** — Average. Decent but room for improvement
- **4.00-4.99** — Below average. Clear technique issues
- **3.00-3.99** — Poor. Significant problems
- **2.00-2.99** — Very poor. Basic structure lacking
- **1.00-1.99** — Failed. Little to no latte art

### Reference Photos

Place reference photos in `references/` folder:
- `score-10.jpg` — Perfect rosetta or tulip
- `score-9.jpg` — Nearly perfect, minor edge issue
- `score-8.jpg` — Excellent symmetry and flow
- `score-7.jpg` — Good pattern, slight asymmetry
- `score-6.jpg** — Acceptable pour, visible issues
- `score-5.jpg` — Basic pattern, needs work
- `score-4.jpg` — Weak attempt, unclear pattern
- `score-3.jpg` — Poor structure, bad flow
- `score-2.jpg** — Barely recognizable
- `score-1.jpg` — No discernible art

## Usage

```bash
latte-art-rate <photo_path>
```

### Example Output

```
☕ LATTE ART RATING
═══════════════════════════════════════

📸 Photo: espresso_2024-01-18.jpg

CRITERIA BREAKDOWN
───────────────────────────────────────
 Symmetry ............... 8.5/10
 Contrast ............... 9.0/10
 Definition ............. 8.0/10
 Flow ................... 8.5/10
 Complexity ............. 7.5/10
 Composition ............ 8.0/10
 Visual Appeal .......... 8.5/10
───────────────────────────────────────

🏆 FINAL SCORE: 8.29/10

📈 VERDICT: Excellent. Professional level technique.
```

## Setup

No dependencies required. Uses basic image analysis.

## Notes

- Photos should be well-lit and centered on the cup
- Best results with 1:1 or 4:3 aspect ratios
- Compare to reference photos for calibration
