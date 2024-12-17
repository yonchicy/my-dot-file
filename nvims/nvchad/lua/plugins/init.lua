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
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   opts = {
  --     extensions = {
  --       workspaces = {
  --         -- keep insert mode after selection in the picker, default is false
  --         keep_insert = true,
  --         -- Highlight group used for the path in the picker, default is "String"
  --         path_hl = "String"
  --       }
  --     }
  --   }
  -- },

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
    "folke/flash.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
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
    "natecraddock/workspaces.nvim",
    opts = {},
    event = "BufRead",
    config = function(_, opts)
      require("workspaces").setup(opts)
      require("telescope").load_extension("workspaces")
    end
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
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "InsertEnter",

    module = "CopilotChat",
    dependencies = {
      { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                          -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
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
