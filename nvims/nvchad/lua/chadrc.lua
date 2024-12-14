local M = {}


M.base46 = {
  theme = "everforest_light",
  theme_toggle = { "everforest_light", "gruvchad" },
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
  -- buttons = {
  --   { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
  --   { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
  -- { txt = "  Recent Files", keys = "Spc q s",  cmd = "lua require('persistence').load() " },
  -- more... check nvconfig.lua file for full list of buttons
  -- },
}
M.ui = {

  telescope = { style = "bordered" }, -- borderless / bordered
}

M.lsp = {
  signature = true,
}
return M
