local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
    return
end

local default = {
    ensure_installed = {
        "lua",
        "vim",
        "cpp",
        "c"
    },
    -- highlight = {
    -- enable = true,
    -- use_languagetree = true
    -- }
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]]"] = "@function.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
            },
        }
    },
}

local M = {}
M.setup = function()
    ts_config.setup(default)
end

return M
