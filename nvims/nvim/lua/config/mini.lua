local M = {}

local function setup_module(name, opts)
  local ok, module = pcall(require, name)
  if not ok then
    vim.schedule(function()
      vim.notify("Optional module unavailable: " .. name, vim.log.levels.WARN)
    end)
    return false
  end

  module.setup(opts or {})
  return true
end

function M.setup()
  -- ASCII is the safe default. Set `vim.g.workbench_icon_style = "glyph"`
  -- before loading this config if the terminal uses a Nerd Font.
  setup_module("mini.icons", { style = vim.g.workbench_icon_style or "ascii" })
  setup_module("mini.notify", {
    lsp_progress = { enable = false },
    window = { winblend = 0 },
  })
  setup_module("mini.pick", {})
  setup_module("mini.tabline", {
    show_icons = true,
    tabpage_section = "right",
    format = function(buf_id, label)
      local tabline = require("mini.tabline")
      return require("workbench").format_tab(buf_id, tabline.default_format(buf_id, label))
    end,
  })
end

return M
