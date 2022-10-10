local overrides = require "custom.plugins.overrides"

return {
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter"
  },
  ["goolord/alpha-nvim"] =false,
  ["ggandor/lightspeed.nvim"] = {
    event = "BufRead",
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "custom.plugins.cmp"
    end,
  },
  -- lsp enhance
  ["simrat39/symbols-outline.nvim"] = {
    after = "nvim-lspconfig",
    config = function ()
      require("symbols-outline").setup()
    end
  },
  ["folke/trouble.nvim"] = {
    after = "nvim-lspconfig",
  },
  ["Pocco81/AutoSave.nvim"] = {
    config = function()
      require("auto-save").setup()
    end,
  },
  ["tpope/vim-repeat"] = {

  },
  ["kylechui/nvim-surround"] = {
    tag = "*",
    config = function ()
      require("nvim-surround").setup()
    end
  },
  ["p00f/nvim-ts-rainbow"] = {

  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter
  },
  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason
  },
  ["kyazdani42/nvim-tree.lua"] ={
    override_options = overrides.nvimtree,
  },
  -- dev
  ["folke/lua-dev.nvim"] = {

  },

}
