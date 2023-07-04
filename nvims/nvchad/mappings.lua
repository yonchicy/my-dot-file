---@type MappingsTable
local M = {}

-- M.general = {
--   n = {
--     [";"] = { ":", "enter command mode", opts = { nowait = true } },
--   },
-- }

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["Q"] = "",
    ["<ESC>"] = "",
    ["<c-s>"] = "",
    ["<c-c>"] = "",
  },
  v = {
    ["j"] = "",
    ["k"] = "",
    ["<ESC>"] = "",
  },
  x = {
    ["p" ] = "",
    ["<ESC>"] = "",
  }
}
M.build_system = {
  n= {
    ['<f5>'] = { ":set mp=" ,"set makeprg"},
  }
}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode" ,opts = {nowait=true}},
    ["<C-f>"] = { "<Right>", " move right" },
    ["<C-b>"] = { "<Left>", "  move left" },
    ["<C-n>"] = { "<Down>", " move down" },
    ["<C-p>"] = { "<Up>", " move up" },

    -- go to  beginning and end
    ["<C-a>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },

  },

  n = {

    ["<c-right>"] = { '<c-w>>', "change window size" },
    ["<c-left>"] = { '<c-w><', "change window size" },
    ["<c-up>"] = { '<c-w>+', "change window size" },
    ["<c-down>"] = { '<c-w>-', "change window size" },
    ["H"] = { '^', "move to head of line" },
    ["L"] = { '$', "move to end of line" },
    ["Q"] = { "<C-w>q", "close windows" },
    ["<leader>q"] = { "<cmd>wa!<CR><cmd>q!<CR>", "close windows" },
    ["<leader>wq"] = { "<cmd>wa!<CR><cmd>qa!<CR>", "save and exit vim" },
    ["<leader>ww"] = { "<cmd>wa<CR>", "save all files" },
    ["<leader>hl"] = { "<cmd>noh<CR>", "clear highlights" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    ["<leader>1"] = { "1<C-w>w", "move to window 1" },
    ["<leader>2"] = { "2<C-w>w", "move to window 2" },
    ["<leader>3"] = { "3<C-w>w", "move to window 3" },
    ["<leader>4"] = { "4<C-w>w", "move to window 4" },
    ["<leader>5"] = { "5<C-w>w", "move to window 5" },


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
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },

  t = {
    ["<C-x>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
    ["Jk"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
  },

  v = {
    ["H"] = { '^', "move to head of line" },
    ["L"] = { '$', "move to end of line" },
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    -- ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

M.tabufline = {
  n = {
    -- close buffer + hide terminal buffer
    ["<leader>bc"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },

    -- pick buffers via numbers
    -- ["<leader>bp"] = { "<cmd> TbufPick <CR>", "Pick buffer" },
  },
}

M.comment = {
  -- toggle comment in both modes
  n = {
    ["<C-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
   ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "   lsp hover",
    },

    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },

    -- ["gr"] = {
    --   function()
    --     vim.lsp.buf.references()
    --   end,
    --   "   lsp references",
    -- },

    ["ge"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>xs"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

    -- focus
    ["<C-b>"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>bp"] = { "<cmd> Telescope buffers<CR>", "Pick buffer" },
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
    ["<leader>ft"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "   find symbols" },
    ["<leader>fc"] = { "<cmd> Telescope command_history <CR>", "   find command history" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "toggle vertical term",
    },

    -- new

    -- ["<leader>h"] = {
    --   function()
    --     require("nvterm.terminal").new "horizontal"
    --   end,
    --   "new horizontal term",
    -- },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "new vertical term",
    },
  },
}


M.blankline = {
  n = {
    ["<leader>bl"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current_context",
    },
  },
}

M.debug = {
  n  = {
    ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    ["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    ["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    ["<leader>dU"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },

  }
}

M.trouble = {
  n = {
    ["<leader>xx"] = {
      function()
        vim.cmd "TroubleToggle"
      end,
      "   Trouble",

    },
    ["<leader>xw"] = {
      function()
        vim.cmd "Trouble workspace_diagnostics"
      end,
      "   Trouble workspace_diagnostics",
    },
    ["<leader>xd"] = {
      function()
        vim.cmd "Trouble document_diagnostics"
      end,
      "   Trouble document_diagnostics",
    },
    ["<leader>xl"] = {
      function()
        vim.cmd "Trouble loclist"
      end,
      "   Trouble loclist",
    },
    ["<leader>xq"] = {
      function()
        vim.cmd "Trouble quickfix"
      end,
      "   Trouble quickfix",
    },
    ["gr"] = {
      function()
        vim.cmd "Trouble lsp_references"
      end,
      "   Trouble lsp_references",
    },
  }
}
return M

