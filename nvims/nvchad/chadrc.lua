---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme_toggle = { "github_light", "gruvchad" },
  theme = "gruvchad",
  hl_override = highlights.override,
  hl_add = highlights.add,

  transparency = false,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
