local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = ''
plug_url_format = 'https://github.com/%s'

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
		use 'wbthomason/packer.nvim'
		use 'morhetz/gruvbox'
		use 'glepnir/dashboard-nvim'
		use{
			'phaazon/hop.nvim',
			as = 'hop',
			config = function()
				require'hop'.setup {keys='etovxqpdygfblzhckisuran'}
			end
		}
		use 'tpope/vim-surround'
		use 'tpope/vim-commentary'
		use 'easymotion/vim-easymotion'
		use 'jiangmiao/auto-pairs'
		use 'rhysd/clever-f.vim'
		use 'unblevable/quick-scope'
		use 'preservim/nerdtree'
		use 'psliwka/vim-smoothie'
		use 'junegunn/vim-easy-align'
		use 'hoob3rt/lualine.nvim'
		
		-- use 'vim-airline/vim-airline'
		use 'junegunn/fzf.vim'
		use {
			'junegunn/fzf' ,
			-- function()
			-- vim.fn['fzf#install']()
		-- end
		}
		use {
			'akinsho/bufferline.nvim',requires = 'kyazdani42/nvim-web-devicons'
		}
		use 'frazrepo/vim-rainbow'
		use 'vim-scripts/argtextobj.vim'
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
