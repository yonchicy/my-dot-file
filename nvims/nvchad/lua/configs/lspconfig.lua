local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright", "gopls" }
local servers = { "clangd", "lua_ls", "pyright", "gopls" }

-- local border = {
--   { "🭽", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "🭾", "FloatBorder" },
--   { "▕", "FloatBorder" },
--   { "🭿", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "🭼", "FloatBorder" },
--   { "▏", "FloatBorder" },
-- }
--
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
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
-- }

local clangd_cap = capabilities
clangd_cap.offsetEncoding = 'utf-16'
local set_ups = {
  clangd = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = clangd_cap,
    cmd = { "clangd", "--header-insertion=never", "-j=8" },
  },
  lua_ls = {
    -- handlers = {
    --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    --   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    -- -- },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  -- rust_analyzer = {
  --   cmd={'rust-analyzer'},
  --   on_attach = on_attach,
  --   on_init = on_init,
  --   capabilities = capabilities,
  -- },
  -- rust_analyzer = {
  -- 	on_attach = on_attach,
  --    on_init = on_init,
  -- 	capabilities = capabilities,
  -- 	settings = {
  -- 		["rust-analyzer"] = {
  -- 			checkOnSave = {
  -- 				allTargets = false,
  -- 				extraArgs = { "--bins" },
  -- 			},
  -- 			cargo = {
  -- 				target =  "aarch64-unknown-none-softfloat" ,
  -- 				features = { "bsp_rpi3" },
  -- 			},
  -- 			lens = {
  -- 				debug = false,
  -- 				run = false,
  -- 			},
  -- 		},
  -- 	},
  -- },
  pyright = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  },
  ccls = {
    init_options = {
      index = {
        threads = 2,
      },
    },
  },
  gopls = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

  }
}
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(set_ups[lsp])
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          -- Disable virtual_text
          virtual_text = true
        }
      ),
    },

    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
