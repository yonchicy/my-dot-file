local M = {}
local configure_vscode = function()
  -- setup dap config by VsCode launch.json file
  local vscode = require("dap.ext.vscode")
  local json = require("plenary.json")
  vscode.json_decode = function(str)
    return vim.json.decode(json.json_strip_comments(str))
  end
  vscode.load_launchjs(nil, { codelldb = { "c", "cpp", "rust" } })
end

local configure_exts = function()
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

local config_languages = function()
  local dap = require("dap")

  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = 'executable',
    command = vim.fn.stdpath "data" .. "/mason/bin/OpenDebugAD7",
  }
  dap.adapters.lldb = {
    type = 'server',
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
  }
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
  }
end


M.keys = {
  { "<leader>d",  "",                                                                                   desc = "+debug",                 mode = { "n", "v" } },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
  { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
  { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
  { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
  { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
  { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
  { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
  { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
  { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
  { "<leader>dO", function() require("dap").step_out() end,                                             desc = "finish" },
  { "<leader>do", function() require("dap").step_over() end,                                            desc = "next line" },
  { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
  { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
  { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
  { "<leader>dh", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  {
    "<leader>dt",
    function()
      require("dap").terminate()
      require("dapui").close()
    end,
    desc = "Terminate"
  },

  { "<f12>", function() require("dap").step_out() end,          desc = "finish" },
  { "<f10>", function() require("dap").step_over() end,         desc = "next line" },
  { "<f11>", function() require("dap").step_into() end,         desc = "Step Into" },
  { "<f9>",  function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<f5>",  function() require("dap").continue() end,          desc = "Run/Continue" },
  {
    "<f4>",
    function()
      require("dap").terminate()
      require("dapui").close()
    end,
    desc = "Terminate"
  },
  { "<f12>", function() require("dap").step_out() end,          mode = "i", desc = "finish" },
  { "<f10>", function() require("dap").step_over() end,         mode = "i", desc = "next line" },
  { "<f11>", function() require("dap").step_into() end,         mode = "i", desc = "Step Into" },
  { "<f9>",  function() require("dap").toggle_breakpoint() end, mode = "i", desc = "Toggle Breakpoint" },
  { "<f5>",  function() require("dap").continue() end,          mode = "i", desc = "Run/Continue" },
  {
    "<f4>",
    function()
      require("dap").terminate()
      require("dapui").close()
    end,
    mode = "i",
    desc = "Terminate"
  },
}


M.config = function()
  -- load mason-nvim-dap here, after all adapters have been setup

  dofile(vim.g.base46_cache .. "dap")
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  configure_vscode()
  configure_exts()
  config_languages()
end

M.dap_ui_opts = {
  expand_lines = true,
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
        { id = "scopes",      size = 0.40 },
        { id = "watches",     size = 0.23 },
        { id = "stacks",      size = 0.24 },
        { id = "breakpoints", size = 0.13 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl",    size = 0.55 },
        { id = "console", size = 0.45 },
      },
      size = 0.27,
      position = "bottom",
    }
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5,
    border = vim.g.border_chars,
    mappings = {
      close = { "q", "<Esc>" },
    }
  }
}

return M
