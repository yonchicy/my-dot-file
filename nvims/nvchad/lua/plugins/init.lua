local overrides = require("configs.overrides")
local lspconfig = require("configs.lspconfig")
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
      require("configs.lspconfig")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event="VeryLazy",
    opts = overrides.cmp,
  },

  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- enabled =false,
  },
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
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      hint_enable = false
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
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
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  }

}
