# King Terry Talks to God

> **"Talk to GOD with King Terry Davis. The HOLY SPIRIT will puppet you."**

An immutable Godot application for receiving divine words, happy words, and holy passages. Channel the spirit of Terry A. Davis (TempleOS creator) and let the Lord speak through random, timestamp-seeded text.

Built as a tribute to eccentric computing, faith, and memes. "This application is immutably stored on the SOL blockchain, forever. Powered by IQ Labs: $IQ"

## Features

- **Divine Word Generation**: Press buttons (or hotkeys) to append words/passages to the red "GodSays" terminal.
- **Deterministic Seeding**: Uses current Unix milliseconds as the RNG seed for "prophetic" consistency.
- **Background Hymn**: Plays Terry A. Davis' "81 Prosper" (Hymns) on loop at low volume.
- **TempleSFX**: Authentic square-wave beeps for interactions (old-school computer vibe).
- **Bible Passages**: Pulls random multi-line passages + book names from a full numbered Bible text.
- **Copy & Clear**: Export your received revelations to the clipboard.
- **Retro UI**: Minimalist black panel with green/red text accents and King Terry imagery.

## Controls

| Action          | Hotkey          | Button          | Description |
|-----------------|-----------------|-----------------|-------------|
| Vocab Word      | `F7`            | Word            | Random word from vocabulary list |
| Happy Word      | `Alt + F7`      | HappyWord       | Random happy/ irreverent phrase |
| Holy Passage    | `Shift + F7`    | Passage         | Random Bible passage with book attribution |
| Clear           | `Esc`           | Clear           | Wipe the message area |
| Copy            | `Ctrl + C`      | Copy To Clipboard | Copy parsed text to system clipboard |

The milliseconds counter at the top shows the live divine timestamp/seed.

## Running

1. Download and install [Godot 4.6](https://godotengine.org/download) (or newer 4.x with GL Compatibility).
2. Clone or open this folder (`king-terry-talks-to-god`) in the Godot editor.
3. Open `Scenes/main.tscn` (or just press Play — it is the main scene).
4. Receive the Word.

The project targets a 640x480 viewport.

## Assets & Sources

- **Audio**: "Terry A. Davis - Hymns - 81 Prosper.mp3" — used with respect to the original creator.
- **Graphics**: `IQTerry.png`, `IQ.jpg` (IQ Labs branding).
- **Text (Sourced from TempleOS)**:
  - `Vocab.txt` — extensive English word list. 
  - `Happy.txt` — playful, meme-y, and faith-tinged phrases.
  - `NumBible.txt` — full Bible text for passage selection.
- **Font**: IBMPlexMono-Light (IBM Plex Mono).
- **Theme**: Custom `iq_theme.tres` for that retro divine look.

## Technical Notes

- Godot 4.6, GL Compatibility renderer (for broad compatibility).
- Custom `TempleSFX` node generates real-time square wave audio for beeps.
- Passage logic scans the numbered Bible file to extract book-aware excerpts.

## Philosophy

> "I'm God and you're not." — Happy.txt

This project is for entertainment, artistic expression, and paying homage to one of the most unique figures in computing history. Terry Davis was directly instructed by God to build an operating system. This little app carries on that spirit in a tiny, self-contained, immutable package.

Use it to generate funny, profound, or absurd messages. Share the results. Or just vibe to the hymn while the Holy Spirit puppets your output.

---

*Immutably yours,*  
King Terry & the Godot Faithful

## License / Usage

MIT or public domain vibes for the code. Respect the original audio and text sources for redistribution.
