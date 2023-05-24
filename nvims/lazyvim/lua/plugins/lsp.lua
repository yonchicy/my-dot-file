return {

  {"williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      --
      -- "clangd",
      "clang-format",
      "rust-analyzer",
      -- shell
      "shfmt",
      "shellcheck",

        -- "debug"
        "codelldb",
      },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
    config = true,
  },
}
