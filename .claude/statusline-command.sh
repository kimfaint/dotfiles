#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
cur_input=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
lines_add=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_del=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Format tokens as K
tokens=$(( (total_in + total_out) / 1000 ))
tokens_fmt="${tokens}K"

# Cache hit ratio (cache_read / total input including cached)
cache_total=$(( cache_read + cur_input ))
if (( cache_total > 0 )); then
  cache_pct=$(( cache_read * 100 / cache_total ))
else
  cache_pct=0
fi

# Lines changed
lines_fmt="\033[32m+${lines_add}\033[0m \033[31m-${lines_del}\033[0m"

# Format duration as Xm Ys
duration_sec=$(( duration_ms / 1000 ))
mins=$(( duration_sec / 60 ))
secs=$(( duration_sec % 60 ))
if (( mins > 0 )); then
  dur_fmt="${mins}m ${secs}s"
else
  dur_fmt="${secs}s"
fi

# Short directory: ~ for home, basename otherwise
dir="${cwd/#$HOME/\~}"

# VCS branch (cached 5s to avoid slowdowns)
cache="/tmp/statusline-vcs-cache"
now=$(date +%s)
mtime=$(stat -c %Y "$cache" 2>/dev/null || echo 0)
vcs_status_cache="/tmp/statusline-vcs-status-cache"
if (( now - mtime > 5 )); then
  branch=$(hg branch -R "$cwd" 2>/dev/null)
  if [[ -n "$branch" ]]; then
    vcs_dirty=$(hg status -R "$cwd" 2>/dev/null | head -1)
  else
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
      vcs_dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | head -1)
    fi
  fi
  echo "$branch" > "$cache"
  echo "$vcs_dirty" > "$vcs_status_cache"
else
  branch=$(cat "$cache")
  vcs_dirty=$(cat "$vcs_status_cache")
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
# Branch + dirty indicator
if [[ -n "$branch" ]]; then
  if [[ -n "$vcs_dirty" ]]; then
    dirty_dot=" \033[33m\u25CF$reset"
  else
    dirty_dot=" \033[32m\u25CF$reset"
  fi
  branch_str=" \033[35m\u2387 $branch$reset$dirty_dot ${lines_fmt}"
else
  branch_str=""
fi

printf "\033[1m%s${reset} \033[1;34m%s${reset}${branch_str} ${color}\u25C9 ${bar} %d%%${reset} \u23F1 %s \u2022 %s \u2022 \u2B06${cache_pct}%%" "$model" "$dir" "$pct" "$dur_fmt" "$tokens_fmt"
