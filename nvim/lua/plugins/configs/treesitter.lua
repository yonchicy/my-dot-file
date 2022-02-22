local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
   return
end

local default = {
   ensure_installed = {
      "lua",
      "vim",
      "cpp",
      "c",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   rainbow ={
       enable = true,
       extended_mode = true,
       max_file_lines  = 500,
   }
}

local M = {}
M.setup = function()
   ts_config.setup(default)
end

return M
