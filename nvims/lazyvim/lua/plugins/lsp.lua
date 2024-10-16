local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return {

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        --
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
        jsonls = { mason = false },
        ccls = {
          init_options = {
            index = {
              threads = 2,
            }
          }
        }
      },
      handlers = handlers,
      setup = {

        clangd = function(_, opts)
          opts.cmd = { "clangd", "--header-insertion=never", "-j=16" }
        end,
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = {
        "<leader>d",
        function()
          vim.cmd("only")
          vim.cmd("vsplit")
          require("telescope.builtin").lsp_definitions({ reuse_win = false })
        end,
        desc = "go to definition in another window",
      }
    end,
  },
}
