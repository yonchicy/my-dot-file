require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

nomap("n", "<c-s>")
nomap("n", "<c-c>")
nomap("n", "<leader>rn")
nomap("n", "<leader>h")
nomap("n", "<a-i>")
nomap("t", "<a-i>")

map("n", "<leader>ut", function()
  require("base46").toggle_theme()
end, { desc = "toggle between themes" })
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "toggle between transparency" })

-- map("i", "jk", "<ESC>", { desc = "escape insert mode", nowait = true })
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
map("n", "<leader>wq", "<cmd>wa!<CR><cmd>qa!<CR>", { desc = "save and exit vim" })
map("n", "<leader>ww", "<cmd>wa<CR>", { desc = "save all files" })
map("n", "<leader>hl", "<cmd>noh<CR>", { desc = "clear highlights" })
map("n", "<leader>fn", "<cmd>echo @%<CR>", { desc = "clear highlights" })

map("t", "<C-x>", termcodes "<C-\\><C-N>", { desc = "escape terminal mode" })
map("t", "Jk", termcodes "<C-\\><C-N>", { desc = "escape terminal mode" })

map({ "n", "t" }, "<a-t>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm", float_opts = {
    width = 0.9,
    height = 0.8,
    row = 0.06,
    col = 0.05,
  } }
end, { desc = "Terminal Toggle Floating term" })

map("v", "H", "^", { desc = "move to head of line" })
map("v", "L", "$", { desc = "move to end of line" })

map("n", "<C-_>", "gcc", { desc = "toggle comment" })

map(
  "v",
  "<C-_>",
  "gc",
  { desc = "toggle comment" }
)
map("n", "gd", function()
  require("telescope.builtin").lsp_definitions { reuse_win = false }
end, { desc = "go to definition" })
map("n", "gr", function()
  require("telescope.builtin").lsp_references { reuse_win = false }
end, { desc = "go to references" })
map("n", "<leader>cf", function()
  vim.lsp.buf.format()
end, { desc = "code format" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "code action" })
map("n", "<leader>cr", function()
  -- require "nvchad.lsp.renamer" ()
  vim.lsp.buf.rename()
end, { desc = "rename symbol" })
map("n", "gh", function()
  vim.lsp.buf.hover()
end, { desc = "lsp hover" })
map("n", "ge", function()
  vim.diagnostic.open_float()
end, { desc = "floating diagnostic" })

map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics()
end, { desc = "find diagnostics in workspace" })
map("n", "<leader>fp", "<cmd>Telescope workspaces<CR>", { desc = "find workspaces" })

map("n", "<leader>gd", function()
  vim.cmd "only"
  vim.cmd "vsplit"
  require("telescope.builtin").lsp_definitions { reuse_win = false }
end, { desc = "go to definition in another window" })

map("n", "<C-p>",
  require("telescope.builtin").find_files
  , { desc = "go to definition in another window" })
map("n", "<leader>fs",
  "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>"
  , { desc = "find symbols" })

map("n", "<leader>ft",
  "<cmd> Telescope lsp_document_symbols <CR>"
  , { desc = "find buffer symbols" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })

-- M.debug = {
-- 	n = {
-- 		["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
-- 		["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
-- 		["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
-- 		["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
-- 		["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
-- 		["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
-- 		["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
-- 		["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
-- 		["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
-- 		["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
-- 		["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
-- 		["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
-- 		["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
-- 		["<leader>dU"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
-- 	},
-- }
map('n', "]c", "<cmd>cn<CR>", { desc = "go to next quickfix item" })
map('n', "[c", "<cmd>cp<CR>", { desc = "go to prev quickfix item" })
map('n', "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "go to prev hunk" })
map('n', "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", { desc = "go to next hunk" })
map('i', '<C-L>', '<Plug>(copilot-accept-word)', { desc = "accept copilot word" })
map('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
}, { desc = "accept copilot word" })


map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "close all buffers excludes current buffer" })

map("n", "<leader>a", function()
  vim.cmd "only"
  require("CopilotChat").toggle()
end, { desc = "Toggle CopilotChat" })

map("n", "<leader>o", function()
  vim.cmd"SymbolsOutline"
end, { desc = "toogle symbols outline" })





-- M.trouble = {
--   n = {
--     ["<leader>xx"] = {
--       function()
--         require("trouble").toggle()
--       end,
--       "   Trouble",
--     },
--     ["<leader>xw"] = {
--       function()
--         require("trouble").toggle "workspace_diagnostics"
--       end,
--       "   Trouble workspace_diagnostics",
--     },
--     ["<leader>xd"] = {
--       function()
--         require("trouble").toggle "document_diagnostics"
--       end,
--       "   Trouble document_diagnostics",
--     },
--     ["<leader>xl"] = {
--       function()
--         require("trouble").toggle "loclist"
--       end,
--       "   Trouble loclist",
--     },
--     ["<leader>xq"] = {
--       function()
--         require("trouble").toggle "quickfix"
--       end,
--       "   Trouble quickfix",
--     },
--     ["gr"] = {
--       function()
--         require("trouble").toggle "lsp_references"
--       end,
--       "   Trouble lsp_references",
--     },
--   },
-- }
