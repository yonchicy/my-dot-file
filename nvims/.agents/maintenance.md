# 维护、验证与安全 Runbook

## 权威源与工作区卫生

运行中的唯一权威源是：

```text
/Users/bytedance/.config/nvim
```

此前的 `work/nvim-config/nvim` 是实施阶段的隔离副本，不是第二个可编辑配置根。后续 AI 应：

- 直接阅读和修改 live config；
- 若需要隔离验证，创建一次性临时副本；
- 不要在 live config 与 `work/` 副本中双向编辑并期待自动同步；
- 部署前若确实使用 staging，先 `diff -ru`，只同步预期差异；
- 不要删除、重建或覆盖 `config/local.lua`、`nvim-pack-lock.json`，除非用户明确要求。

## 安全模型

工作台的职责是“观察、展示、提醒”，不是代表用户行动。

### 严禁自动化的操作

- 不要根据 terminal 文本自动调用 `chansend()`；
- 不要模拟 Enter、`y`、`yes`、权限确认、账号输入或 agent 回复；
- 不要因为任务“看起来结束/卡住”就自动 `AgentTermStop`、重启或 wipe buffer；
- 不要执行真实 Codex、开发服务器、写文件脚本或联网任务来做自动回归；
- 不要把 terminal 输出、session command、cwd、`attention_reason` 原样写到外部日志、issue 或消息中；它们可能含敏感信息。

`AgentTermSend` 是明确的人工写入入口。未来 AI 只有在用户给出目标 session 和精确要发送文本时，才可使用或修改这一能力。

### command 与 argv

- 面向用户的 `:AgentTermNew name command` 有意经 shell 执行，支持正常 shell 语法。
- 面向代码的启动优先传 `argv = { ... }`，不要拼接不可信文本进 `command`。
- `CODEX_CMD`、profile command 和 `local.lua` 不构成安全沙箱；它们可以执行任意本机命令。

### 破坏性终端操作

| 用户意图 | 正确操作 | 禁止替代 |
| --- | --- | --- |
| 临时收起但继续运行 | `:AgentTermHide` / `<leader>th` | `:bwipeout`、强制删除 buffer |
| 确认结束任务 | `:AgentTermStop [name]` | 因超时或猜测直接 `jobstop` |
| 查看已结束日志 | `:AgentTermOpen <name>` | 重新创建同名 job 并声称“恢复” |
| 跨退出持久化 | 未来 tmux backend 设计 | 重新加入 `sessionoptions+=terminal` |

## 标准修改流程

### 1. 先分类请求

| 请求类型 | 应改位置 |
| --- | --- |
| 个人 command、matcher、尺寸、图标 | `lua/config/local.lua` |
| 默认行为或 profile schema | `lua/workbench/config.lua` |
| job/session/status/命令 | `lua/workbench/init.lua` |
| split/float/tab/window 行为 | `lua/workbench/ui.lua` |
| normal mode 映射 | `lua/config/keymaps.lua` |
| plugin 集成 | `lua/config/mini.lua` |
| 依赖版本与来源 | `lua/config/packages.lua` + lockfile |

如果变更跨越多个分类，先写明边界和依赖关系。不要把生命周期逻辑塞进 keymap callback，或让 `ui.lua` 直接改 session 状态。

### 2. 保护局部状态与异步边界

涉及 `workbench/init.lua` 时，逐项审查：

- 是否同时维护 `sessions`、`name_to_id`、`by_buf`？
- job callback 是否确认 session/job id 仍匹配？
- exit 是否仍只处理一次？
- stdout 是否继续尊重 `output_tail`？
- 高频 UI 刷新是否继续使用 debounce/schedule？
- 聚焦 session 时 unread/attention 的语义是否仍然清晰？
- 用户是否会因变更而丢失正在运行的 agent？

新增 session 字段时，在 `terminal-workbench.md` 写清楚它的所有者、生命周期、是否持久化，以及它对 `M.status()` 的影响。

### 3. 验证

最小 smoke test（使用真实配置，但把 Neovim 状态目录放进临时路径）：

```sh
TEST_STATE="$(mktemp -d)"
XDG_STATE_HOME="$TEST_STATE" \
  nvim --headless \
  '+luafile /Users/bytedance/.config/nvim/.agents/tests/workbench_smoke.lua' \
  '+qa!'
```

预期输出：

```text
WORKBENCH_SMOKE_OK
```

该脚本只运行固定 `/bin/sh` 命令、短暂 `sleep` 并显式停止它们；不会启动 Codex、访问网络或写项目文件。它覆盖的不是图形外观，而是可自动判断的核心生命周期。

变更影响窗口、浮窗、tab、Terminal mode 键位或真实 Codex 行为时，还必须做手工验收。最低手工步骤：

1. 用 `nvim` 冷启动，确认没有 Lua error。
2. 创建一个 shell session，隐藏后确认它仍在运行，再重新打开。
3. 分别在 split、float、tab 中打开 session；确认同一 session 不会重复显示。
4. 在 Codex session 中测试 Esc、Ctrl-C、Enter、Tab，确认它们没有被配置劫持。
5. 观察一个真实但无破坏性的 agent prompt；确认不会自动发送任何输入。

