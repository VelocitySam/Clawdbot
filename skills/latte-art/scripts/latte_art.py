#!/usr/bin/env python3
"""Latte Art Rating - Store and track entries"""

import json
import os
from datetime import datetime
from pathlib import Path

DATA_FILE = Path.home() / ".clawd/latte-art.json"
PHOTO_DIR = Path.home() / ".clawd/latte-art-photos"

def ensure_dirs():
    DATA_FILE.parent.mkdir(parents=True, exist_ok=True)
    PHOTO_DIR.mkdir(parents=True, exist_ok=True)

def load_data():
    ensure_dirs()
    if DATA_FILE.exists():
        with open(DATA_FILE) as f:
            return json.load(f)
    return {"entries": [], "examples": {}}

def save_data(data):
    ensure_dirs()
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)

def add_entry(who, when, score_raw, breakdown, notes="", photo_path=None, example_for_rating=None):
    """Add a new latte art entry"""
    data = load_data()
    
    score_display = round(score_raw, 1)
    entry_id = len(data["entries"]) + 1
    
    entry = {
        "id": entry_id,
        "who": who,
        "when": when or datetime.utcnow().isoformat() + "Z",
        "score_display": str(score_display),
        "score_raw": round(score_raw, 2),
        "breakdown": breakdown,
        "notes": notes,
        "photo_saved": photo_path is not None,
        "example_for_rating": example_for_rating
    }
    
    data["entries"].append(entry)
    
    # Save photo if requested and this is first example for this rating
    if photo_path and example_for_rating:
        rating_int = str(int(round(score_raw)))
        if rating_int not in data["examples"]:
            import shutil
            ext = Path(photo_path).suffix
            dest = PHOTO_DIR / f"rating-{rating_int}{ext}"
            shutil.copy2(photo_path, dest)
            data["examples"][rating_int] = str(dest)
    
    save_data(data)
    return entry

def get_history():
    """Get all entries sorted by score"""
    data = load_data()
    return sorted(data["entries"], key=lambda x: x["score_raw"], reverse=True)

def get_stats():
    """Get statistics"""
    data = load_data()
    entries = data["entries"]
    if not entries:
        return None
    
    scores = [e["score_raw"] for e in entries]
    return {
        "count": len(scores),
        "avg": round(sum(scores) / len(scores), 2),
        "max": max(scores),
        "min": min(scores)
    }

def get_example(rating):
    """Get example photo for a rating"""
    data = load_data()
    rating_str = str(int(rating))
    return data["examples"].get(rating_str)

if __name__ == "__main__":
    import sys
    cmd = sys.argv[1] if len(sys.argv) > 1 else "history"
    
    if cmd == "history":
        for e in get_history():
            print(f"#{e['id']} | {e['score_display']}/10 | {e['who']} | {e['when'][:10]}")
    elif cmd == "stats":
        s = get_stats()
        if s:
            print(f"Count: {s['count']}, Avg: {s['avg']}, Max: {s['max']}, Min: {s['min']}")
        else:
            print("No entries yet")
    elif cmd == "add" and len(sys.argv) > 2:
        import argparse
        parser = argparse.ArgumentParser()
        parser.add_argument("--who", default="Sam")
        parser.add_argument("--when", default=None)
        parser.add_argument("--score", type=float, required=True)
        parser.add_argument("--notes", default="")
        parser.add_argument("--photo", default=None)
        parser.add_argument("--example-for", type=int, default=None)
        args = parser.parse_args(sys.argv[2:])
        entry = add_entry(args.who, args.when, args.score, {}, args.notes, args.photo, args.example_for)
        print(f"Entry #{entry['id']} saved with score {entry['score_display']}/10")
