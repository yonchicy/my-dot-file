# 操作与配置参考

本页是维护者的速查表。语义、边界和实现理由见
[`terminal-workbench.md`](terminal-workbench.md)；安全变更与验证步骤见
[`maintenance.md`](maintenance.md)。

## 日常入口

leader 是空格。下面列出的编辑、窗口、搜索和工作台入口均在 Normal mode 生效。

| 按键 | 动作 | 说明 |
| --- | --- | --- |
| `<leader>hl` | 清除搜索高亮 | 执行 `:nohlsearch`。 |
| `H` / `L` | 跳至首个非空白字符 / 行尾 | 在 Normal 和 Visual mode 生效。 |
| `<leader>1` ... `<leader>9` | 聚焦第 1 至第 9 个窗口 | 使用 `:wincmd w` 的 count。 |
| `<C-Left>` / `<C-Right>` | 缩窄 / 加宽当前窗口 | 每次调整 3 列。 |
| `<Tab>` / `<S-Tab>` | 下一个 / 上一个 buffer | 分别执行 `:bnext` / `:bprevious`。 |
| `<leader>bc` | 关闭当前 buffer | 执行 `:bdelete`。 |
| `<leader>bn` | 新建空 buffer | 执行 `:enew`。 |
| `<leader>q` | 保存全部并关闭当前窗口 | 先执行 `:wall`，再执行 `:quit`；不会停止隐藏的 terminal job。 |
| `<leader>ff` | 查找文件 | `mini.pick` 的 `files`；需要 `rg` 才有完整体验。 |
| `<leader>fw` | 全文模糊搜索 | `mini.pick` 的 `grep_live`；需要 `rg`。 |
| `<leader>fb` | 查找已打开 buffer | 包括 listed 的 terminal buffer。 |
| `<leader>tn` | 交互式新建 terminal | 依次询问名称和可选 command；空 command 启动 shell。 |
| `<leader>tc` | 交互式新建 Codex terminal | 使用 `profiles.codex`。 |
| `<leader>tl` | 选择 terminal session | 优先打开 `mini.pick`，不可用时退回 `vim.ui.select()`。 |
| `<leader>tt` | 显示/隐藏最近创建的 session | “最近创建”不是“最近聚焦”。 |
| `<leader>th` | 隐藏当前 terminal | 仅隐藏视图，进程继续运行。 |
| `<leader>ts` | 以 split 打开当前/所选 session | 已显示时只聚焦已有窗口。 |
| `<leader>tf` | 以 float 打开当前/所选 session | 先 hide 才能转换已有 session 的布局。 |
| `<leader>to` | 以 tab 打开当前/所选 session | Neovim tabpage 只是布局，不是 session 身份。 |
| `<leader>tx` | 停止当前/所选 session | 仅显式动作会调用 `jobstop()`。 |

在 Terminal mode，先按 Neovim 原生 `<C-\\><C-n>` 回到 Normal mode，再使用上表映射。默认配置刻意没有替代 Terminal mode 的 Esc、Ctrl-C、Enter、Tab 或常见 Ctrl 组合。

## Ex 命令

| 命令 | 行为与参数规则 |
| --- | --- |
| `:AgentTermNew [name] [command]` | 无参数时交互创建；有参数时第一段无空格文本是 name，其余部分通过 shell 执行。未传 command 则开交互 shell。 |
| `:AgentTermNew! [name] [command]` | 与上项相同，但初始展示为 float。 |
| `:AgentTermCodex [name]` | 用 Codex profile 创建；省略 name 时默认 `codex`。 |
| `:AgentTermCodex! [name]` | 与上项相同，但初始展示为 float。 |
| `:AgentTermList` | 打开 session selector。 |
| `:AgentTermToggle` | 显示或隐藏最近创建的 session。 |
| `:AgentTermHide` | 隐藏当前 workbench terminal；若当前不是它会警告。 |
| `:AgentTermOpen [name] [split\|float\|tab]` | 打开指定 session；无 name 时使用当前 session 或要求选择。未识别 layout 当前回退为 split，维护时应避免依赖此宽容行为。 |
| `:AgentTermStop [name]` | 停止指定 session；无 name 时停止当前或要求选择。 |
| `:AgentTermRename [new-name]` | 重命名当前 session；无参数时弹出输入框。重名会自动加 `-2`、`-3`。 |
| `:AgentTermSend <name> <text>` | 向运行中的指定 session 显式写入一整行（末尾添加 `\r`）。绝不用于自动确认。 |

示例：

```vim
:AgentTermCodex api-fix
:AgentTermNew server npm run dev
:AgentTermNew logs tail -f ./app.log
:AgentTermOpen api-fix float
:AgentTermSend api-fix Please review the latest diff
```

`AgentTermNew` 的 command 路径是用户输入的 shell 文本，故支持管道、重定向等 shell 语法，也承担对应的 shell 风险。Lua 代码要启动已知命令时，应调用 `require("workbench").create({ argv = { ... } })`，而不是拼接 untrusted command string。

## 状态、tabline 与提醒

