#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')

# Short directory: ~ for home, basename otherwise
dir="${cwd/#$HOME/\~}"

# Hg branch (cached 5s to avoid slowdowns)
cache="/tmp/statusline-hg-cache"
now=$(date +%s)
mtime=$(stat -c %Y "$cache" 2>/dev/null || echo 0)
if (( now - mtime > 5 )); then
  branch=$(hg branch -R "$cwd" 2>/dev/null)
  echo "$branch" > "$cache"
else
  branch=$(cat "$cache")
fi

# Context bar: 10 chars
filled=$(( pct / 10 ))
empty=$(( 10 - filled ))
bar=$(printf '%0.s█' $(seq 1 $filled 2>/dev/null))
bar+=$(printf '%0.s░' $(seq 1 $empty 2>/dev/null))

# Color: green <70, yellow 70-89, red 90+
if (( pct >= 90 )); then
  color="\033[31m"
elif (( pct >= 70 )); then
  color="\033[33m"
else
  color="\033[32m"
fi
reset="\033[0m"

# Branch display
if [[ -n "$branch" ]]; then
  branch_str=" \033[35m\u2387 $branch$reset"
else
  branch_str=""
fi

printf "\033[1m%s${reset} \033[1;34m%s${reset}${branch_str} ${color}\u25C9 ${bar} %d%%${reset}" "$model" "$dir" "$pct"
