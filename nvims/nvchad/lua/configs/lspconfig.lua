-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright" }

local clangd_cap = capabilities
clangd_cap.offsetEncoding='utf-16'
local set_ups = {
	clangd = {
		on_attach = on_attach,
    on_init = on_init,
		capabilities = clangd_cap,
		cmd = { "clangd", "--header-insertion=never", "-j=8" },
	},
	lua_ls = {
		on_attach = on_attach,
    on_init = on_init,
		capabilities = capabilities,
	},
	rust_analyzer = {
		on_attach = on_attach,
    on_init = on_init,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					allTargets = false,
					extraArgs = { "--bins" },
				},
				cargo = {
					target =  "aarch64-unknown-none-softfloat" ,
					features = { "bsp_rpi3" },
				},
				lens = {
					debug = false,
					run = false,
				},
			},
		},
	},
	pyright = {
		on_attach = on_attach,
    on_init=on_init,
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
-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(set_ups[lsp])

end


