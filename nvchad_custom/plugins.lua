local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				event = { "BufReadPre", "BufNewFile" },
				config = function()
					require("custom.configs.null-ls")
				end,
			},
			{
				"hrsh7th/nvim-cmp",
				dependencies = "friendly-snippets",
				opts = overrides.cmp,
			},
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	-- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter",
	},

	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

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
			require("custom.configs.leap-nvim")
		end,
	},
	{ "tpope/vim-repeat", event = "VeryLazy" },

	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = require("custom.configs.alpha").opts,
		config = require("custom.configs.alpha").setup,
	},
}

return plugins
--
-- return {
--
-- 	-- lsp enhance
-- 	["simrat39/symbols-outline.nvim"] = {
-- 		after = "nvim-lspconfig",
-- 		config = function()
-- 			require("symbols-outline").setup()
-- 		end,
-- 	},
-- 	["folke/trouble.nvim"] = {
-- 		after = "nvim-lspconfig",
-- 	},
-- 	["Pocco81/AutoSave.nvim"] = {
-- 		config = function()
-- 			require("auto-save").setup()
-- 		end,
-- 	},
-- 	["kylechui/nvim-surround"] = {
-- 		tag = "*",
-- 		config = function()
-- 			require("nvim-surround").setup()
-- 		end,
-- 	},
-- 	["p00f/nvim-ts-rainbow"] = {},
-- 	-- dev
-- 	["folke/neodev.nvim"] = {},
-- 	["rmagatti/goto-preview"] = {
-- 		config = function()
-- 			require("custom.plugins.goto-preview")
-- 		end,
-- 	},
--
-- 	["nvim-treesitter/nvim-treesitter"] = {
-- 		override_options = overrides.treesitter,
-- 	},
-- 	["williamboman/mason.nvim"] = {
-- 		override_options = overrides.mason,
-- 	},
-- 	["nvim-tree/nvim-tree.lua"] = {
-- 		override_options = overrides.nvimtree,
-- 	},
-- 	--debug
--
-- 	["mfussenegger/nvim-dap"] = {
-- 		config = function()
-- 			require("custom.plugins.debug").setup()
-- 		end,
-- 	},
--
-- 	["rcarriga/nvim-dap-ui"] = {
-- 		after = "nvim-dap",
-- 		config = function()
-- 			require("custom.plugins.debug").setup_ui()
-- 		end,
-- 	},
--
-- 	-- ["theHamsta/nvim-dap-virtual-text"] = {
-- 	-- 	after = "nvim-dap",
-- 	-- 	config = function()
-- 	-- 		require("nvim-dap-virtual-text").setup()
-- 	-- 	end,
-- 	-- },
-- }
--