| 标签 | 意义 | 可靠性 / 用户应如何理解 |
| --- | --- | --- |
| `…` | starting 或 stopping | 正在启动/等待 exit callback；不是 agent 工作进度。 |
| `●` | running | PTY job 仍存活。 |
| `!` | attention | profile 的文本 matcher 匹配到提示；不是通用 agent 协议。聚焦后会确认并清除。 |
| `■` | stopped | 用户调用 stop 后，job 已退出。 |
| `✓` | done | exit code 为 0。 |
| `×` | failed | exit code 非 0，或 job 无法启动（当前为 `-1`）。 |
| `?` | orphaned | terminal buffer 已被 wipe，当前 V1 不能重新 attach。 |
| `+N` | unread | 非当前 session 的完整输出行/退出事件数，最多 99；不是精确日志行数。 |

默认 Codex matcher：`Press Enter to continue`、`Allow this`、`[Y/n]`、`[y/N]`。匹配为大小写无关的字面子串匹配，且普通 shell 没有 matcher。它只能用于提醒，不可作为自动发送 Enter、`y` 或任何权限确认的依据。

## 配置入口

### 用户覆盖：`lua/config/local.lua`

用户专有差异优先放在此文件。例如：

```lua
return {
  icon_style = "ascii", -- 有 Nerd Font 时可改为 "glyph"
  workbench = {
    default_layout = "split", -- split | float | tab
    split_height = 18,
    float = {
      width = 0.86,
      height = 0.78,
      border = "rounded",
    },
    notifications = {
      enabled = true,
      on_attention = true,
      on_exit = true,
      on_start = false,
    },
    profiles = {
      codex = {
        command = "codex", -- 也可用环境变量 CODEX_CMD
        -- 若要避免 shell 解析，可直接改用 argv = { "codex", "--flag" }。
        -- command 含空格时，当前实现会经 shell 执行。
        attention_patterns = {
          "Press Enter to continue",
          "Allow this",
          "[Y/n]",
          "[y/N]",
        },
      },
    },
  },
}
```

合并采用深度覆盖：map 能局部覆盖，list 会整体替换。因此只要在 `local.lua` 写了 `attention_patterns`，就必须列出保留的全部词条；它不会自动附加默认值。

### 实现文件归属

| 文件 | 修改时机 |
| --- | --- |
| `init.lua` | 仅调整经审查后的加载编排与 0.12 version gate。 |
| `lua/config/options.lua` | 编辑器 option；必须保留 `sessionoptions:remove("terminal")`。 |
| `lua/config/packages.lua` | `vim.pack` 的仓库规范与加载故障处理。 |
| `lua/config/treesitter.lua` | 配置 `.treesitter/` parser 目录、将 `sh` 映射到 `bash`，并在有可用 parser 时启用原生高亮；不依赖 LSP。 |
| `lua/config/mini.lua` | mini 模块的 setup 和 workbench-tabline 集成。 |
| `lua/config/keymaps.lua` | Normal mode 的入口映射。 |
| `lua/workbench/config.lua` | 通用工作台默认值与 profile schema。 |
| `lua/workbench/init.lua` | session registry、job callback、状态、命令、selector。 |
| `lua/workbench/ui.lua` | split/float/tab 的创建、已有视图 focus 与 hide。 |
| `nvim-pack-lock.json` | `:packupdate` 经用户同意后产生的依赖锁定结果；不要手改。 |

## 外部依赖与降级

| 依赖 | 用途 | 缺失时的行为 |
| --- | --- | --- |
| Neovim 0.12+ | 原生 `vim.pack` 与全部配置 API | 启动时输出错误，不继续加载。 |
| `nvim-mini/mini.nvim` stable | picker、tabline、notify、icons | `config.mini` 会警告；部分 Ex 命令仍可用，picker 可退回 `vim.ui.select`。 |
| `nvim-treesitter/nvim-treesitter` main | 安装和更新 Java、C++、Bash 等 parser 与 queries | 原生高亮仍可用，但缺少对应 parser 时会回退到普通 syntax；不可 lazy-load。 |
| `git` | 受管 plugin 的首次取得/更新 | 首装或更新失败。 |
| `rg` | files 和 grep_live | 搜索体验不可用或受限。 |
| `curl`、`tar`、C 编译器、`tree-sitter-cli >= 0.26.1` | `:TSInstall` / `:TSUpdate` | 已安装 parser 仍可高亮；不能安装或更新 parser。 |
| `codex` | Codex convenience session | 仅 `AgentTermCodex` 可能立即退出；普通 terminal 不受影响。 |
| `tmux` | 当前未使用 | 已安装不等于已接入；不要把它当运行时后端。 |

## 一页式诊断

```vim
:messages
:echo exists(':AgentTermNew')
:verbose command AgentTermNew
:verbose nmap <leader>tc
:set sessionoptions?
:AgentTermList
:lua vim.print(require('workbench').list())
:lua vim.print(require('workbench').current_session())
```

分享上述输出前，先检查其中是否含有 terminal command、cwd、agent 内容、token 或其他敏感信息。
