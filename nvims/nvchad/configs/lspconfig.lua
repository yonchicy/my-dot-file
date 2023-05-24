local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "clangd", "lua_ls", "rust_analyzer" }

for _, lsp in ipairs(servers) do
	if lsp == "clangd" then
		capabilities.offsetEncoding = "utf-16"
	else
		capabilities.offsetEncoding = "utf-8"
	end
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
