# Terminal Workbench：模型、不变量与扩展规则

## 目标与范围

工作台是配置内的原生 Lua 模块，不是独立发布插件。它管理多个具名 terminal session，提供 split、float、tab 展示，给后台输出、退出和显式 matcher 提供可见状态。

它不是 tmux 的替代品：当 Neovim 退出时，原生 job 不提供可重连的外部持久化。未来如果需要这一能力，应新增明确的 tmux backend，而不是伪造 session restore。

## 核心模型

一个 session 包含以下关键概念：

```lua
{
  id, name, command, argv, cwd, profile,
  buf, job,
  process,          -- starting | running | stopping | exited | orphaned
  exit_code,
  stop_requested,
  attention, attention_reason,
  unread,
  output_tail, last_output, last_activity,
  attention_patterns,
}
```

它们存储在 `workbench/init.lua` 的进程内 registry：

- `sessions[id]`：session 主记录；
- `name_to_id[name]`：命令补全和名称解析；
- `by_buf[bufnr]`：tabline、当前 buffer 与自动命令的 O(1) 反查；
- `last_id`：`AgentTermToggle` 的目标。

这些表不会跨 Neovim 重启持久化。不要把 buffer number、window id、tabpage id 或 `term://` 名称当成稳定身份。

## 创建生命周期

```text
M.create(opts)
  → 生成唯一名称并注册 session
  → nvim_create_buf(listed=true, scratch=false)
  → 设置 bufhidden=hide、swapfile=false
  → ui.open() 创建初始 split / float / tab
  → nvim_buf_call(buffer, jobstart(argv, { term=true, ... }))
  → on_stdout / on_exit 更新 registry
  → 进入 Terminal mode（仅当 job 仍可交互）
```

### 为什么必须用 `jobstart(..., { term = true })`

Neovim 0.12 中应使用 `jobstart()` + `term = true` 创建 PTY，而不是继续引入已弃用的 `termopen()` 路径。`nvim_buf_call()` 确保 job 附着到它所属的、未被修改的 buffer。

### argv 与 shell command 的边界

- `opts.argv` 是首选的程序化入口：数组参数不依赖 shell quoting。例如 Codex 的简单命令会作为 `{ "codex" }` 运行。
- `opts.command` 是用户显式输入的 shell command，会转换为 `{ vim.o.shell, vim.o.shellcmdflag, command }`。它有意支持 `npm run dev`、管道和重定向。
- 未来 AI 如果以代码自动启动命令，不要把不可信文本拼到 `command`；优先构造 `argv`。
- `:AgentTermNew <name> <command>` 的第一个无空格 token 是名称，其余原样作为 shell command。带空格的 session 名称当前不支持。

## Buffer 与窗口不变量

### 1. 隐藏不等于停止

session buffer 设置为：

```lua
bufhidden = "hide"
buflisted = true
swapfile = false
```

`AgentTermHide` 或 `<leader>th` 只关闭/替换视图；job 和 buffer 应继续存在。不要用以下方式实现隐藏：

- `:bwipeout`、`nvim_buf_delete(..., { force = true })`；
- `bufhidden = "wipe"`；
- 为了清理标签栏而把运行中的 terminal buffer unlist 后删除。

显式 `:bdelete` 或强制 wipe 是用户主动破坏 buffer 的路径；`BufWipeout` 只把仍在交互的 session 标为 `orphaned`，不应据此补造或重启 job。

### 2. 一个 PTY 同时只可见一次

同一个 PTY 在多个不同尺寸 window 中显示会争夺 rows/columns，并造成焦点语义不清。`ui.open()` 会优先 focus 已存在的窗口，而不是复制同一个 buffer 到第二个视图。

split、float、tab 是三种“展示位置”，不是三份 session：

- `split`：在底部创建并聚焦一个窗口；
- `float`：居中浮窗；
- `tab`：独立 tabpage 中的窗口；
- 若 session 已可见，open 只聚焦现有视图。要转换布局，先 hide，再以目标 layout open。

`ui.hide_current()` 的规则是：浮窗关闭；有其他 window 的 tabpage 关闭当前窗口；单窗口且有其他 tabpage 时关闭 tab；最后一个窗口则 `:enew`。每条路径都必须保留 hidden terminal buffer。

## 状态模型

`process` 和 `attention` 刻意分离。不要把“需要关注”编码成进程状态，否则会丢失“仍在运行”这个事实。

### 派生状态优先级

`M.status(session)` 依下列优先级计算 tabline 与 picker 状态：

| 条件 | 派生状态 | 徽标 |
| --- | --- | --- |
| `process == orphaned` | orphaned | `?` |
| `process == exited` 且 `stop_requested` | stopped | `■` |
| `process == exited` 且 `exit_code == 0` | done | `✓` |
| `process == exited` 且非零 | failed | `×` |
| `process == stopping` | stopping | `…` |
| `attention == true` | attention | `!` |
| 其他 `process` | starting / running | `…` / `●` |

`unread` 是独立计数（上限 99），以 `+N` 追加在名称后，不应替代进程状态。

