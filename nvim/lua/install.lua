local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = ''
plug_url_format = 'https://hub.fastgit.org/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

local packer=require('packer')
packer.startup(
{
	function(use)
		use 'tversteeg/registers.nvim'
		use 'wbthomason/packer.nvim'
		use 'rhysd/clever-f.vim'
		use 'olimorris/onedarkpro.nvim'
		use 'chentau/marks.nvim'
		use 'morhetz/gruvbox'
		use 'sainnhe/sonokai'
		use 'shaunsingh/nord.nvim'
		use 'EdenEast/nightfox.nvim'
		use 'folke/lsp-colors.nvim'
		-- use 'folke/todo-comments.nvim'
		use{
				'kristijanhusak/orgmode.nvim' ,
				config=function()
					require('orgmode').setup{}
				end
			}
		use 'kevinhwang91/rnvimr'
		use {
				'kyazdani42/nvim-tree.lua' ,
				requires = 'kyazdani42/nvim-web-devicons',
				config=function()require'nvim-tree'.setup{}end
			}
		use 'lewis6991/gitsigns.nvim'
		use 'sainnhe/gruvbox-material'
		use { 'TimUntersberger/neogit' }
		use 'folke/tokyonight.nvim'
		use 'Pocco81/AutoSave.nvim'
		use 'marko-cerovac/material.nvim'
		use 'glepnir/dashboard-nvim'
		use 'vim-scripts/argtextobj.vim'
		use 'akinsho/toggleterm.nvim'
		use{
			'phaazon/hop.nvim',
			as = 'hop',
			config = function()
				require'hop'.setup {keys='etovxqpdygfblzhckisuran'}
			end
		}
		use{
			"folke/trouble.nvim",
			requires="kyazdani42/nvim-web-devicons",
		}
		use 'tpope/vim-surround'
		use 'tpope/vim-repeat'
		use 'tpope/vim-commentary'
		-- use 'ggandor/lightspeed.nvim'
		use 'easymotion/vim-easymotion'
		use 'jiangmiao/auto-pairs'
		use 'unblevable/quick-scope'
		use 'psliwka/vim-smoothie'
		use 'junegunn/vim-easy-align'
		use 'hoob3rt/lualine.nvim'
		use 'p00f/nvim-ts-rainbow'
		use 'junegunn/fzf.vim'
		use {
			'junegunn/fzf' ,
		}
		use {
			'akinsho/bufferline.nvim',requires = 'kyazdani42/nvim-web-devicons'
		}
		use 'neovim/nvim-lspconfig'
		use 'williamboman/nvim-lsp-installer'
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/nvim-cmp'
		use 'Pocco81/TrueZen.nvim'
		use {
			'L3MON4D3/LuaSnip' ,
			requires = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets"
			}

		}
		use {
			'nvim-treesitter/nvim-treesitter',
			run=':TSUpdate'
		}

		use {
			'nvim-treesitter/nvim-treesitter-textobjects',
		}
		use {
			'nvim-telescope/telescope.nvim',
			requires={{'nvim-lua/plenary.nvim'}}
		}

	end,
	config={
		git={
			default_url_format='https://hub.fastgit.org/%s'
		}
	}
}
)
