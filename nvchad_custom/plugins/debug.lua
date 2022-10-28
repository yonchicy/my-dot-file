local M = {}
local function set_dap_sign()
	local present, dap = pcall(require, "dap")

	if not present then
		return
	end

	local dap_breakpoint = {
		breakpoint = {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		},
		breakpoint_rejected = {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = "",
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		},
		-- ui = {
		--   auto_open = true,
		-- },
	}
	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.breakpoint_rejected)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
end
local dapui_default = {
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.33 },
				{ id = "breakpoints", size = 0.17 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 0.45 },
				{ id = "console", size = 0.55 },
			},
			size = 0.27,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
}
M.setup_ui = function()
	local present1, dapui = pcall(require, "dapui")
	local present2, dap = pcall(require, "dap")
	if not present1 then
		print("not find dapui")
	end
	if not present2 then
		print("not find dap")
	end
	dapui.setup(dapui_default)
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
		-- vim.api.nvim_command("DapVirtualTextEnable")
	end
	-- dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 	-- vim.api.nvim_command("DapVirtualTextDisable")
	-- 	dapui.close()
	-- end
	-- dap.listeners.before.event_exited["dapui_config"] = function()
	-- 	-- vim.api.nvim_command("DapVirtualTextDisable")
	-- 	dapui.close()
	-- end
	-- dap.listeners.before.disconnect["dapui_config"] = function()
	-- 	-- vim.api.nvim_command("DapVirtualTextDisable")
	-- 	dapui.close()
	-- end
	-- dap.defaults.fallback.terminal_win_cmd = "20vsplit new"
end
local function config_debuggers()
	require("custom.plugins.dap_config.dap-cpp")
end

M.setup = function()
	set_dap_sign()
	config_debuggers()
end

return M
