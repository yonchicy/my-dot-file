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
        "c",
      },
      indent={
        enable = false,
      },
      incremental_selection = {
        enable = false,
      },
      textobjects = {
        enable=false,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
      languages = {
        cpp = "// %s",
        c = "// %s",
      },
    },
  },
}
