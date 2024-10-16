return {

  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    "sainnhe/sonokai",
    lazy = true,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
  },
  {
    "sainnhe/everforest",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "latte", -- latte, frappe, macchiato, mocha
    },
    priority = 1000,
    -- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
  },
  {
    -- Nightfox,Dayfox Duskfox Dawnfox Nordfox Terafox Carbonfox
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    -- vim.cmd("colorscheme kanagawa-wave")
    -- vim.cmd("colorscheme kanagawa-dragon")
    -- vim.cmd("colorscheme kanagawa-lotus")
    -- kanagawa
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    -- github_dark_dimmed
    --             github_light
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
}
