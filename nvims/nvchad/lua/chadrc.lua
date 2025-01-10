local M = {}


M.base46 = {
  theme = "onenord",
  theme_toggle = { "everforest_light", "onenord" },
  transparency = false,
  integrations = { "dap" },
  hl_override = {
    LspInlayHint = {
      bg = "one_bg2",
    },
    Comment = {
      italic = true,
    },
    SepicalComment = {
      italic = true,
    },
    ['@comment'] = {
      italic = true,
    },
  }
}

M.nvdash = {
  load_on_startup = true,
  buttons = {
--   
--   
--   
--   
--   

    { txt = "   Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "   Recent projects", keys = "fp", cmd = "Telescope workspaces" },
    { txt = "󰈭   Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚   Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "   Mappings", keys = "ch", cmd = "NvCheatsheet" },
    -- { keys = "s", cmd = ":lua require('persistence').load()", txt = "Restore Session" },
    -- { keys = "S", cmd = ":lua require('persistence').select()", txt = "Select Session" },
    -- { keys = "l", cmd = ":lua require('persistence').load({ last = true })", txt = "Restore Last Session" },
    -- { keys = "d", cmd = ":lua require('persistence').stop()", txt = "Don't Save Current Session" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {

  telescope = { style = "bordered" }, -- borderless / bordered
}

M.lsp = {
  signature = true,
}
return M
