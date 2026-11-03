# AI CLI 配置备份

Claude Code、Codex、TraeX 三款 AI CLI 的**可移植偏好**备份：快捷键、状态栏、TUI/界面、主题等。

> ⚠️ 安全策略：白名单（fail-closed）。**绝不备份密钥/凭证与模型配置**。
> 配置文件里新出现的字段默认不会被同步，必须在 `sync.sh` 白名单里显式加入。

## 更新快照（日常维护）

改了本机配置后，在本目录运行：

```bash
bash ai-cli/sync.sh
```

脚本是 **home → 本仓库** 的单向脱敏生成，幂等，可反复执行。跑完用 `git diff` 复核，再提交。

## 文件与来源

| 仓库文件 | 来源 | 说明 |
| --- | --- | --- |
| `claude/keybindings.json` | `~/.claude/keybindings.json` | 快捷键（完整复制） |
| `claude/statusline.sh` | `~/.claude/statusline.sh` | 状态栏脚本（完整复制） |
| `claude/settings.json` | `~/.claude/settings.json` | 仅保留 env 白名单键、language、permissions、statusLine、theme、tui |
| `codex/keybindings.json` | `~/.codex/keybindings.json` | 快捷键（完整复制） |
| `codex/config.toml` | `~/.codex/config.toml` | 仅保留 features、desktop 外观、memories、tui（含状态栏）、plugins 开关 |
| `trae/traecli.toml` | `~/.trae/traecli.toml` | 仅保留权限策略、features、tui（含 `tui.keymap` 快捷键）、plugins 开关 |

## 明确不备份的内容

- **凭证**：`auth.json`、`*-jwt-token`、设备/崩溃上报 ID、`mcp_servers.*`（可能含 token 或内网地址）。
- **模型配置**：`model`、`model_provider`、`model_reasoning_effort`、`service_tier`、`personality`、模型可用性记录。
  - 注：`codex/config.toml` 状态栏里的 `model-with-reasoning` 是**状态栏组件名**，`show-ultra-in-model-picker-slider` 是**界面开关**，均非模型选择，故保留。
- **本机/内网痕迹**：`projects.*` 信任路径、内网 marketplace（如 `code.byted.org`）、含本机路径的 `desktop...perPath`、`[[skills.config]]`。
- **应用自动注入项**：各 `hooks.json` / settings 里的 `hooks`（Otty、Orca 等桌面端会自动重新生成，跨机不可移植）、`hooks.state` 信任哈希。

## 在新机器上恢复

- **可直接复制**：`keybindings.json`、`statusline.sh`
  ```bash
  cp ai-cli/claude/keybindings.json ~/.claude/
  cp ai-cli/claude/statusline.sh    ~/.claude/
  cp ai-cli/codex/keybindings.json  ~/.codex/
  ```
- **需手动合并（勿整文件覆盖）**：`settings.json` / `config.toml` / `traecli.toml`
  是脱敏片段，缺少模型、登录凭证、hooks、项目信任等。请先完成各工具登录并选好模型，再把其中的
  TUI / 主题 / 权限等偏好对照合并进本机文件，避免覆盖掉工具自动生成的内容。
