return {

  {"williamboman/mason.nvim",
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

  {
    "neovim/nvim-lspconfig",
    ---@class pluginlspopts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        jsonls = {mason=false},
      },
      setup = {
        clangd = function(_,opts)
          opts.cmd = {"clangd", "--header-insertion=never"}
        end,
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "<leader>d", 
        function()
          vim.cmd('only')
          vim.cmd('vsplit')
          require("telescope.builtin").lsp_definitions({ reuse_win = false }) 
        end
        ,desc = "go to definition in another window" }

    end,
  },
}
