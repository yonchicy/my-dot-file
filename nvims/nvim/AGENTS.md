# Neovim 配置：AI 协作入口

此目录是用户的实际 Neovim 配置根目录：`/Users/bytedance/.config/nvim`。

在修改任何文件前，按以下顺序阅读：

1. [`.agents/README.md`](.agents/README.md)：范围、读取路线与当前目标。
2. [`.agents/architecture.md`](.agents/architecture.md)：加载顺序、模块归属和依赖策略。
3. [`.agents/terminal-workbench.md`](.agents/terminal-workbench.md)：终端工作台的生命周期、不变量和状态语义。
4. [`.agents/maintenance.md`](.agents/maintenance.md)：安全修改、验证和依赖更新流程。
5. [`.agents/reference.md`](.agents/reference.md)：命令、映射、配置入口和状态图例。

## 不可违反的规则

- 目标版本是 Neovim 0.12+；继续使用原生 `vim.pack`，不要无故引入 `lazy.nvim` 或第二个插件管理器。
- `lua/config/local.lua` 是用户的个性化入口。除非用户明确要求，禁止覆盖、删除或把它的内容迁回通用模块。
- `nvim-pack-lock.json` 是依赖锁文件。不要删除、手改或在未获授权时运行会更新依赖的 `:packupdate`。
- 终端工作台的一个 session 对应一个 PTY job 和一个隐藏可恢复的 buffer；隐藏窗口绝不能通过 `bwipeout` 或 `bufhidden=wipe` 杀掉 job。
- 不要把同一 PTY 同时显示在多个窗口。它只能有一个可见视图，以免出现终端尺寸竞争。
- 不要覆盖 Terminal mode 的 Esc、Ctrl-C、Enter、Tab、Ctrl-R、Ctrl-L、Ctrl-H/J/K/L 等按键。它们属于 shell、Codex 和其他 TUI。
- “等待输入/需要注意”只能由显式 profile matcher 得到，不能把任意输出、spinner 或文案猜测为通用 agent 协议；绝不自动确认、回车或发送 agent 输入。
- 进程退出只以 `jobstart(...).on_exit` 为准；不要再用 `TermClose` 产生第二套终态或重复通知。
- 任何改动终端、通知、标签栏或插件加载逻辑后，都要运行 `.agents/tests/workbench_smoke.lua` 中定义的 smoke test。

## 快速判断改动位置

| 需求 | 首选文件 |
| --- | --- |
| 用户个人偏好、Codex 命令、匹配词、布局 | `lua/config/local.lua` |
| 基础 Neovim 选项 | `lua/config/options.lua` |
| 搜索/终端快捷键 | `lua/config/keymaps.lua` |
| `mini.nvim` 模块配置 | `lua/config/mini.lua` |
| 插件来源或锁定策略 | `lua/config/packages.lua` + `nvim-pack-lock.json` |
| 终端 session、状态、命令 | `lua/workbench/init.lua` |
| split/float/tab 展示 | `lua/workbench/ui.lua` |
| 工作台默认值和 profile | `lua/workbench/config.lua` |

不要为了局部需求把逻辑堆进 `init.lua`；它只负责固定的加载编排。
