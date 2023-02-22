local overrides = require("custom.plugins.overrides")

return {
	["nvim-treesitter/nvim-treesitter-textobjects"] = {
		after = "nvim-treesitter",
	},
	["goolord/alpha-nvim"] = false,
	-- ["ggandor/lightspeed.nvim"] = {
	-- 	event = "BufRead",
	-- },

	["ggandor/leap.nvim"] = {
		event = "BufRead",
		config = function()
			require("custom.plugins.leap-nvim")
		end,
	},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	["hrsh7th/nvim-cmp"] = {
		after = "friendly-snippets",
		config = function()
			require("custom.plugins.cmp")
		end,
	},
	-- lsp enhance
	["simrat39/symbols-outline.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	["folke/trouble.nvim"] = {
		after = "nvim-lspconfig",
	},
	["Pocco81/AutoSave.nvim"] = {
		config = function()
			require("auto-save").setup()
		end,
	},
	["tpope/vim-repeat"] = {},
	["kylechui/nvim-surround"] = {
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	["karb94/neoscroll.nvim"] = {
		event = "WinScrolled",
		config = function()
			require("custom.plugins.neoscroll")
		end,
	},
	["p00f/nvim-ts-rainbow"] = {},
	-- dev
	["folke/neodev.nvim"] = {},
	["rmagatti/goto-preview"] = {
		config = function()
			require("custom.plugins.goto-preview")
		end,
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = overrides.treesitter,
	},
	["williamboman/mason.nvim"] = {
		override_options = overrides.mason,
	},
	["nvim-tree/nvim-tree.lua"] = {
		override_options = overrides.nvimtree,
	},
	["lewis6991/gitsigns.nvim"] = {
		override_options = overrides.gitsigns,
	},
	--debug

	["mfussenegger/nvim-dap"] = {
		config = function()
			require("custom.plugins.debug").setup()
		end,
	},

	["rcarriga/nvim-dap-ui"] = {
		after = "nvim-dap",
		config = function()
			require("custom.plugins.debug").setup_ui()
		end,
	},

	-- ["theHamsta/nvim-dap-virtual-text"] = {
	-- 	after = "nvim-dap",
	-- 	config = function()
	-- 		require("nvim-dap-virtual-text").setup()
	-- 	end,
	-- },
}