### 4. 更新文档

下面任一项改变时，文档必须随代码更新：

- 新命令或 keymap；
- 新 session 字段、状态或徽标；
- job/PTY 生命周期；
- 新 profile 或 matcher；
- plugin、外部二进制、锁文件策略；
- tmux、OSC、系统通知等从“未实现”变为“实现”。

用户 README 面向使用者；`.agents` 面向维护 AI。不要只改其中一份而造成行为说明不一致。

## 自动测试覆盖与缺口

`.agents/tests/workbench_smoke.lua` 当前覆盖：

- 配置和 `mini.pick` / `mini.tabline` 的加载；
- `:AgentTermNew` 命令存在；
- `sessionoptions` 不含 `terminal`；
- 正常退出为 done；
- 隐藏 running terminal 后的后台输出产生 unread；
- reopen 清除 unread；
- 显式 stop 最终为 stopped；
- Codex profile matcher 产生 attention，聚焦后确认；
- tabline format；
- 通过 `:AgentTermNew` 走 shell command 创建；
- 重名 rename 不改变 session 名称。

以下场景尚未完全自动覆盖；改动触及它们时应先补测试：

- 非零退出和启动失败的 failed 路径；
- `float`、`tab` 以及重复 open 的一 PTY 一视图约束；
- `AgentTermToggle`、picker fallback 和 layout 参数校验；
- `AgentTermSend` 的显式输入边界；
- 无换行 prompt、复杂 ANSI/OSC、长 spinner 的 matcher 行为；
- 重复名称创建、重名重命名；
- `BufWipeout -> orphaned`；
- 缺少 `mini.nvim`、`rg` 或 `codex` 时的降级；
- `:mksession` / restore 的真实端到端行为。

不要声称 smoke test 覆盖了这些未覆盖项。

## 插件更新与依赖改动

插件升级是架构变更，不是普通格式化。

1. 先获得用户同意联网/更新。
2. 用 `:packupdate` 获取候选变更；阅读确认 buffer 和上游 changelog。
3. 审查 `nvim-pack-lock.json` 的 revision 是否符合预期。
4. 跑 smoke test 和受影响的手工测试。
5. 更新 README、`.agents/architecture.md` 与依赖说明。

禁止：

- 手工编辑 lockfile；
- 删除用户数据目录中的 plugin 再“重装”；
- 引入 `lazy.nvim`、完整发行版或多个终端/搜索/标签栏插件来处理一个局部问题；
- 让 plugin update 在每次启动时自动发生。

## 排错 Runbook

| 现象 | 低风险检查 | 常见原因 / 处理 |
| --- | --- | --- |
| `:AgentTermNew` 不存在 | `:messages`、`:echo exists(':AgentTermNew')` | 检查 `init.lua` 是否执行到 `workbench.setup()` |
| keymap 不生效 | `:verbose nmap <leader>tc` | 确认处于 Normal mode，且 leader 是空格 |
| picker 不可用 | `:messages`、`:=pcall(require, 'mini.pick')` | package 下载/加载失败；基础 workbench 仍可通过 Ex 命令使用 |
| 终端“消失” | `:AgentTermList` | 先确认是否只 hide；若 buffer 已 wipe，当前 V1 不能 reattach |
| attention 误报/漏报 | 收集脱敏的完整输出行 | 先确认 profile，再调整 `local.lua` 中的字面 matcher；不要加宽泛词 |
| 退出后显示 failed | `:lua vim.print(require('workbench').list())` | 检查真实 exit code；done 只代表 code 0 |
| session restore 重启任务 | `:set sessionoptions?` | `terminal` 不应在列表中；不要通过 restore “修复” |
| Codex session 立即退出 | `:echo executable('codex')`、检查 `CODEX_CMD` | command/argv/PATH 错误，不应通过自动重试掩盖 |

有用的只读调试命令：

```vim
:messages
:verbose command AgentTermNew
:verbose nmap <leader>tc
:set sessionoptions?
:AgentTermList
:lua vim.print(require('workbench').list())
:lua vim.print(require('workbench').current_session())
```

调试输出可能包含 command、cwd 或终端文本，分享前应脱敏。

## 当前已知限制（不要误写成能力）

- 没有 tmux backend、跨退出持久化或 reattach。
- 没有 macOS 系统通知；当前是 Neovim 内 `mini.notify` 通知。
- 没有 OSC 7/OSC 133、`TermRequest` 或 semantic shell 状态跟踪。
- 没有 LSP、补全、DAP 或完整开发发行版。
- `cwd` 只记录创建时目录，不跟踪 terminal 内 `cd`。
- `last_id` 是最近创建 session，不是最近聚焦 session。
- 已打开 float 的标题在 rename 后不自动刷新；重新打开即可更新。
- `attention_reason` 会记录，但当前 UI 不显示它。
- 已失效 buffer 的 session 仍可能出现在 selector；打开时会警告，不能视为可恢复。
- 未知 layout 当前会回退为 split；新增布局时应加入显式校验和测试。
