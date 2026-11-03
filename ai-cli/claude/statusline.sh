#!/bin/bash
# Claude Code statusline 脚本
# Claude Code 通过 stdin 传入会话 JSON，脚本输出要显示的内容到 stdout
input=$(cat)
[ -z "$input" ] && exit 0

# --- Starship 风格提示符（来自 ~/.config/starship.toml，用户 shell 提示符）---
BOLD_GREEN='\033[1;32m'
BOLD_CYAN='\033[1;36m'
BOLD_PURPLE='\033[1;35m'
BOLD_YELLOW='\033[1;33m'
RESET='\033[0m'

cwd=$(printf %s "$input" | jq -r '.workspace.current_dir // empty')
[ -n "$cwd" ] || cwd="$PWD"

# os 符号（Macos 󰀵，bold green）
out="$(printf "${BOLD_GREEN}󰀵${RESET}")"

# directory（󰉋 路径，~ 缩写，bold cyan）
dir=$(printf %s "$cwd" | sed "s|^$HOME|~|")
out="$out$(printf " ${BOLD_CYAN}󰉋 %s${RESET}" "$dir")"

# git branch（Starship 默认分支符号 ，bold purple）
branch=$(printf %s "$input" | jq -r '.workspace.git_worktree // empty')
if [ -z "$branch" ]; then
  branch=$(git --no-optional-locks -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
fi
if [ -n "$branch" ]; then
  out="$out$(printf " ${BOLD_PURPLE} %s${RESET}" "$(basename "$branch")")"
fi

# python（Python 项目中显示版本，bold yellow）
if [ -f "$cwd/pyproject.toml" ] || [ -f "$cwd/requirements.txt" ] || [ -f "$cwd/setup.py" ] || [ -f "$cwd/Pipfile" ] || [ -d "$cwd/.venv" ]; then
  pyv=$(python3 -c 'import sys;print(sys.version.split()[0])' 2>/dev/null)
  [ -n "$pyv" ] && out="$out$(printf " ${BOLD_YELLOW}via  %s${RESET}" "$pyv")"
fi

# character（success_symbol ，bold green）
out="$out$(printf " ${BOLD_GREEN}${RESET}")"

# --- 基础信息 ---
model=$(printf %s "$input" | jq -r '.model.display_name // empty')
used=$(printf %s "$input" | jq -r '.context_window.used_percentage // empty')
in_tok=$(printf %s "$input" | jq -r '.context_window.total_input_tokens // 0')
out_tok=$(printf %s "$input" | jq -r '.context_window.total_output_tokens // 0')
mid=$(printf %s "$input" | jq -r '.model.id // empty')

# --- 费用估算（按模型单价：输入/输出每百万 token）---
case "$mid" in
  *opus*)  ip=15;   op=75 ;;
  *haiku*) ip=0.80; op=4  ;;
  *)       ip=3;    op=15 ;;
esac
cost=$(awk -v i="$in_tok" -v o="$out_tok" -v a="$ip" -v b="$op" \
  'BEGIN{printf "%.4f", i/1000000*a + o/1000000*b}')

# --- 数字缩写：12345 -> 12.3k，2500000 -> 2.5m ---
fmt_tok() {
  awk -v n="$1" 'BEGIN{
    if (n >= 1000000) printf "%.1fm", n/1000000
    else if (n >= 1000) printf "%.1fk", n/1000
    else printf "%d", n
  }'
}

# --- 上下文使用百分比（不显示进度条）---
if [ -n "$used" ]; then
  ctx_pct="$(printf '%.0f' "$used")%"
else
  ctx_pct="--"
fi

# 推理 effort（紧跟模型显示）
effort=$(printf %s "$input" | jq -r '.effort.level // empty')

out="$out 🤖 $model"
if [ -n "$effort" ]; then out="$out ⚡ $effort"; fi
out="$out | 📊 ctx $ctx_pct | 📥 in $(fmt_tok "$in_tok") | 📤 out $(fmt_tok "$out_tok") | 💰 \$$cost"

# --- 追加可选信息（有数据才显示）---

# Git 仓库 owner/name
repo=$(printf %s "$input" | jq -r '.workspace.repo | if . then .owner + "/" + .name else empty end')
if [ -n "$repo" ]; then out="$out | 📦 $repo"; fi

# 项目目录名
pdir=$(printf %s "$input" | jq -r '.workspace.project_dir // empty')
if [ -n "$pdir" ]; then out="$out | 📁 $(basename "$pdir")"; fi

# 输出风格（非 default 才显示）
style=$(printf %s "$input" | jq -r '.output_style.name // empty')
if [ -n "$style" ] && [ "$style" != "default" ]; then out="$out | 🎨 $style"; fi

# Vim 模式
vim=$(printf %s "$input" | jq -r '.vim.mode // empty')
if [ -n "$vim" ]; then out="$out | ✍️ $vim"; fi

# 会话名
sname=$(printf %s "$input" | jq -r '.session_name // empty')
if [ -n "$sname" ]; then out="$out | 💬 $sname"; fi

# 订阅额度 5h / 7d
five=$(printf %s "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(printf %s "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$five" ] || [ -n "$week" ]; then
  rl=""
  [ -n "$five" ] && rl="5h:$(printf '%.0f' "$five")%"
  [ -n "$week" ] && rl="${rl} 7d:$(printf '%.0f' "$week")%"
  out="$out | ⏳ $rl"
fi

# Agent 名
agent=$(printf %s "$input" | jq -r '.agent.name // empty')
if [ -n "$agent" ]; then out="$out | 👤 $agent"; fi

# PR 号及评审状态
pr=$(printf %s "$input" | jq -r '.pr.number // empty')
if [ -n "$pr" ]; then
  st=$(printf %s "$input" | jq -r '.pr.review_state // "open"')
  out="$out | 🔀 PR#$pr($st)"
fi

printf '%s\n' "$out"
