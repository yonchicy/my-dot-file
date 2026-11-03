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

local function setup_tabline_highlights()
  local function set_highlights()
    local set_hl = vim.api.nvim_set_hl

    -- The active buffer is both reversed and marked in the formatter below;
    -- visible buffers no longer share its highlight group.
    set_hl(0, "MiniTablineCurrent", { bold = true, reverse = true })
    set_hl(0, "MiniTablineVisible", { link = "TabLine" })
    set_hl(0, "MiniTablineHidden", { link = "TabLine" })
    set_hl(0, "MiniTablineModifiedCurrent", { bold = true, reverse = true, underline = true })
    set_hl(0, "MiniTablineModifiedVisible", { link = "StatusLine" })
    set_hl(0, "MiniTablineModifiedHidden", { link = "StatusLineNC" })
    set_hl(0, "MiniTablineFill", { link = "TabLineFill" })
    set_hl(0, "MiniTablineTrunc", { link = "TabLine" })
  end

  local group = vim.api.nvim_create_augroup("ConfigTablineHighlights", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = set_highlights })
  set_highlights()
end

function M.setup()
  setup_module("mini.icons", { style = vim.g.workbench_icon_style or "glyph" })
  setup_module("mini.notify", {
    lsp_progress = { enable = false },
    window = { winblend = 0 },
  })
  setup_module("mini.files", {
    options = {
      -- Keep accidental line deletions recoverable from mini.files' trash.
      permanent_delete = false,
    },
    windows = {
      preview = true,
      width_preview = 50,
    },
  })
  setup_module("mini.pick", {})
  if setup_module("mini.tabline", {
    show_icons = true,
    tabpage_section = "right",
    format = function(buf_id, label)
      local tabline = require("mini.tabline")
      local marker = buf_id == vim.api.nvim_get_current_buf() and " ▌" or " │"
      local rendered = require("workbench").format_tab(buf_id, tabline.default_format(buf_id, label))
      return marker .. rendered
    end,
  }) then
    setup_tabline_highlights()
  end
end

return M
