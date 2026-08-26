local map = vim.keymap.set

local function pick(method)
  return function()
    local ok, mini_pick = pcall(require, "mini.pick")
    if not ok then
      vim.notify("mini.pick is not available", vim.log.levels.WARN)
      return
    end
    mini_pick.builtin[method]()
  end
end

local function mini_files()
  local ok, files = pcall(require, "mini.files")
  if not ok then
    vim.notify("mini.files is not available", vim.log.levels.WARN)
    return nil
  end
  return files
end

local function current_file_or_cwd()
  local path = vim.api.nvim_buf_get_name(0)
  -- Do not pass special buffers such as `term://` to mini.files as paths.
  if vim.bo.buftype == "" and path ~= "" and vim.uv.fs_stat(path) then
    return path
  end
  return vim.fn.getcwd()
end

-- Search
map("n", "<leader>ff", pick("files"), { desc = "Find files" })
map("n", "<leader>fg", pick("grep_live"), { desc = "Find text" })
map("n", "<leader>fb", pick("buffers"), { desc = "Find buffers" })

-- File explorer
map("n", "<leader>e", function()
  local files = mini_files()
  if files and files.close() == nil then
    files.open(current_file_or_cwd(), false)
  end
end, { desc = "Toggle file explorer" })
map("n", "<leader>E", function()
  local files = mini_files()
  if files then
    files.open(vim.fn.getcwd(), false)
  end
end, { desc = "Browse working directory" })

-- Terminal workbench
map("n", "<leader>tn", function()
  require("workbench").new_interactive()
end, { desc = "New terminal" })
map("n", "<leader>tc", function()
  require("workbench").new_codex_interactive()
end, { desc = "New Codex terminal" })
map("n", "<leader>tl", function()
  require("workbench").select_session()
end, { desc = "List terminal sessions" })
map("n", "<leader>tt", function()
  require("workbench").toggle_last()
end, { desc = "Toggle last terminal" })
map("n", "<leader>th", function()
  vim.cmd("AgentTermHide")
end, { desc = "Hide terminal" })
map("n", "<leader>ts", function()
  require("workbench").open_current_or_select("split")
end, { desc = "Open terminal in split" })
map("n", "<leader>tf", function()
  require("workbench").open_current_or_select("float")
end, { desc = "Open terminal in float" })
map("n", "<leader>to", function()
  require("workbench").open_current_or_select("tab")
end, { desc = "Open terminal in tab" })
map("n", "<leader>tx", function()
  require("workbench").stop_current_or_select()
end, { desc = "Stop terminal" })
