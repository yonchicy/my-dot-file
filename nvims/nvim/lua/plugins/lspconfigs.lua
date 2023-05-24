local M = {}

M.servers = {"clangd","sumneko_lua","rust_analyzer","cmake","pyright","html","jdtls"}

local lspconfig = require("lspconfig")
local lua_config = function (attach,capabilities)
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
  return {
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

    local present, lsp_installer = pcall(require ,"nvim-lsp-installer")
    if not present then
        vim.notify("can't find lsp-install when loading lsp config")
        return
    end

    local enhance_server_opts = {
        -- Provide settings that should only apply to the "eslint" server
        ["sumneko_lua"] = lua_config(attach,capabilities),
    }

    lsp_installer.on_server_ready(function(server)
        -- Specify the default options which we'll use to setup all servers
        local opts = {
            on_attach = attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }

        if enhance_server_opts[server.name] then
            -- Enhance the default opts with the server-specific ones
            server:setup(enhance_server_opts[server.name])
        else
            server:setup(opts)
        end
    end)


    -- for _,lsp in ipairs(M.servers) do
    --     if lsp ~= "sumneko_lua" then
    --         lspconfig[lsp].setup{
    --         }
    --     else
    --         lua_config(lsp,attach,capabilities)
    --     end
    -- end
end

return M
