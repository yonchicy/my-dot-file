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
		dependencies = {
			-- format & linting
--			{
--				"jose-elias-alvarez/null-ls.nvim",
--				event = { "BufReadPre", "BufNewFile" },
--				config = function()
--					require("configs.null-ls")
--				end,
--			},
			{
				"hrsh7th/nvim-cmp",
				dependencies = "friendly-snippets",
				opts = overrides.cmp,
			},
		},

		config = function()
			require("configs.lspconfig")
			require("configs.lspconfig")
		end,
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
	{ "tpope/vim-repeat", event = "VeryLazy" },

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = require("configs.alpha").opts,
		config = require("configs.alpha").setup,
	},
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

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
