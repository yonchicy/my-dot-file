local Util = require("lazyvim.util")
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      -- change a keymap
      { "<c-p>", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fw", Util.telescope("live_grep"), desc = "Find words (root dir)" },
      { "<leader>fs", Util.telescope("lsp_dynamic_workspace_symbols"), desc = "Find symbols" },
      -- add a keymap to browse plugin files
    },
  },
  {
    "echasnovski/mini.align",
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    config = function(_, opts)
      require("auto-save").setup(opts)
    end,
  },
}
