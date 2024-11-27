require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
local opt = vim.opt
local g = vim.g

g.copilot_proxy = "http://localhost:7890"
g.copilot_no_tab_map = true

opt.nu = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wildmode = { "longest", "list:full" }
opt.guifont = "FiraCode Nerd Font:h14" -- the font used in graphical neovim applications
 
-- hilight yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150, on_visual = true }) end })
g.neovide_cursor_vfx_mode = "railgun"

-- g.neovide_transparency = 0.7

vim.lsp.inlay_hint.enable(true)



vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
  pattern = "term://*",
  callback = function()
    vim.keymap.set("n", "<leader>cd", "<c-w>F<cmd>only<CR>", { silent = true, noremap = true, buffer = true, desc =
    "go to file" })
  end
}
)

-- for comment string
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end

vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_input_macos_option_key_is_meta = 'both'
-- vim.g.neovide_cursor_trail_size = 0.2
-- vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_vfx_mode = "torpedo"
