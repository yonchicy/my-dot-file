local M = {}
local install_dir = vim.fn.stdpath("config") .. "/.treesitter"

-- Parsers that are installed automatically when missing. Shell scripts use
-- the `sh` filetype, which is mapped to the `bash` parser below.
local ensure_languages = { "java", "cpp", "bash" }

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

-- Install any missing parsers in the background and (re)enable highlighting
-- for already-open buffers once they are available.
local function ensure_parsers(treesitter)
  -- The installer shells out to the `tree-sitter` CLI; make user-managed bin
  -- directories discoverable without depending on the login shell's PATH.
  for _, extra_bin in ipairs({ vim.fn.expand("~/tools/bin"), vim.fn.expand("~/.cargo/bin") }) do
    if vim.fn.isdirectory(extra_bin) == 1 and not vim.env.PATH:find(extra_bin, 1, true) then
      vim.env.PATH = extra_bin .. ":" .. vim.env.PATH
    end
  end

  local installed = {}
  for _, lang in ipairs(treesitter.get_installed("parsers")) do
    installed[lang] = true
  end

  local missing = vim.tbl_filter(function(lang)
    return not installed[lang]
  end, ensure_languages)

  if #missing == 0 then
    return
  end

  vim.notify(
    "[treesitter] installing parsers: " .. table.concat(missing, ", ") .. " (needs the tree-sitter CLI)",
    vim.log.levels.INFO
  )

  local task = treesitter.install(missing, { summary = true })
  if task and task.await then
    task:await(function(err, success)
      vim.schedule(function()
        if err or not success then
          vim.notify(
            "[treesitter] parser install failed; install the tree-sitter CLI (e.g. cargo install tree-sitter-cli) and restart nvim.",
            vim.log.levels.WARN
          )
          return
        end

        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(bufnr) then
            enable_highlighting(bufnr)
          end
        end
      end)
    end)
  end
end

function M.setup()
  local has_treesitter, treesitter = pcall(require, "nvim-treesitter")
  if has_treesitter then
    -- Parser artifacts are local generated state, not files to commit with this config.
    treesitter.setup({ install_dir = install_dir })
    ensure_parsers(treesitter)
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
