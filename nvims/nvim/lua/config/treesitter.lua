local M = {}
local install_dir = vim.fn.stdpath("config") .. "/.treesitter"

local function enable_highlighting(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype == "" then
    return
  end

  local lang = vim.treesitter.language.get_lang(filetype)
  if not lang then
    return
  end

  local _, parser_loaded = pcall(vim.treesitter.language.add, lang)
  if not parser_loaded then
    return
  end

  -- Tree-sitter is a built-in Neovim highlighter and does not require LSP.
  pcall(vim.treesitter.start, bufnr, lang)
end

function M.setup()
  local has_treesitter, treesitter = pcall(require, "nvim-treesitter")
  if has_treesitter then
    -- Parser artifacts are local generated state, not files to commit with this config.
    treesitter.setup({ install_dir = install_dir })
  end

  -- Shell buffers use the `sh` filetype while nvim-treesitter's parser is `bash`.
  vim.treesitter.language.register("bash", { "sh" })

  local group = vim.api.nvim_create_augroup("ConfigTreeSitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      enable_highlighting(args.buf)
    end,
  })

  -- Also cover buffers that already had a filetype when this module is reloaded.
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      enable_highlighting(bufnr)
    end
  end
end

return M
