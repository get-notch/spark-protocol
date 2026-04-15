#!/bin/bash
set -euo pipefail

# Spark Protocol Installer
# Interactive setup: resolves paths, replaces placeholders, installs skills

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "=== Spark Protocol Installer ==="
echo ""
echo "This will set up the spark protocol for your Claude Code environment."
echo "You'll need: Claude Code installed, a directory for your knowledge base."
echo ""

# --- Step 1: Gather paths ---

# Commands directory
default_commands="$HOME/.claude/commands"
printf "Claude Code commands directory [%s]: " "$default_commands"
read -r commands_input
COMMANDS_DIR="${commands_input:-$default_commands}"

# Knowledge directory
default_knowledge="$HOME/knowledge"
printf "Knowledge base directory (ideas, sparks, signals, daylog, fomo) [%s]: " "$default_knowledge"
read -r knowledge_input
KNOWLEDGE_DIR="${knowledge_input:-$default_knowledge}"

# Memory directory — try to auto-detect
echo ""
memory_dirs=()
if [ -d "$HOME/.claude/projects" ]; then
    while IFS= read -r d; do
        memory_dirs+=("$d")
    done < <(find "$HOME/.claude/projects" -maxdepth 2 -name "memory" -type d 2>/dev/null)
fi

if [ ${#memory_dirs[@]} -eq 1 ]; then
    echo "Found Claude Code memory directory:"
    echo "  ${memory_dirs[0]}"
    printf "Use this? [Y/n]: "
    read -r use_detected
    if [ "$(echo "$use_detected" | tr '[:upper:]' '[:lower:]')" = "n" ]; then
        printf "Memory directory path: "
        read -r MEMORY_DIR
    else
        MEMORY_DIR="${memory_dirs[0]}"
    fi
elif [ ${#memory_dirs[@]} -gt 1 ]; then
    echo "Found multiple Claude Code memory directories:"
    for i in "${!memory_dirs[@]}"; do
        echo "  $((i+1)). ${memory_dirs[$i]}"
    done
    printf "Which one? [1-%d]: " "${#memory_dirs[@]}"
    read -r choice
    idx=$((choice - 1))
    if [ "$idx" -ge 0 ] && [ "$idx" -lt "${#memory_dirs[@]}" ]; then
        MEMORY_DIR="${memory_dirs[$idx]}"
    else
        echo "Invalid choice. Please enter the path manually."
        printf "Memory directory path: "
        read -r MEMORY_DIR
    fi
else
    echo "No Claude Code memory directory detected."
    echo "This is usually: ~/.claude/projects/<your-project-slug>/memory"
    printf "Memory directory path: "
    read -r MEMORY_DIR
fi

# Expand ~ if present
COMMANDS_DIR="${COMMANDS_DIR/#\~/$HOME}"
KNOWLEDGE_DIR="${KNOWLEDGE_DIR/#\~/$HOME}"
MEMORY_DIR="${MEMORY_DIR/#\~/$HOME}"

echo ""
echo "--- Configuration ---"
echo "  Commands:  $COMMANDS_DIR"
echo "  Knowledge: $KNOWLEDGE_DIR"
echo "  Memory:    $MEMORY_DIR"
echo ""
printf "Proceed? [Y/n]: "
read -r proceed
if [ "$(echo "$proceed" | tr '[:upper:]' '[:lower:]')" = "n" ]; then
    echo "Aborted."
    exit 0
fi

# --- Step 2: Create directories ---

echo ""
echo "[Directories] Setting up knowledge base"
for dir in ideas sparks signals daylog fomo/inbox fomo/processed; do
    mkdir -p "$KNOWLEDGE_DIR/$dir"
done
echo "  Created: ideas/ sparks/ signals/ daylog/ fomo/"

if [ ! -f "$KNOWLEDGE_DIR/fomo/links.md" ]; then
    cat > "$KNOWLEDGE_DIR/fomo/links.md" << 'FOMO_EOF'
# FOMO Links

Append-only log of captured URLs, thoughts, and references. Captured via `/fomo` skill or manual paste.

Format: `- YYYY-MM-DD HH:MM | <content> [#tag]`

---
FOMO_EOF
    echo "  Created: fomo/links.md"
fi

# --- Step 3: Install skills with resolved paths ---

echo ""
echo "[Skills] Installing to $COMMANDS_DIR"
mkdir -p "$COMMANDS_DIR"

# Escape paths for sed (handle / in paths)
escaped_knowledge=$(printf '%s' "$KNOWLEDGE_DIR" | sed 's/[&/\]/\\&/g')
escaped_memory=$(printf '%s' "$MEMORY_DIR" | sed 's/[&/\]/\\&/g')

for skill in "$SCRIPT_DIR"/skills/spark.md "$SCRIPT_DIR"/skills/fomo.md "$SCRIPT_DIR"/skills/daydream.md "$SCRIPT_DIR"/skills/dream-spark.md "$SCRIPT_DIR"/skills/ideate.md "$SCRIPT_DIR"/skills/delve.md; do
    name=$(basename "$skill")
    # Replace placeholders and install
    sed -e "s|<KNOWLEDGE_DIR>|$KNOWLEDGE_DIR|g" \
        -e "s|<MEMORY_DIR>|$MEMORY_DIR|g" \
        "$skill" > "$COMMANDS_DIR/$name"
    echo "  [installed] $name"
done

# --- Step 4: Set up cross-session state ---

echo ""
echo "[Memory] Setting up cross-session state"

if [ ! -f "$MEMORY_DIR/dream-sparks.md" ]; then
    cat > "$MEMORY_DIR/dream-sparks.md" << 'DREAM_EOF'
---
name: Dream Sparks
description: Cross-references and unexpected connections surfaced during dream consolidation and daydreams — fuel for ideate sessions
type: reference
---

# Dream Sparks

Last dream cycle: never

DREAM_EOF
    echo "  Created: dream-sparks.md"
else
    echo "  Exists: dream-sparks.md (keeping existing data)"
fi

# --- Done ---

echo ""
echo "=== Installed ==="
echo ""
echo "Skills installed:  spark, fomo, daydream, dream-spark, ideate, delve"
echo "Knowledge base:    $KNOWLEDGE_DIR"
echo "Memory:            $MEMORY_DIR"
echo ""
echo "Get started:"
echo "  /ideate                — activate divergent mode"
echo "  /spark <anchor>        — start a divergent thinking session"
echo "  /fomo <url or thought> — capture something interesting"
echo "  /delve                 — process FOMO captures into resonance"
echo "  /daydream <whisper>    — trigger a background micro-spark"
echo "  /dream-spark           — cross-reference your full memory pool"
echo ""
echo "Tip: Start with /ideate, then /spark with whatever is on your mind."
