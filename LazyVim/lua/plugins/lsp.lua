return {

  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      --
      "clangd",
      "clang-format",
      "rust-analyzer",
      -- shell
      "shfmt",
      "shellcheck",

      -- "debug"
      "codelldb",
    },
  },
}
