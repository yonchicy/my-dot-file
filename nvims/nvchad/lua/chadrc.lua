local M = {}


M.base46 = {
  theme = "ayu_light",
  theme_toggle = { "ayu_light", "onedark" },
  transparency = false,
  hl_override = {
    LspInlayHint = {
      bg = "one_bg2",
    }
  }
}

M.nvdash = {
  load_on_startup = true,
}
M.ui = {

  telescope = { style = "bordered" },    -- borderless / bordered
}
return M
