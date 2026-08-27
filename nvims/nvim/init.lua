if vim.fn.has("nvim-0.12") == 0 then
  vim.api.nvim_err_writeln("This configuration requires Neovim 0.12 or newer.")
  return
end

local local_config = require("config.local")
vim.g.workbench_icon_style = local_config.icon_style or "ascii"

require("config.options")
require("config.packages").setup()
require("config.treesitter").setup()
require("workbench").setup(local_config.workbench or {})
require("config.mini").setup()
require("config.keymaps")
