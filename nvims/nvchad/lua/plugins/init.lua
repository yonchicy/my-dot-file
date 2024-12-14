local overrides = require("configs.overrides")
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    -- opts = function()
    --   require("configs.cmp_overrides")
    -- end,
    config = function(_, opts)
      local myopts = vim.tbl_deep_extend("force", opts, require "configs.cmp_overrides")
      require("cmp").setup(myopts)
    end


  },

  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
          languages = {
            cpp = "// %s",
            c = "// %s",
          },
        },
      },
    },
    -- enabled =false,
  },
  -- {
  -- "https://github.com/ziontee113/syntax-tree-surfer",
  -- event = "BufRead",
  -- keys = {
  --   {"<a-i>","<cmd>STSSelectChildNode<cr>",desc = "select child node(TS)"},
  --   {"<a-o>","<cmd>STSSelectParentNode<cr>",desc = "select parent node(TS)"},
  --   {"<a-n>","<cmd>STSSelectNextSiblingNode<cr>",desc = "select prev sibling node(TS)"},
  --   {"<a-p>","<cmd>STSSelectPrevSiblingNode<cr>",desc = "select next sibling node(TS)"},
  -- }
  -- },
  -- {
  -- 	dependencies = "nvim-treesitter",
  -- },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Uncomment if you want to re-enable which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },

  -- motion
  {

    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      require("configs.leap-nvim")
    end,
  },
  { "tpope/vim-repeat", event = "InsertEnter" },
  {
    "echasnovski/mini.surround",
    keys = require("configs.mini-surround").keys,
    opts = require("configs.mini-surround").opts,
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  -- {
  -- 	"folke/trouble.nvim",
  -- 	module = "Trouble",
  -- 	dependencies = "nvim-lspconfig",
  -- },
  --
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "InsertEnter",
  --   opts = {
  --     hint_enable = false
  --   },
  --   config = function(_, opts) require 'lsp_signature'.setup(opts) end
  -- },
  {
    "Pocco81/AutoSave.nvim",
    event = "BufRead",
    config = function()
      require("auto-save").setup()
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
  },
  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = require("configs.dap").keys,
    config = require("configs.dap").config,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = require("configs.dap").dap_ui_opts,
      },
      "nvim-neotest/nvim-nio",
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      }
    }
  }

}
