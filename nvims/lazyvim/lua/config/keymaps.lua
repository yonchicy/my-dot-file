-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- map jk as <ESC>
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-x>", termcodes("<C-\\><C-N>"), { desc = "escape terminal mode" })
vim.keymap.set("t", "Jk", termcodes("<C-\\><C-N>"), { desc = "escape terminal mode" })
