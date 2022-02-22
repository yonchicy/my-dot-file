local M = {}

local lspconfig = require("lspconfig")
local lua_config = function (lsp,attach,capabilities)
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
  lspconfig[lsp].setup{
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
  on_attach = attach,
  flags = {
      debounce_text_changes = 150,
  }
}
end
M.setup_lsp= function (attach,capabilities)

  local servers = {"clangd","sumneko_lua"}

  for _,lsp in ipairs(servers) do
    if lsp ~= "sumneko_lua" then
      lspconfig[lsp].setup{
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    }
    else
      lua_config(lsp,attach,capabilities)
    end
  end
end

return M
