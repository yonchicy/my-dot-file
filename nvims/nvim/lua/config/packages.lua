local M = {}

function M.setup()
  if not vim.pack or not vim.pack.add then
    vim.notify("Neovim 0.12's vim.pack is unavailable; plugins were not loaded.", vim.log.levels.ERROR)
    return false
  end

  local ok, err = pcall(vim.pack.add, {
    {
      src = "https://github.com/nvim-mini/mini.nvim",
      version = "stable",
    },
  }, {
    confirm = false,
    load = true,
  })

  if not ok then
    vim.schedule(function()
      vim.notify("Could not load mini.nvim: " .. tostring(err), vim.log.levels.ERROR)
    end)
    return false
  end

  return true
end

return M