### 可靠事件与不可靠推断

| 事件 | 可可靠得出的结论 |
| --- | --- |
| `jobstart` 返回正 channel id | job 已启动，可标记 running |
| 非当前 session 的完整输出行 | 有后台活动，可增加 unread |
| `on_exit(code == 0)` | 正常退出 |
| `on_exit(code ~= 0)` | 失败退出 |
| `AgentTermStop` + 最终 `on_exit` | 用户请求停止后的终态 |

以下结论**不能**从通用 terminal 输出可靠得到：agent 是否思考中、是否完成一轮、是否真正等待用户、是否安全批准。任何 “attention” 都只是 profile 的显式文本 matcher，且必须向用户表述为提示而非真相。

## 输出回调与通知

### 半行处理是必须保留的行为

PTY 的 `on_stdout` 数据首尾可能是半行。实现维护 `session.output_tail`：第一块拼接 tail，后续块才结算上一行。后续 AI 不要改成“每次 callback 直接对每个 chunk 做 matcher”，否则会：

- 在分块的 `Press Enter` 上漏报；
- 在 spinner/ANSI 更新中重复匹配；
- 让高频输出导致大量 redraw/notification。

当前 ANSI 清理只处理常见 CSI 形式并去除 `\r`，目的是 matcher 的最小鲁棒性，不是通用 ANSI parser。若未来需要更复杂的 OSC/富终端协议，须增加专门解析器和测试，而不是扩大一个 Lua pattern。

### 调度规则

- stdout callback 内只更新内存状态；tabline 刷新通过 `vim.schedule()` 合并。
- 通知也通过 `vim.schedule()` 发出，避免在 job callback 内直接做 UI 工作。
- 已聚焦 session 的 attention/exit 不额外发通知；用户正在看它时不应打扰。
- `mini.notify` 接管 `vim.notify`。要让消息可识别，使用如 `[Terminal] name completed` 的文本前缀；不要依赖常见的第三参数 title/replace 选项。

### 注意力 matcher

默认只有 `codex` profile 含 matcher，且词表保守：

```lua
"Press Enter to continue"
"Allow this"
"[Y/n]"
"[y/N]"
```

普通 shell session 默认没有 matcher。修改 matcher 的正确位置是 `lua/config/local.lua`，并且应由用户提供实际输出样本后再调整。matcher 使用大小写无关的 plain substring，不接受 Lua pattern 语义。

`BufEnter` 或 `TermEnter` 聚焦 session 时会清空 `unread` 与已 latch 的 `attention`，视为用户已经看到该会话。

## 退出、停止与发送输入

### 退出真相源

`on_exit` 是唯一创建最终 `exit_code` 和 `process = exited` 的路径。不要同时用 `TermClose` 更新 finished/failed；两者会重复，buffer 被删时 `TermClose` 的状态也可能不代表真实退出码。

callback 会校验 job id 和已有 exit code，避免旧回调或重复回调覆盖结果。未来若加入 restart/generation，必须保留或加强这个防护。

### 停止

`M.stop()`：

1. 设 `stop_requested = true`；
2. 设 `process = stopping`；
3. 调用 `jobstop(session.job)`；
4. 等待 `on_exit` 产生最终 stopped 状态。

不要在 `jobstop()` 返回后直接写 `exited` 或假设退出码。若 `jobstop()` 失败且尚未收到 exit，才恢复 running。

### 发送

`AgentTermSend <name> <text>` 调用 `M.send_line()`，仅对仍可交互的 job 使用 `chansend(job, text .. "\r")`。

它是一个显式人工动作。禁止新增“检测到 matcher 后自动发送 y/Enter”一类逻辑；agent 的权限、破坏性命令和上下文不能由 heuristic 决定。

## Terminal mode 键位原则

所有工作台 keymap 都在 Normal mode。Terminal mode 中用户使用原生 `<C-\\><C-n>` 回到 Normal mode，再使用 `<leader>t…`。

不要映射：Esc、Ctrl-C、Enter、Tab、Ctrl-R、Ctrl-L、Ctrl-H/J/K/L、Leader 前缀。这些在 shell、Codex、fzf、REPL 或 TUI 中都有真实语义；例如 Ctrl-H 常是退格、Ctrl-J 常是回车。

若未来需要跨 Nvim/tmux pane 导航，应做成用户显式启用的可选功能、buffer-local 映射，并为每种 terminal/TUI 写手工验收，不要把它加入默认映射。

## 与 tmux 的未来关系

当前后端为 `nvim`：进程依赖当前 Neovim 进程。未来 `tmux` backend 的职责应是：

- tmux 拥有真实进程持久化和重连；
- Neovim 仍拥有 session 列表、picker、状态提示和窗口展示；
- 不混淆 tmux window/pane 与 workbench session identity；
- 明确定义 attach/detach、退出 Nvim、tmux server 不存在、重复 attach 和安全停止语义。

在这些设计和测试完成前，不要声称当前配置“等同 tmux”。
