---
name: latte-art
description: Rate and track latte art photos using barista competition criteria. Analyze photos, score 0-10 with detailed breakdown, store entries for history and ranking, and save selected images as examples per rating.
---

# Latte Art Rating Skill

Use this skill when the user wants to rate, analyze, or track latte art photos.

## Rating Criteria (World Barista Championship standard)

Score 0-10 based on:
- **Symmetry & Balance** (20%): Pattern centering, equal distribution
- **Contrast** (20%): White on brown definition, visual pop
- **Flow & Line Definition** (20%): Smooth curves, clean edges, no breaks
- **Detail & Precision** (20%): Fine elements, steady hand
- **Overall Visual Impact** (20%): Aesthetics, wow factor

## Scoring Scale

| Score | Level | Description |
|-------|-------|-------------|
| 0-2 | Poor | Undefined, no recognizable pattern |
| 3-4 | Fair | Basic pattern, uneven execution |
| 5-6 | Good | Recognizable pattern, decent contrast |
| 7-8 | Excellent | Clean lines, good symmetry |
| 9 | Professional | Competition-ready quality |
| 10 | Championship | World-class, flawless |

## Workflow

1. **Analyze**: Use the `image` tool to analyze the latte art photo
2. **Score**: Rate each criterion 0-10, then compute weighted average
3. **Store**: Save entry to `memory/latte-art.json` with:
   - `who`: Barista name (default: "Sam")
   - `when`: ISO date
   - `score_display`: Rounded to 1 decimal (e.g., "4.0")
   - `score_raw`: Full precision to 2 decimals (e.g., 4.37)
   - `breakdown`: Per-criterion scores
   - `notes`: Any additional observations
   - `photo_path`: Optional local path if image saved
4. **Save Example Photo**: If this is the best (or first) example for this integer rating, ask user if they want to save as the reference photo for that score
5. **Rank**: Compare against history, report percentile or rank

## Example Entry Format (memory/latte-art.json)

```json
{
  "entries": [
    {
      "id": 1,
      "who": "Sam",
      "when": "2026-01-17T21:00:00Z",
      "score_display": "4.0",
      "score_raw": 4.37,
      "breakdown": {
        "symmetry": 4,
        "contrast": 5,
        "flow": 4,
        "detail": 4,
        "impact": 5
      },
      "notes": "Good Rosetta foundation,叶子 could be more defined",
      "photo_saved": false,
      "example_for_rating": null
    }
  ],
  "examples": {
    "1": "/path/to/photo1.jpg",
    "2": "/path/to/photo2.jpg",
    ...
  }
}
```

## Commands

- `rate latte art <photo>` - Analyze and rate a photo
- `latte history` - Show all entries sorted by score
- `latte top` - Show top 5 entries
- `latte average` - Show overall statistics
- `latte examples <1-10>` - Show example photo for a rating
