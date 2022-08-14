


return {
    ["max397574/better-escape.nvim"] = {
      event = "InsertEnter",
      config = function()
         require("better_escape").setup()
      end,
   },
   ["nvim-treesitter/nvim-treesitter-textobjects"] = {
        after = "nvim-treesitter"
   },
  ["goolord/alpha-nvim"] = {
    after = "base46",
    disable = false,
    config = function()
      require "plugins.configs.alpha"
    end,
  },
  ["ggandor/lightspeed.nvim"]={
    event= "BufRead",
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
   -- config = function()
 },
 ["folke/trouble.nvim"] = {
   after = "nvim-lspconfig",
 },
 ["Pocco81/AutoSave.nvim"] = {
   config = function()
     require("auto-save").setup()
   end,
 },
  ["tpope/vim-repeat"] ={

  },
  ["tpope/vim-surround"]={

  },

}
