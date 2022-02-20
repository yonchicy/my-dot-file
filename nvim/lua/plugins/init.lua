local plugin_settings = require("core.utils").load_config().plugins
local present,packer = pcall(require,"plugins.packInit")
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
 
    {
       "NvChad/nvim-base16.lua",
       after = "packer.nvim",
       config = function()
          require("colors").init()
       end,
    },
 
    {
       "kyazdani42/nvim-web-devicons",
       after = "nvim-base16.lua",
       config =  require("plugins.configs.icons"),
    },
 
    {
       "akinsho/bufferline.nvim",
       after = "nvim-web-devicons",
       config = require("plugins.configs.bufferline"),
       setup = function()
          require("core.mappings").bufferline()
       end,
    },
 
    {
       "lukas-reineke/indent-blankline.nvim",
       event = "BufRead",
       config = require( "plugins.configs.others.blankline"),
    },
 
    {
       "NvChad/nvim-colorizer.lua",
       event = "BufRead",
       config = require("plugins.configs.others.colorizer"),
    },
 
    {
       "nvim-treesitter/nvim-treesitter",
       event = "BufRead",
       config = require("plugins.configs.treesitter"),
    },
 
    -- git stuff
    {
       "lewis6991/gitsigns.nvim",
       opt = true,
       config = require("plugins.configs.others.gitsigns"),
       setup = function()
          require("core.utils").packer_lazy_load "gitsigns.nvim"
       end,
    },
 
    -- lsp stuff
 
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
       config = require("plugins.configs.lspconfig"),
    },
 
    {
       "ray-x/lsp_signature.nvim",
       after = "nvim-lspconfig",
       config = require("plugins.configs.others.signature"),
    },
 
    {
       "andymass/vim-matchup",
       opt = true,
       setup = function()
          require("core.utils").packer_lazy_load "vim-matchup"
       end,
    },
 
    {
       "max397574/better-escape.nvim",
       event = "InsertCharPre",
       config = require("plugins.configs.others.better_escape"),
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
       config = require("plugins.configs.cmp"),
    },
 
    {
       "L3MON4D3/LuaSnip",
       wants = "friendly-snippets",
       after = "nvim-cmp",
       config = require("plugins.configs.others.luasnip"),
    },
 
    {
       "saadparwaiz1/cmp_luasnip",
       after = plugin_settings.options.cmp.lazy_load and "LuaSnip",
    },
 
    {
       "hrsh7th/cmp-nvim-lua",
       disable = not plugin_settings.status.cmp,
       after = "cmp_luasnip",
    },
 
    {
       "hrsh7th/cmp-nvim-lsp",
       disable = not plugin_settings.status.cmp,
       after = "cmp-nvim-lua",
    },
 
    {
       "hrsh7th/cmp-buffer",
       disable = not plugin_settings.status.cmp,
       after = "cmp-nvim-lsp",
    },
 
    {
       "hrsh7th/cmp-path",
       disable = not plugin_settings.status.cmp,
       after = "cmp-buffer",
    },
 
    -- misc plugins
    {
       "windwp/nvim-autopairs",
       disable = not plugin_settings.status.autopairs,
       after = plugin_settings.options.autopairs.loadAfter,
       config = require("plugins.configs.others.autopairs"),
    },
 
    {
       "goolord/alpha-nvim",
       config = require("plugins.configs.alpha"),
    },
 
    {
       "numToStr/Comment.nvim",
       disable = not plugin_settings.status.comment,
       module = "Comment",
       keys = { "<c-_>","<leader>/","<leader>cl" },
       config = require("plugins.configs.others.comment"),
       setup = function()
          require("core.mappings").comment()
       end,
    },
 
    -- file managing , picker etc
    {
       "kyazdani42/nvim-tree.lua",
       disable = not plugin_settings.status.nvimtree,
       -- only set "after" if lazy load is disabled and vice versa for "cmd"
       after = not plugin_settings.options.nvimtree.lazy_load and "nvim-web-devicons",
       cmd = plugin_settings.options.nvimtree.lazy_load and { "NvimTreeToggle", "NvimTreeFocus" },
       config = require("plugins.configs.nvimtree"),
       setup = function()
          require("core.mappings").nvimtree()
       end,
    },
 
    {
       "nvim-telescope/telescope.nvim",
       module = "telescope",
       cmd = "Telescope",
       config = require("plugins.configs.telescope"),
       setup = function()
          require("core.mappings").telescope()
       end,
    },

    {
        "phaazon/hop.nvim",
        event = "BufRead",
        config = require("plugins.configs.motion.hop"),
    },

    {
		'Pocco81/AutoSave.nvim',
        config=function ()
            require("autosave").setup()
        end,
    }

 }
-- packer.startup(
-- {
-- 	function(use)
-- 		-- lsp
-- 		-- use 'tversteeg/registers.nvim'
-- 		-- use 'simrat39/symbols-outline.nvim'
-- 		-- use 'wellle/context.vim'


-- 		use 'vim-scripts/argtextobj.vim'
-- 		use{
-- 			"folke/trouble.nvim",
-- 			requires="kyazdani42/nvim-web-devicons",
-- 		}
-- 		use 'tpope/vim-surround'
-- 		use 'tpope/vim-commentary'
-- 		use 'tpope/vim-dispatch'
-- 		-- use 'ggandor/lightspeed.nvim'
-- 		use 'jiangmiao/auto-pairs'
-- 		use 'unblevable/quick-scope'
-- 		use 'psliwka/vim-smoothie'
-- 		use 'junegunn/vim-easy-align'
-- 		use 'hoob3rt/lualine.nvim'
-- 		use 'p00f/nvim-ts-rainbow'

-- 		use {
-- 			'akinsho/bufferline.nvim',requires = 'kyazdani42/nvim-web-devicons',
-- 		}
-- 		use 'hrsh7th/cmp-nvim-lsp'
-- 		use 'hrsh7th/cmp-buffer'
-- 		use {
-- 			'hrsh7th/nvim-cmp',
-- 			requires = {
-- 				'L3MON4D3/LuaSnip' ,
-- 				"saadparwaiz1/cmp_luasnip",
-- 				"rafamadriz/friendly-snippets"
-- 			}
-- 		}
-- 		use {
-- 			'nvim-treesitter/nvim-treesitter',
-- 			-- run=':TSUpdate'
-- 		}

-- 		use {
-- 			'nvim-treesitter/nvim-treesitter-textobjects',
-- 		}
-- 		use {
-- 			'nvim-telescope/telescope-fzf-native.nvim',run='make'
-- 		}
-- 		-- use {
-- 		-- 	"jose-elias-alvarez/null-ls.nvim",
-- 		-- 	after = "nvim-lspconfig",
-- 		-- }

-- 	end,
-- 	config={
-- 		git={
-- 			default_url_format='https://github.com/%s',
-- 			clone_timeout = 10000
-- 		}
-- 	}
-- }
-- )

return packer.startup(function (use)
    for _ ,v in pairs(plugins) do
        use(v)
    end
end)