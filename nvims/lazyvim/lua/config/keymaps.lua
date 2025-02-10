-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local nomap = vim.keymap.del

-- map jk as <ESC>
local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-x>", termcodes("<C-\\><C-N>"), { desc = "escape terminal mode" })
vim.keymap.set("t", "Jk", termcodes("<C-\\><C-N>"), { desc = "escape terminal mode" })

--map("i", "jk", "<ESC>", { desc = "escape insert mode", nowait = true })
map("i", "<C-f>", "<Right>", { desc = "move right" })
map("i", "<C-b>", "<Left>", { desc = "move left" })
map("i", "<C-n>", "<Down>", { desc = "move down" })
map("i", "<C-p>", "<Up>", { desc = "move up" })

-- go to  beginning and end
map("i", "<C-a>", "<ESC>^i", { desc = "beginning of line" })
map("i", "<C-e>", "<End>", { desc = "end of line" })

map("n", "<c-right>", "<c-w>>", { desc = "change window size" })
map("n", "<c-left>", "<c-w><", { desc = "change window size" })
map("n", "<c-up>", "<c-w>+", { desc = "change window size" })
map("n", "<c-down>", "<c-w>-", { desc = "change window size" })
map("n", "H", "^", { desc = "move to head of line" })
map("n", "L", "$", { desc = "move to end of line" })
map("n", "Q", "<C-w>q", { desc = "close windows" })

map("n", "<a-t>", function()
  vim.cmd("wa")
  Snacks.terminal.toggle(nil, {
    cwd = LazyVim.root(),
    win = {
      position = "float",
      backdrop = 60,
      height = 0.9,
      width = 0.9,
      zindex = 50,
      border = "rounded",
    },
  })
end, { desc = "Float Terminal (Root Dir)" })
map("n", "<c-W>gd", function()
  vim.cmd("only")
  vim.cmd("vsplit")
  vim.lsp.buf.definition({ reuse_win = false })
end, { desc = "go to definition in another window" })
map("n", "<leader>gd", function()
  vim.cmd("only")
  vim.cmd("vsplit")
  vim.lsp.buf.definition({ reuse_win = false })
end, { desc = "go to definition in another window" })
map("n", "gd", function()
  vim.lsp.buf.definition({ reuse_win = false })
end, { desc = "go to definition" })

map("t", "<a-t>", "<cmd>close<CR>", { desc = "close terminal" })
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "next buffer" })
map("n", "<leader>ut", function()
  local mode = vim.api.nvim_get_option_value("background", { scope = "global" })
  if mode == "light" then
    vim.api.nvim_set_option_value("background", "dark", { scope = "global" })
    os.execute(
      'sed -i \'s/background = "light"/background = "dark"/g\' ~/my-dot-file/nvims/lazyvim/lua/config/options.lua'
    )
  else
    vim.api.nvim_set_option_value("background", "light", { scope = "global" })
    os.execute(
      'sed -i \'s/background = "dark"/background = "light"/g\' ~/my-dot-file/nvims/lazyvim/lua/config/options.lua'
    )
  end
end, { desc = "toggle between light and dark" })
