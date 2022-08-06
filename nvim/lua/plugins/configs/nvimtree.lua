local present, nvimtree = pcall(require, "nvim-tree")

if not present then
    return
end

local g = vim.g


local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not status_ok then
    return
end
local tree_cb = nvim_tree_config.nvim_tree_callback
local default = {
    filters = {
        dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    ignore_ft_on_setup = { "dashboard" },
    -- auto_close = false,
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        adaptive_size = true,
        side = "left",
        width = 25,
        hide_root_folder = false,
        mappings = {
            custom_only = false,
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
                { key = "C", cb = tree_cb "cd" },
                { key = "gtf", cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('find_files')<cr>" },
                { key = "gtg", cb = "<cmd>lua require'lvim.core.nvimtree'.start_telescope('live_grep')<cr>" },
            }
        },
        signcolumn = "yes",
    },
    git = {
        enable = false,
        ignore = false,
    },
    -- renderer = {
    --     add_trailing = false,
    --     group_empty = false,
    --     highlight_git = false,
    --     full_name = false,
    --     highlight_opened_files = "none",
    --     root_folder_modifier = ":~",
    --     indent_markers = {
    --         enable = false,
    --         inline_arrows = true,
    --         icons = {
    --             corner = "└",
    --             edge = "│",
    --             item = "│",
    --             none = " ",
    --         },
    --     },
    --     icons = {
    --         webdev_colors = true,
    --         git_placement = "before",
    --         padding = " ",
    --         symlink_arrow = " ➛ ",
    --         show = {
    --             file = true,
    --             folder = true,
    --             folder_arrow = true,
    --             git = true,
    --         },
    --         glyphs = {
    --             default = "",
    --             symlink = "",
    --             bookmark = "",
    --             folder = {
    --                 arrow_closed = "",
    --                 arrow_open = "",
    --                 default = "",
    --                 open = "",
    --                 empty = "",
    --                 empty_open = "",
    --                 symlink = "",
    --                 symlink_open = "",
    --             },
    --             git = {
    --                 unstaged = "✗",
    --                 staged = "✓",
    --                 unmerged = "",
    --                 renamed = "➜",
    --                 untracked = "★",
    --                 deleted = "",
    --                 ignored = "◌",
    --             },
    --         },
    --     },
    --     special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    --     symlink_destination = true,
    -- },
}

local M = {}

M.setup = function()
    nvimtree.setup(default)
end

return M
