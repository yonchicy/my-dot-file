return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      ensure_installed = {
        "lua",
        "cpp",
        "rust",
        "c"
      },
      context_commentstring = {
        enable = true,
        --enable_autocmd = false,
        config = {
          c = "//%s",
          cpp = "//%s",
        },
      },
    },
  },
}
