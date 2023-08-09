local Util = require("lazyvim.util")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- general
vim.keymap.set("i", "jk", "<esc>", { desc = "escape from insert mode", nowait = true })
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "  move left" })
vim.keymap.set("i", "<c-f>", "<right>", { desc = " move right" })
vim.keymap.set("i", "<c-n>", "<down>", { desc = " move down" })
vim.keymap.set("i", "<C-p>", "<Up>", { desc = " move up" })
vim.keymap.set("i", "<C-a>", "<ESC>^i", { desc = "論 beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "壟 end of line" })

vim.keymap.set("n", "<leader>1", "1<C-w>w", { desc = "move to window 1" })
vim.keymap.set("n", "H", "^", { desc = "move to head of line" })
vim.keymap.set("n", "L", "$", { desc = "move to end of line" })
vim.keymap.set("v", "H", "^", { desc = "move to head of line" })
vim.keymap.set("v", "L", "$", { desc = "move to end of line" })
vim.keymap.set("n", "<c-right>", "<c-w>>", { desc = "change window size" })
vim.keymap.set("n", "<c-left>", "<c-w><", { desc = "change window size" })
vim.keymap.set("n", "<c-up>", "<c-w>+", { desc = "change window size" })
vim.keymap.set("n", "<c-down>", "<c-w>-", { desc = "change window size" })
vim.keymap.set("n", "H", "^", { desc = "move to head of line" })
vim.keymap.set("n", "L", "$", { desc = "move to end of line" })
vim.keymap.set("n", "<leader>hl", "<cmd> noh <CR>", { desc = "  no highlight" })
vim.keymap.set("n", "Q", "<C-w>q", { desc = "close windows" })
vim.keymap.set("n", "<leader>wq", "<cmd>wa!<CR><cmd>qa!<CR>", { desc = "save and exit vim" })

-- switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "window up" })

vim.keymap.set("n", "<leader>1", "1<C-w>w", { desc = "move to window 1" })
vim.keymap.set("n", "<leader>2", "2<C-w>w", { desc = "move to window 2" })
vim.keymap.set("n", "<leader>3", "3<C-w>w", { desc = "move to window 3" })
vim.keymap.set("n", "<leader>4", "4<C-w>w", { desc = "move to window 4" })
vim.keymap.set("n", "<leader>5", "5<C-w>w", { desc = "move to window 5" })

-- save
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "save file" })

-- Copy all
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "copy whole file" })

-- line numbers
-- ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
-- ["<leader>rn"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },

-- update nvchad
-- ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "  update nvchad" },

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
-- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
-- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
vim.keymap.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- bufferline
vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- vim.keymap.set("n", "<leader>ft", function()
--   Util.float_term(nil, { cwd = Util.get_root() })
-- end, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>fT", function()
  Util.float_term()
end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "Jk", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- toggle
vim.keymap.set("n", "<leader>ut", function()
  local mode = vim.api.nvim_get_option_value("background", {})
  if mode == "dark" then
    vim.api.nvim_set_option_value("background", "light", {})
    os.execute('sed -i "28s/dark/light/" $HOME/my-dot-file/nvims/lazyvim/lua/config/options.lua')
  elseif mode == "light" then
    vim.api.nvim_set_option_value("background", "dark", {})
    os.execute('sed -i "28s/light/dark/" $HOME/my-dot-file/nvims/lazyvim/lua/config/options.lua')
  end
end, { desc = "toggle theme between light and dark" })
