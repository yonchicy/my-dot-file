# AI 协作指南

## 这套配置的目标

这是一个面向 CLI agent 工作流的轻量 Neovim 0.12 配置，而不是通用 Neovim 发行版。当前明确覆盖的能力是：

- 多 buffer 标签显示；
- 文件、全文和 buffer 的模糊查找；
- 具名、可隐藏、可恢复的原生 terminal session；
- Codex 等 agent 的保守状态提醒；
- 不破坏 Terminal mode 内 shell/TUI 原始按键的窗口管理体验。

当前不包含 LSP、补全、DAP、文件树、Git UI、主题发行版或 AI 自动操作层。除非用户请求，不应以“顺手补齐”为由扩大范围。

## 文档导航

| 文档 | 什么时候读 |
| --- | --- |
| [`architecture.md`](architecture.md) | 修改启动、插件、配置结构、加载顺序或依赖时 |
| [`terminal-workbench.md`](terminal-workbench.md) | 修改 session、终端窗口、状态、通知、命令或 tmux 方案时 |
| [`maintenance.md`](maintenance.md) | 实施改动、排错、更新插件、验证或交接时 |
| [`reference.md`](reference.md) | 查命令、映射、文件职责、状态含义或个人配置字段时 |
| [`tests/workbench_smoke.lua`](tests/workbench_smoke.lua) | 修改后执行端到端 smoke test 时 |

根目录的 `AGENTS.md` 是自动化工具更容易发现的入口；它只做导航，详细内容全部在本目录。

## 当前运行假设

- Neovim：0.12+。
- 插件管理：Neovim 原生 `vim.pack`。
- 第三方来源：`nvim-mini/mini.nvim` 的 `stable` 分支，以及 `nvim-treesitter/nvim-treesitter` 的 `main` 分支。
- 外部命令：`git` 用于首装/更新，`rg` 用于 files/grep；`curl`、`tar`、C 编译器与 `tree-sitter-cli >= 0.26.1` 仅用于安装/更新 Tree-sitter parser；`codex` 仅在用户使用 Codex 快捷方式时需要；`tmux` 已安装但尚未接入后端。
- 图标默认 ASCII，以免没有 Nerd Font 的终端出现乱码；用户可在 `lua/config/local.lua` 改为 glyph。

## 加载路线

```text
init.lua
  ├─ config.local       用户覆盖项与图标风格
  ├─ config.options     基础 Neovim 选项与 session 安全项
  ├─ config.packages    vim.pack 安装/加载 mini.nvim 与 nvim-treesitter
  ├─ config.treesitter  原生 Tree-sitter 高亮与本地 parser 目录
  ├─ workbench.setup    注册 terminal 状态、自动命令和 :AgentTerm* 命令
  ├─ config.mini        icons / notify / pick / tabline
  └─ config.keymaps     Normal mode 映射
```

这个顺序有意如此：工作台须早于 tabline formatter；`local.lua` 须早于图标与工作台配置；keymap 最后绑定已加载的功能。修改加载顺序前先确认初始化依赖关系。

## AI 的默认工作方式

1. 先读相关文档和目标文件，再决定是否需要改动。
2. 把用户偏好写在 `config/local.lua`，通用行为写在对应模块。
3. 以最小变更满足请求；保留现有无关改动。
4. 对 session/job/窗口逻辑做改动时，先推演生命周期和并发回调，再写代码。
5. 运行 smoke test；如果变更影响交互布局，再补一个手工验收说明。
6. 如果涉及 plugin 下载、更新、删除、真实 Codex 任务、tmux session 或用户数据，先取得相应授权。

## 不要误读的边界

- “隐藏 terminal”只保证进程在当前 Neovim 进程存活期间继续运行，不保证退出 Neovim 后仍存在。
- Neovim tabpage 是窗口布局容器，不是稳定的 terminal session 身份；session id/name 才是身份。
- `attention` 只是文本 matcher 的提示，不是 agent 的通用“等待/完成”协议。
- 已结束的 terminal buffer 是历史输出，可再次打开查看，但不能发送输入或重新启动。
