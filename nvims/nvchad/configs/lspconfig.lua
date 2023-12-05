local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright" }

local set_ups = {
	clangd = {
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "clangd", "--header-insertion=never", "-j=8" },
	},
	lua_ls = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
	rust_analyzer = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
	pyright = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
	ccls = {
		init_options = {
			index = {
				threads = 2,
			},
		},
	},
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(set_ups[lsp])
end
