-- credit to original theme for existing : https://github.com/kdheepak/monochrome.nvim
-- NOTE: This is a modified version of it

local M = {}

M.base_30 = {
  white = "#D8DEE9",
  darker_black = "#1a1a1a",
  black = "#101010", --  nvim bg
  black2 = "#202020",
  one_bg = "#242424",
  one_bg2 = "#2e2e2e",
  one_bg3 = "#383838",
  grey = "#424242",
  grey_fg = "#4c4c4c",
  grey_fg2 = "#606060",
  light_grey = "#677777",
  red = "#2e2e2e",
  baby_pink = "#2e2e2e",
  pink = "#2e2e2e",
  line = "#2e2e2e", -- for lines like vertsplit
  green = "#2e2e2e",
  vibrant_green = "#2e2e2e",
  blue = "#2e2e2e",
  nord_blue = "#2e2e2e",
  yellow = "#2e2e2e",
  sun = "#2e2e2e",
  purple = "#2e2e2e",
  dark_purple = "#2e2e2e",
  teal = "#2e2e2e",
  orange = "#2e2e2e",
  cyan = "#2e2e2e",
  statusline_bg = "#1e1e1e",
  lightbg = "#2e2e2e",
  pmenu_bg = "#2e2e2e",
  folder_bg = "#2e2e2e",
}

M.base_16 = {
  base00 = "#101010",
  base01 = "#1f1f1f",
  base02 = "#2e2e2e",
  base03 = "#2e2e2e",
  base04 = "#2e2e2e",
  base05 = "#2e2e2e",
  base06 = "#2e2e2e",
  base07 = "#2e2e2e",
  base08 = "#2e2e2e",
  base09 = "#2e2e2e",
  base0A = "#2e2e2e",
  base0B = "#2e2e2e",
  base0C = "#2e2e2e",
  base0D = "#2e2e2e",
  base0E = "#2e2e2e",
  base0F = "#2e2e2e",
}

M.polish_hl = {
  treesitter = {
    ["@punctuation.bracket"] = { fg = M.base_30.red },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "monochrome")

return M
