# 架构与模块边界

## 目录结构

```text
~/.config/nvim/
├── init.lua
├── nvim-pack-lock.json
├── README.md
├── AGENTS.md                     # AI 发现入口
├── .agents/                      # 本协作文档与 smoke test
├── lua/
│   ├── config/
│   │   ├── local.lua             # 唯一的默认个人化入口
│   │   ├── options.lua
│   │   ├── packages.lua
│   │   ├── treesitter.lua
│   │   ├── mini.lua
│   │   └── keymaps.lua
│   └── workbench/
│       ├── config.lua            # 终端默认值和 profile
│       ├── init.lua              # session 注册表、job、状态、命令
│       └── ui.lua                # split / float / tab / hide
└── .agents/
```

`init.lua` 不是业务逻辑容器。它应保持为小型、可读的编排文件；新增功能应进入有明确职责的模块。

## 模块职责

| 模块 | 拥有的职责 | 不应承担的职责 |
| --- | --- | --- |
| `config/local.lua` | 用户偏好、布局、Codex 路径、matcher、图标风格 | 业务逻辑、插件 bootstrap、映射实现 |
| `config/options.lua` | 通用 option 与安全默认值 | plugin 配置、terminal job 生命周期 |
| `config/packages.lua` | `vim.pack` 规格和加载错误处理 | 任意 plugin 的具体 `setup()` |
| `config/treesitter.lua` | 配置本地 parser 目录、`sh -> bash` 映射，并在有可用 parser 时启用原生高亮 | parser 下载、LSP 或语义 token |
| `config/mini.lua` | 启用所选 mini 模块及它们之间的集成 | 工作台状态存储或命令实现 |
| `config/keymaps.lua` | 用户可发现的 Normal mode 入口 | Terminal mode 劫持、复杂业务逻辑 |
| `workbench/config.lua` | 可合并的默认配置和 profile | 状态可变数据 |
| `workbench/init.lua` | session registry、PTY job、状态、命令、picker 接口 | 具体窗口几何与布局细节 |
| `workbench/ui.lua` | 终端 buffer 的可见窗口和隐藏策略 | job 启动、状态推理、输出解析 |

## 依赖策略

本配置刻意只维护两个第三方仓库：`nvim-mini/mini.nvim` 与
`nvim-treesitter/nvim-treesitter`。

启用的模块如下：

| mini 模块 | 职责 | 集成注意点 |
| --- | --- | --- |
| `mini.icons` | 文件/类型图标 | 默认 ASCII；glyph 需要 Nerd Font |
| `mini.notify` | 替换全局 `vim.notify` | 工作台通知必须把上下文放在消息文本中，不依赖通用第三参数 title |
| `mini.pick` | files、grep_live、buffers 与 session picker | 自定义 session item 使用 `text` 和 `session_id`；选择后须在 picker 的 target window 打开 |
| `mini.tabline` | listed buffer 标签栏 | `format` 高频调用，只能做 O(1) 的 `buffer -> session` 查询 |

`nvim-treesitter` 只管理 parser 与 query 的安装/更新；语法高亮仍由
Neovim 原生 `vim.treesitter.start()` 提供，不依赖 LSP。parser 产物安装到
配置目录的 `.treesitter/`，它是被 Git 忽略的本地生成状态。

不使用 `toggleterm.nvim`、`vim-floaterm`、`telescope.nvim`、`fzf-lua`、`bufferline.nvim` 或 `nvim-web-devicons`，不是遗漏：它们要么与本地 terminal 生命周期模型重叠，要么重复 mini 的能力，要么会增加不必要依赖。

## 插件管理

`config/packages.lua` 在启动时调用 `vim.pack.add()`：

- 目标为 `https://github.com/nvim-mini/mini.nvim`；
- 使用 `stable` 分支；
- 目标为 `https://github.com/nvim-treesitter/nvim-treesitter`；
- 使用 `main` 分支，且不可 lazy-load；
- 首装允许加载，后续启动不会自动更新；
- `nvim-pack-lock.json` 固定已解析 revision。

维护规则：

1. 增加依赖前先说明它无法由 Neovim/mini/本地 Lua 解决的具体问题。
2. 需要更新依赖时使用 `:packupdate`，阅读变更并获得用户同意后才确认写入。
3. 锁文件与 plugin spec 必须一起审查；不要仅复制某人配置中的 lockfile。
4. 不要把 `vim.pack` 和第三方 plugin manager 混用。

## 用户配置覆盖模型

`workbench.config.make()` 用 `vim.tbl_deep_extend("force", defaults, user_config)` 合并默认值和 `config/local.lua` 的 `workbench` 字段。

这意味着：

- 嵌套 map（如 `profiles.codex.command`）可局部覆盖；
- list（如 `attention_patterns`）整体替换，不会自动追加；
- 若要保留默认 matcher 并增加一项，需在用户配置里明确列出完整期望列表，或以后扩展出 append 语义；
- 不应在运行中修改 `M.defaults`，它是模板而非 session 状态。

## 全局安全默认值

`config/options.lua` 中最容易被后续改动破坏的一项是：

```lua
vim.opt.sessionoptions:remove("terminal")
```

没有它，`:mksession` 恢复时可能按 `term://...` 重新执行 agent 命令；那不是恢复原来的进程，而是意外启动一个新任务。跨 Neovim 的进程持久化应由未来 tmux 后端完成。

## 扩展原则

新增功能时，先回答以下问题：

1. 它是个人偏好、基础编辑行为、plugin 集成还是终端会话语义？
2. 是否能复用已安装的 mini 模块或 Neovim 原生 API？
3. 是否会抢占 Terminal mode 输入、改变 job 生命周期或造成后台 agent 被杀？
4. 是否需要新的可验证行为、文档条目和 smoke test 覆盖？

只有答案明确后再选择文件与依赖。
