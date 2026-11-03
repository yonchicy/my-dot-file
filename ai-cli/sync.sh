#!/bin/bash
# AI CLI 配置备份脚本（home -> dotfiles 仓库，单向生成快照）
#
# 覆盖工具：Claude Code / Codex / TraeX
# 策略：白名单（fail-closed）。只备份快捷键、状态栏、UI/TUI、主题等通用偏好。
#       明确排除：
#         - 密钥/凭证：auth.json、*token*、设备 ID、mcp_servers（可能含 token/内网地址）
#         - 模型配置：model / model_provider / model_reasoning_effort / service_tier /
#                     personality / 模型可用性记录
#         - 本机/内网痕迹：projects.* 路径、内网 marketplace、应用自动注入的 hooks、哈希状态
#       新增的配置段默认不会被备份，需在下方白名单中显式加入（避免未来意外泄密）。
#
# 用法：bash ai-cli/sync.sh
set -euo pipefail

HOME_DIR="${HOME}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$SCRIPT_DIR/claude"
CODEX_DIR="$SCRIPT_DIR/codex"
TRAE_DIR="$SCRIPT_DIR/trae"
mkdir -p "$CLAUDE_DIR" "$CODEX_DIR" "$TRAE_DIR"

# ---------- 可直接整文件复制的纯偏好文件 ----------
cp "$HOME_DIR/.claude/keybindings.json" "$CLAUDE_DIR/keybindings.json"
cp "$HOME_DIR/.claude/statusline.sh"    "$CLAUDE_DIR/statusline.sh"
cp "$HOME_DIR/.codex/keybindings.json"  "$CODEX_DIR/keybindings.json"

# ---------- 混合配置文件：白名单抽取 ----------
python3 - "$HOME_DIR" "$CLAUDE_DIR" "$CODEX_DIR" "$TRAE_DIR" <<'PY'
import json, os, re, sys

home, cdir, xdir, tdir = sys.argv[1:5]

# ========== Claude settings.json：白名单抽取，丢弃 hooks（应用自动注入）等 ==========
# 顶层键白名单；env 额外做逐键白名单（env 动态可变，严防未来混入 key/base_url/模型名）
CLAUDE_KEEP = ["enableWorkflows", "env", "language", "permissions",
               "statusLine", "theme", "tui"]
ENV_KEEP = {"API_TIMEOUT_MS", "CLAUDE_CODE_AUTO_MODE_SERVER",
            "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC"}
with open(os.path.join(home, ".claude", "settings.json")) as f:
    claude = json.load(f)
claude_out = {}
for k in CLAUDE_KEEP:
    if k not in claude:
        continue
    if k == "env":
        env = {ek: claude["env"][ek] for ek in sorted(ENV_KEEP) if ek in claude["env"]}
        if env:
            claude_out["env"] = env
    else:
        claude_out[k] = claude[k]
with open(os.path.join(cdir, "settings.json"), "w") as f:
    json.dump(claude_out, f, indent=2, ensure_ascii=False)
    f.write("\n")

# ========== TOML 行级白名单过滤（保留注释与原始格式，不做语义解析） ==========
HEADER = re.compile(r'^(\[+)\s*([^\[\]]*?)\s*\]+$')

def filter_toml(text, top_keep, section_allowed):
    """top_keep: 顶层(第一个 section 之前)保留的键集合
       section_allowed(section_name, is_array_table) -> bool"""
    lines = text.splitlines()
    out, section, in_allowed = [], None, False
    in_top = True
    for line in lines:
        m = HEADER.match(line.strip())
        if m:
            in_top = False
            is_array = m.group(1) == '[['
            section = m.group(2).strip()
            in_allowed = section_allowed(section, is_array)
            if in_allowed:
                if out and out[-1] != "":
                    out.append("")
                out.append(line)
            continue
        if in_top:
            key = line.split("=", 1)[0].strip()
            if key in top_keep:
                out.append(line)
        elif in_allowed:
            out.append(line)
    # 压缩连续空行
    compact = []
    for ln in out:
        if ln == "" and compact and compact[-1] == "":
            continue
        compact.append(ln)
    return "\n".join(compact).strip() + "\n"

# ---- Codex config.toml ----
def codex_allowed(sec, is_array):
    if is_array:
        return False  # [[skills.config]] 等数组表全部不含可移植偏好
    for blk in ("projects", "mcp_servers", "hooks.state", "marketplaces",
                "shell_environment_policy"):
        if sec == blk or sec.startswith(blk + "."):
            return False
    if sec == "desktop.open-in-target-preferences.perPath":
        return False  # 本机/远程路径
    if sec.startswith("tui.model_availability_nux"):
        return False  # 模型可用性记录
    if sec in ("features", "memories", "tui"):
        return True
    if sec == "desktop" or sec.startswith("desktop."):
        return True   # 桌面端外观/交互（已在上面排除 perPath）
    if sec == "plugins" or sec.startswith("plugins."):
        return True   # 插件启用开关
    return False

with open(os.path.join(home, ".codex", "config.toml")) as f:
    codex_text = f.read()
with open(os.path.join(xdir, "config.toml"), "w") as f:
    f.write(filter_toml(codex_text, set(), codex_allowed))

# ---- TraeX traecli.toml ----
def trae_allowed(sec, is_array):
    for blk in ("projects", "marketplaces", "hooks.state"):
        if sec == blk or sec.startswith(blk + "."):
            return False
    if sec == "features" or sec == "tui" or sec.startswith("tui."):
        return True   # 含 tui.keymap（快捷键）
    if sec == "plugins" or sec.startswith("plugins."):
        return True
    return False

TRAE_TOP_KEEP = {"default_permissions", "approval_policy", "approvals_reviewer"}
with open(os.path.join(home, ".trae", "traecli.toml")) as f:
    trae_text = f.read()
with open(os.path.join(tdir, "traecli.toml"), "w") as f:
    f.write(filter_toml(trae_text, TRAE_TOP_KEEP, trae_allowed))

print("快照已生成：")
for p in (os.path.join(cdir, "settings.json"),
          os.path.join(xdir, "config.toml"),
          os.path.join(tdir, "traecli.toml")):
    print(" -", p)
PY

echo "完成。请检查 diff 后再提交。"
