

local M = {}

M.base_30 = {
  white = "#2a2929",
  darker_black = "#f7f4e9",
  black = "#FFFCF0", --  nvim bg
  black2 = "#f2efe4",
  one_bg = "#ebe8dd", -- real bg of onedark
  one_bg2 = "#d6d4ca",
  one_bg3 = "#c7c5bb",
  grey = "#b8b5ad",
  grey_fg = "#adaba3",
  grey_fg2 = "#a3a19a",
  light_grey = "#94928b",
  red = "#2a2929",
  baby_pink = "#2a2929",
  pink = "#2a2929",
  line = "#d6d4ca", -- for lines like vertsplit
  green = "#2a2929",
  vibrant_green = "#2a2929",
  nord_blue = "#2a2929",
  blue = "#2a2929",
  yellow = "#2a2929",
  sun = "#2a2929",
  purple = "#2a2929",
  dark_purple = "#2a2929",
  teal = "#2a2929",
  orange = "#2a2929",
  cyan = "#2a2929",
  statusline_bg = "#ebe8dd",
  lightbg = "#ebe8dd",
  pmenu_bg = "#2a2929",
  folder_bg = "#6F6E69",
}

M.base_16 = {
  base00 = M.base_30.black,
  base01 = M.base_30.black2,
  base02 = M.base_30.one_bg,
  base03 = M.base_30.grey,
  base04 = M.base_30.grey_fg,
  base05 = M.base_30.white,
  base06 = "#b6bdca",
  base07 = "#c8ccd4",
  base08 = M.base_30.red,
  base09 = M.base_30.orange,
  base0A = M.base_30.purple,
  base0B = M.base_30.green,
  base0C = M.base_30.cyan,
  base0D = M.base_30.blue,
  base0E = M.base_30.yellow,
  base0F = M.base_30.teal,
}

M.polish_hl = {
  syntax = {
    Keyword = { fg = M.base_30.cyan },
    Include = { fg = M.base_30.yellow },
    Tag = { fg = M.base_30.blue },
  },
  treesitter = {
    ["@keyword"] = { fg = M.base_30.cyan },
    ["@variable.parameter"] = { fg = M.base_30.pink },
    ["@tag.attribute"] = { fg = M.base_30.orange },
    ["@tag"] = { fg = M.base_30.blue },
    ["@string"] = { fg = M.base_30.green },
    ["@string.special.url"] = { fg = M.base_30.green },
    ["@markup.link.url"] = { fg = M.base_30.green },
    ["@punctuation.bracket"] = { fg = M.base_30.yellow },
  },

  telescope = {
    TelescopeMatching = { fg = M.base_30.dark_purple, bg = M.base_30.one_bg },
  },
}

M.type = "light"

M = require("base46").override_theme(M, "monochrome-light")

return M
