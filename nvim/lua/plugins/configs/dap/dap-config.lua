local M = {}
M.dap_install =  function ()
    local dap_install_default = {
        installation_path = vim.fn.stdpath "data" .. "/dapinstall/"
    }
    local present, dap_install = pcall(require, "dap-install")

    if not present then
        return
    end
    dap_install.setup(
        dap_install_default
    )
end

local function set_dap_sign()
    local present, dap = pcall(require, "dap")

    if not present then
        return
    end

    local dap_breakpoint = {
        active = false,
        on_config_done = nil,
        breakpoint = {
            text = "",
            texthl = "LspDiagnosticsSignError",
            linehl = "",
            numhl = "",
        },
        breakpoint_rejected = {
            text = "",
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = "",
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }
    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
end
local dapui_default = (
{
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    sidebar = {
        -- You can change the order of elements in the sidebar
        elements = {
            -- Provide as ID strings or tables with "id" and "size" keys
            { id = "watches", size = 0.15 },
            { id = "stacks", size = 0.35 },
            {
                id = "scopes",
                size = 0.35, -- Can be float or integer > 1
            },
            -- { id = "breakpoints", size = 0.15 },
        },
        size = 40,
        position = "left", -- Can be "left", "right", "top", "bottom"
    },
    tray = {
        elements = { "repl" },
        size = 5,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
}
)
M.config_dapui=function ()
    local present1,dapui=pcall(require,"dapui")
    local present2,dap=pcall(require,"dap")
    if not present1 then
        print("not find dapui")
    end
    if not present2 then
        print("not find dap")
    end
    dapui.setup(dapui_default)
    dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
        vim.api.nvim_command("DapVirtualTextEnable")
    end
    dap.listeners.before.event_terminated["dapui_config"] = function ()
        vim.api.nvim_command("DapVirtualTextDisable")
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function ()
        vim.api.nvim_command("DapVirtualTextDisable")
        dapui.close()
    end
    dap.listeners.before.disconnect["dapui_config"] = function ()
        vim.api.nvim_command("DapVirtualTextDisable")
        dapui.close()
    end
    dap.defaults.fallback.terminal_win_cmd = "20vsplit new"
end
local function config_debuggers()
    require("plugins.configs.dap.dap-cpp")
end


M.setup = function()
    set_dap_sign()
    config_debuggers()
end

return M
