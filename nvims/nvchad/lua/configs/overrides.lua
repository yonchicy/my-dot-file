local M = {}
M.treesitter = {
  ensure_installed = {
    "lua",
    "cpp",
    "rust",
    "markdown",
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
      -- selection_modes = {
      --   ['@parameter.outer'] = 'o', -- charwise
      --   ['@parameter.inner'] = 'o', -- charwise
      -- },
    },
    move = {
      enable = true,
    }
  },
  indent = { enable = false },
}
M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    --
    "clangd",
    "clang-format",
    "rust-analyzer",
    -- shell
    "shfmt",
    "shellcheck",

    -- "debug"
    "codelldb",

    -- python
    pyright,
  },
}
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('close dir'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('open'))
end
M.nvimtree = {
  on_attach = on_attach,
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  -- view = {
  -- 	mappings = {
  -- 		list = {
  -- 			{ key = "h", action = "close_node" },
  -- 			{ key = "l", action = "edit" },
  -- 		},
  -- 	},
  -- },
}

M.gitsigns = {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
}
M.nvterm = {
  terminals = {
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.1,
        col = 0.1,
        width = 0.8,
        height = 0.8,
        border = "single",
      },
    }
  },
}
M.base64 = {
  theme_toggle = { "ayu_dark", "ayu_light" },
}
return M
