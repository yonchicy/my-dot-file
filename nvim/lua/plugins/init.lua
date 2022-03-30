local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local plugins = {
   { "nvim-lua/plenary.nvim" },
   { "lewis6991/impatient.nvim" },
   { "nathom/filetype.nvim" },
   {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   },
-- UIs
   {
      "NvChad/nvim-base16.lua",
      after = "packer.nvim",
      config = function()
         require("colors").init()
      end,
   },

   {
      "feline-nvim/feline.nvim",
      after = "nvim-web-devicons",
      config =function ()
        require( "plugins.configs.statusline").setup()
      end

  },
   {
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config =function ()
        require("plugins.configs.bufferline").setup()
      end,
      setup = function()
         require("core.mappings").bufferline()
      end,
   },
  {
    "kyazdani42/nvim-web-devicons",
    after = "nvim-base16.lua",
    config =function ()
       require("plugins.configs.icons").setup()
    end
  },
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config =function ()
          require("plugins.configs.others").blankline()
      end
  },
   {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function ()
         require( "plugins.configs.treesitter").setup()
      end
   },
   {
       "justinmk/vim-syntax-extra",
       event = "BufRead"
   },
   {
       "luochen1990/rainbow",
   },
   {
       "norcalli/nvim-colorizer.lua",
       config = require("plugins.configs.others").nvim_colorizer(),
   },
   -- git stuff
   {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = require("plugins.configs.others").gitsigns(),
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   },
  -- lsp
  {
      'williamboman/nvim-lsp-installer',
      cmd = {"LspInstall","LspInstallInfo"},
      config = require("plugins.configs.others").lsp_installer(),
  },
   {
       "neovim/nvim-lspconfig",
       module = "lspconfig",
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      config = function ()
        require( "plugins.configs.lspconfig")
      end
   },
   {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function ()
         require("plugins.configs.others").signature()
      end
   },

   -- load luasnips + cmp related in insert mode only

   {
      "rafamadriz/friendly-snippets",
      module = "cmp_nvim_lsp",
      event = "InsertCharPre",
   },

   {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function ()
        require( "plugins.configs.cmp").setup()
      end
   },

   {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
require( "plugins.configs.others").luasnip()
    end
   },

   {
      "saadparwaiz1/cmp_luasnip",
      after =  "LuaSnip",
   },

   {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   },

   {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   },

   {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   },

   {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   },
   -- misc plugins
   {
       "Pocco81/AutoSave.nvim",
       config = function ()
           require("autosave").setup()
       end
   },
   {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function ()
        require( "plugins.configs.others").autopairs()
      end
   },
  {
    "psliwka/vim-smoothie",
    -- cmd = {"<c-d>","<c-u>"},
    event = "WinScrolled",
  },
   {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gcc" },
    config = function ()
      require( "plugins.configs.others").comment()

    end,
    setup = function()
      require("core.mappings").comment()
    end,
   },
   {
        "junegunn/vim-easy-align",
        keys = {"ga"},
    config = function ()
        vim.cmd[[xmap ga <Plug>(EasyAlign)]]
        vim.cmd[[nmap ga <Plug>(EasyAlign)]]

    end,
   },
   {
       "folke/todo-comments.nvim",
       event = "BufRead",
       config = function ()
           require("todo-comments").setup()
       end,
   },
   -- file managing , picker etc
   {
      "kyazdani42/nvim-tree.lua",
      -- only set "after" if lazy load is disabled and vice versa for "cmd"
      cmd =  { "NvimTreeToggle", "NvimTreeFocus" },
      config = function ()
        require( "plugins.configs.nvimtree").setup()
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   },
   {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      config = function ()
         require( "plugins.configs.telescope").setup()
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   },
   {
       "nvim-telescope/telescope-fzf-native.nvim",
       run='make',
       event = "BufRead"
   },
   -- project managing
   {
    "tpope/vim-dispatch",
    cmd = {"Make","Dispatch"}
   },
   {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function ()
        require("trouble").setup()
    end,
    setup = function()
         require("core.mappings").trouble()
      end,
   },
  -- argstextobj
  {
    "vim-scripts/argtextobj.vim",
  },
  {
    "tpope/vim-surround",
    keys={"c","d","y","v"}
  },
  {
    "tpope/vim-repeat",
  },
  -- motion
  {
      "phaazon/hop.nvim",
      event = "BufRead",
      config =function ()
        require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end,
      setup = function ()
          require("core.mappings").hop()
      end,
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    module =  "dap" ,
    config = function()
        -- require( "plugins.configs.dap").setup()
    end,
  },

  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    cmd = "DIInstall",
    config = function()
        require( "dap-install").setup({
            installation_path = vim.fn.stdpath("data").."/dapintall/",
        })
    end,
  },

}


return packer.startup(function (use)
  for _,v in pairs(plugins) do
    use(v)
  end
end)
