---
description: "Capture a URL, thought, or reference to the FOMO intake — zero-friction idea capture"
disabled-model-invocation: true
allowed-tools: Read, Write, Edit, WebSearch
---

Quick-capture a URL, thought, or reference to the FOMO links log. No processing, no categorization. Just capture.

## Usage

- `/fomo <url>` — captures URL with auto-fetched title
- `/fomo <url> #tag` — same, with an optional tag for loose grouping
- `/fomo <free text>` — captures a thought or reference without a URL

## Workflow

### Step 1: Parse input

From the arguments, determine:
- **URL** — if the input starts with `http://` or `https://`, extract it
- **Tag** — if `#word` appears anywhere, extract it as a tag
- **Text** — everything that isn't a URL or tag is the description

### Step 2: Enrich (URLs only)

If a URL was provided, try to fetch the page title:
1. Use `WebSearch` with the URL as query to get the title
2. If that fails, use the URL as-is

### Step 3: Format the entry

Format: `- YYYY-MM-DD HH:MM | <content> [#tag]`

Examples:
- `- 2026-03-27 14:30 | https://example.com/article — "Article Title" #ai`
- `- 2026-03-27 14:30 | Look into stigmergy patterns in software architecture #spark`
- `- 2026-03-27 14:30 | https://github.com/user/repo — interesting approach to memory consolidation`

### Step 4: Append to links.md

Read `<KNOWLEDGE_DIR>/fomo/links.md`, append the new entry at the end.

### Step 5: Confirm

Output: `Captured to FOMO inbox.` with the formatted entry shown. One line. No fanfare.
