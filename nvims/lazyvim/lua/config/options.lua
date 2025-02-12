-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.background = "light"
-- vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.g.copilot_proxy = "http://localhost:7890"
vim.opt.rnu = false

vim.opt.termguicolors = true
-- opt.guifont = "FiraCode Nerd Font:h12" -- the font used in graphical neovim applications
-- opt.guifont = "Maple Mono SC NF:h12" -- the font used in graphical neovim applications

vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wildmode = { "longest", "list:full" }
vim.opt.jumpoptions = "stack"

vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_input_macos_option_key_is_meta = "both"
-- vim.g.neovide_cursor_trail_size = 0.2
-- vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_refresh_rate = 60
vim.g.neovide_scroll_animation_length = 0.01
vim.g.neovide_position_animation_length = 0.01
vim.g.neovide_cursor_animation_length = 0.01
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "hard"
